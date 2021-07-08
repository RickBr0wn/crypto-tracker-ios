//
//  HomeView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 19/06/2021.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var vm: HomeViewModel
  @State private var showPortfolio: Bool = false // animate left
  @State private var showPortfolioView: Bool = false // animate right
  
  var body: some View {
    ZStack {
      Color.theme.background
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showPortfolioView, content: {
          PortfolioView()
            .environmentObject(vm)
        })
      
      VStack {
        homeHeader
        HomeStatsView(showPortfolio: $showPortfolio)
        SearchBarView(searchText: $vm.searchText)
        columnTitles
        if !showPortfolio {
          allOfTheCoinsList
            .transition(.move(edge: .leading))
        }
        if showPortfolio {
          allOfThePortfolioCoinsList
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
        .onTapGesture {
          if showPortfolio {
            showPortfolioView.toggle()
          }
        }
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
      HStack(spacing: 4) {
        Text("Coin")
        Image(systemName: "chevron.down")
          .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
          .rotationEffect(Angle(degrees: vm.sortOption == .rank ?  0 : 180))
      }
      .onTapGesture {
        withAnimation(.default) {
          vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
        }
      }
      
      Spacer()
      if showPortfolio {
        HStack {
          Text("Holdings")
          Image(systemName: "chevron.down")
            .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
            .rotationEffect(Angle(degrees: vm.sortOption == .holdings ?  0 : 180))
        }
        .onTapGesture {
          withAnimation(.default) {
            vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
          }
        }
      }
      HStack {
        Text("Price")
          .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        Image(systemName: "chevron.down")
          .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
          .rotationEffect(Angle(degrees: vm.sortOption == .price ?  0 : 180))
      }
      .onTapGesture {
        withAnimation(.default) {
          vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
        }
      }
      
      Button(action: {
        withAnimation(.linear(duration: 2.0)) {
          vm.reloadData()
        }
      }, label: {
        Image(systemName: "goforward")
      })
      .rotationEffect(Angle(degrees: vm.isLoading ? 180 : 0), anchor: .center)
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
