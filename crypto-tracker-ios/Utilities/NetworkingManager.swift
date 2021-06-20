//
//  NetworkingManager.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import Foundation
import Combine

class NetworkingManager {
  enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
      switch self {
      case .badURLResponse(url: let url):
        return "[❌] Bad response from URL. \(url)"
      case .unknown:
        return "[⁉️] An unknown error occured."
      }
    }
  }
  
  static func download(_ url: URL) -> AnyPublisher<Data, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .tryMap({ try handleURLResponse(from: $0, url: url) })
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  static func handleURLResponse(from output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data  {
    guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
      throw NetworkingError.badURLResponse(url: url)
    }
    return output.data
  }
  
  static func handleCompletion(completion: Subscribers.Completion<Error>) {
    switch completion {
    case .finished:
      break
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}
