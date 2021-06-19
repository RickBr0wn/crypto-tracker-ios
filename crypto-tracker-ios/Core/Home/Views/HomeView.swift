//
//  HomeView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 19/06/2021.
//

import SwiftUI

struct HomeView: View {
  @State private var showPortfolio: Bool = false
  
  var body: some View {
    ZStack {
      Color.theme.background
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        homeHeader
        Spacer(minLength: 0)
      }
    }
  }
}

extension HomeView {
  private var homeHeader: some View {
    HStack {
      CircleButtonView(iconName: showPortfolio ? "plus" : "info")
        .animation(.none)
        .background(CircleButtonAnimationView(animate: $showPortfolio))
      Spacer()
      Text(showPortfolio ? "Portfolio" : "Live Prices")
        .animation(.none)
      Spacer()
      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()) {
            showPortfolio.toggle()
          }
        }
    }
    .padding(.horizontal)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
          .preferredColorScheme(.dark)
      }
      
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
      }
    }
  }
}
