//
//  HomeView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 19/06/2021.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var vm: HomeViewModel
  @State private var showPortfolio: Bool = false
  
  var body: some View {
    ZStack {
      Color.theme.background
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        homeHeader
        SearchBarView(searchText: $vm.searchText)
        columnTitles
        if !showPortfolio {
          allOfTheCoinsList
            .transition(.move(edge: .leading))
        }
        if showPortfolio {
          allOfTheCoinsList
            .transition(.move(edge: .trailing))
        }
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
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(.theme.accent)
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
  
  private var allOfTheCoinsList: some View {
    List {
      ForEach(vm.allOfTheCoins) { coin in
        CoinRowView(coin: coin, showHoldingColumn: false)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  
  private var allOfThePortfolioCoinsList: some View {
    List {
      ForEach(vm.portfolioCoins) { coin in
        CoinRowView(coin: coin, showHoldingColumn: true)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  
  private var columnTitles: some View {
    HStack {
      Text("Coin")
      Spacer()
      if showPortfolio {
        Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    .font(.caption)
    .foregroundColor(.theme.secondaryText)
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
      .environmentObject(dev.homeVM)
      
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
      }
      .environmentObject(dev.homeVM)
    }
  }
}
