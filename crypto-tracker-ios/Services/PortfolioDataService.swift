//
//  PortfolioDataService.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 22/06/2021.
//

import Foundation
import CoreData

class PortfolioDataService {
  private let container: NSPersistentContainer
  private let containerName: String = "PortfolioContainer"
  private let entityName: String = "PortfolioEntity"
  
  @Published var savedEntities: Array<PortfolioEntity> = []
  
  init() {
    self.container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { (_, error) in
      if let error = error {
        print("[😱] Error whilst loading form CoreData. Error: \(error)")
      }
    }
    self.getPortfolioFromCoreData()
  }
  
  func updatePortfolio(coin: CoinModel, amount: Double) {
    if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
      if amount > 0 {
        updateTheEntity(entity, amount: amount)
      } else {
        removeTheEntityFromCoreData(entity)
      }
    } else {
      addCoinToPortfolio(coin: coin, amount: amount)
    }
  }
  
  private func getPortfolioFromCoreData() {
    let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
    do {
      savedEntities = try container.viewContext.fetch(request)
    } catch let error {
      print("[😱] Error fetching Portfolio Entities. Error: \(error)")
    }
  }
  
  private func addCoinToPortfolio(coin: CoinModel, amount: Double) {
    let entity = PortfolioEntity(context: container.viewContext)
    entity.coinId = coin.id
    entity.amount = amount
    applyChangesToCoreData()
  }
  
  private func saveContextToCoreData() {
    do {
      try container.viewContext.save()
    } catch let error {
      print("[⁉️] Error whilst saving with Core Data. Error: \(error)")
    }
  }
  
  private func applyChangesToCoreData() {
    saveContextToCoreData()
    getPortfolioFromCoreData()
  }
  
  private func updateTheEntity(_ entity: PortfolioEntity, amount: Double) {
    entity.amount = amount
    applyChangesToCoreData()
  }

  private func removeTheEntityFromCoreData(_ entity: PortfolioEntity) {
    container.viewContext.delete(entity)
    applyChangesToCoreData()
  }
}
