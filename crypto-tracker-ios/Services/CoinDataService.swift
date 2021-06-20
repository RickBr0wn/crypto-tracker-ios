//
//  CoinDataService.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import Foundation
import Combine

class CoinDataService {
  @Published var allOfTheCoins: Array<CoinModel> = []
  var coinSubscription: AnyCancellable?
  
  init() {
    getAllOfTheCoins()
  }
  
  private func getAllOfTheCoins() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
    
    coinSubscription = NetworkingManager.download(url)
      .decode(type: Array<CoinModel>.self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
        self?.allOfTheCoins = returnedCoins
        self?.coinSubscription?.cancel()
      })
  }
}
