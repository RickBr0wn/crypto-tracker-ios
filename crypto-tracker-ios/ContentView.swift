//
//  ContentView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 19/06/2021.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      Color.theme.background
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        Text("Accent Color")
          .foregroundColor(.theme.accent)
        
        Text("SecondaryTextColor")
          .foregroundColor(.theme.secondaryText)
      
        Text("Green")
          .foregroundColor(.theme.green)
        
        Text("Red")
          .foregroundColor(.theme.red)
      }
      .font(.headline)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
        .preferredColorScheme(.dark)
      
      ContentView()
    }
  }
}
