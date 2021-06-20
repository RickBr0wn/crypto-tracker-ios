//
//  HomeViewModel.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  @Published var statistics: Array<StatisticModel> = [
    StatisticModel(title: "Title", value: "Value", percentageChange: 1),
    StatisticModel(title: "Title", value: "Value"),
    StatisticModel(title: "Title", value: "Value"),
    StatisticModel(title: "Title", value: "Value", percentageChange: -12.31),
  ]
  
  @Published var allOfTheCoins: Array<CoinModel> = []
  @Published var portfolioCoins: Array<CoinModel> = []
  
  @Published var searchText: String = ""
  
  private let dataService = CoinDataService()
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    $searchText
      .combineLatest(dataService.$allOfTheCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filteredCoins)
      .sink { [weak self] returnedCoins in
        self?.allOfTheCoins = returnedCoins
      }
      .store(in: &cancellables)
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
}
