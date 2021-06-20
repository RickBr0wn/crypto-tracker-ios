//
//  StatisticModel.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import Foundation

struct StatisticModel: Identifiable {
  let id = UUID().uuidString
  let title: String
  let value: String
  let percentageChange: Double?
  
  init(title: String, value: String, percentageChange: Double? = nil) {
    self.title = title
    self.value = value
    self.percentageChange = percentageChange
  }
}
