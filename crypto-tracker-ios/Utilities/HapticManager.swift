//
//  HapticManager.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 24/06/2021.
//

import Foundation
import SwiftUI

class HapticManager {
  static private let generator = UINotificationFeedbackGenerator()
  
  static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    generator.notificationOccurred(type)
  }
}
