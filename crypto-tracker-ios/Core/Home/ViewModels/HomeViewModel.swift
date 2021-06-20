//
//  HomeViewModel.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var allOfTheCoins: Array<CoinModel> = []
  @Published var portfolioCoins: Array<CoinModel> = []
  
  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      self.allOfTheCoins.append(DeveloperPreview.instance.coin)
      self.portfolioCoins.append(DeveloperPreview.instance.coin)
    }
  }
}
