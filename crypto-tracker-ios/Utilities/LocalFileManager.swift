//
//  LocalFileManager.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import Foundation
import SwiftUI

class LocalFileManager {
  static let instance = LocalFileManager()
  /// This empty private init prevents another LocalFileManager instance to be created elsewhere
  private init() {}
  
  func saveImage(image: UIImage, imageName: String, folderName: String) {
    createFolderIfNeeded(folderName: folderName)
    
    guard
      let data = image.pngData(),
      let url = getURLForImage(imageName: imageName, folderName: folderName)
    else { return }
    
    do {
      try data.write(to: url)
    } catch let error {
      print("[⛔️] Error saving image. Image Name: \(imageName). Error: \(error)")
    }
  }
  
  func getImage(imageName: String, folderName: String) -> UIImage? {
    guard let url = getURLForImage(imageName: imageName, folderName: folderName),
          FileManager.default.fileExists(atPath: url.path) else { return nil }
    return UIImage(contentsOfFile: url.path)
  }
  
  private func createFolderIfNeeded(folderName: String) {
    guard let url = getUrlForFolder(folderName: folderName) else { return }
    if !FileManager.default.fileExists(atPath: url.path) {
      do {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
      } catch let error {
        print("[⚠️] Error creating the directory with FileManger. Folder Name: \(folderName). Error: \(error)")
      }
    }
  }
  
  private func getUrlForFolder(folderName: String) -> URL? {
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
    return url.appendingPathComponent(folderName)
  }
  
  private func getURLForImage(imageName: String, folderName: String) -> URL? {
    guard let folderURL = getUrlForFolder(folderName: folderName) else { return nil }
    return folderURL.appendingPathComponent(imageName + ".png")
  }
}
