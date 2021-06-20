//
//  HomeViewModel.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  @Published var allOfTheCoins: Array<CoinModel> = []
  @Published var portfolioCoins: Array<CoinModel> = []
  
  @Published var searchText: String = ""
  
  private let dataService = CoinDataService()
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    dataService.$allOfTheCoins
      .sink { [weak self] returnedCoins in
        self?.allOfTheCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
}
