//
//  crypto_tracker_iosApp.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 19/06/2021.
//

import SwiftUI

@main
struct crypto_tracker_iosApp: App {
  @StateObject private var vm = HomeViewModel()
  
  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
  }
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
      }
      .environmentObject(vm)
    }
  }
}
