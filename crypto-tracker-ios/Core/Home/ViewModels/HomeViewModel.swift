//
//  HomeViewModel.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  @Published var statistics: Array<StatisticModel> = []
  
  @Published var allOfTheCoins: Array<CoinModel> = []
  @Published var portfolioCoins: Array<CoinModel> = []
  
  @Published var searchText: String = ""
  
  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    $searchText
      .combineLatest(coinDataService.$allOfTheCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filteredCoins)
      .sink { [weak self] returnedCoins in
        self?.allOfTheCoins = returnedCoins
      }
      .store(in: &cancellables)
    
    marketDataService.$marketData
      .map(mapGlobalMarketData)
      .sink { [weak self] returnedStats in
        self?.statistics = returnedStats
      }
      .store(in: &cancellables)
    
    $allOfTheCoins
      .combineLatest(portfolioDataService.$savedEntities)
      .map { (coinModels, portfolioEntities) -> Array<CoinModel> in
        coinModels.compactMap { (coin) -> CoinModel? in
          guard let enitiy = portfolioEntities.first(where: { $0.coinId == coin.id }) else { return nil }
          return coin.updateHoldings(amount: enitiy.amount)
        }
      }
      .sink { [weak self] (returnedCoins) in
        self?.portfolioCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
  
  func updatePortfolio(coin: CoinModel, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }
  
  private func filteredCoins(text: String, coins: Array<CoinModel>) -> Array<CoinModel> {
    guard !text.isEmpty else {
      return coins
    }
    let lowercasedText = text.lowercased()
    return coins.filter { (coin) -> Bool in
      return
        coin.name.contains(lowercasedText) ||
        coin.symbol.contains(lowercasedText) ||
        coin.id.contains(lowercasedText)
    }
  }
  
  private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> Array<StatisticModel> {
    var stats: Array<StatisticModel> = []
    guard let data = marketDataModel else { return stats }
    let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    let volume = StatisticModel(title: "24hr Volume", value: data.volume)
    let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
    let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0.0)
    stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
    return stats
  }
}
