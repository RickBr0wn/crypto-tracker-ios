//
//  CoinImageService.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
  @Published var image: UIImage? = nil
  
  private var imageSubscription: AnyCancellable?
  private let coin: CoinModel
  private let fileManager = LocalFileManager.instance
  private let folderName = "coin_images"
  private let imageName: String
  
  init(coin: CoinModel) {
    self.coin = coin
    self.imageName = coin.id
    getCoinImage()
  }
  
  private func getCoinImage() {
    if let image = fileManager.getImage(imageName: imageName, folderName: folderName) {
      self.image = image
      print("image loaded from filemanager")
    } else {
      downloadCoinImage()
      print("image downloaded")
    }
  }
  
  private func downloadCoinImage() {
    guard let url = URL(string: coin.image) else { return }
    
    imageSubscription = NetworkingManager.download(url)
      .tryMap({ (data) -> UIImage? in
        return UIImage(data: data)
      })
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
        guard let self = self, let downloadedImage = returnedImage else { return }
        self.image = downloadedImage
        self.imageSubscription?.cancel()
        self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
      })
  }
}
