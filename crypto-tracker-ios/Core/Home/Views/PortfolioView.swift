//
//  PortfolioView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import SwiftUI

struct PortfolioView: View {
  @EnvironmentObject private var vm: HomeViewModel
  @State private var selectedCoin: CoinModel? = nil
  @State private var quantityText: String = ""
  @State private var showCheckmark: Bool = false
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          SearchBarView(searchText: $vm.searchText)
          coinLogoList
          if selectedCoin != nil {
            portfolioInputSection
          }
        }
      }
      .navigationTitle("Edit Portfolio")
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
          XMarkButton()
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          trailingNavBarButton
        }
      })
    }
  }
}

extension PortfolioView {
  private var coinLogoList: some View {
    ScrollView(.horizontal, showsIndicators: false, content: {
      LazyHStack(spacing: 10) {
        ForEach(vm.allOfTheCoins) { coin in
          CoinLogoView(coin: coin)
            .frame(width: 75)
            .padding(4)
            .onTapGesture {
              withAnimation(.easeIn) {
                selectedCoin = coin
              }
            }
            .background(RoundedRectangle(cornerRadius: 10.0).stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1.0))
        }
      }
      .frame(height: 120)
      .padding(.leading)
    })
  }
  
  private func getCurrentPortfolioValue() -> Double {
    if let quantity = Double(quantityText) {
      return quantity * (selectedCoin?.currentPrice ?? 0)
    }
    return 0
  }
  
  private var portfolioInputSection: some View {
    VStack(spacing: 20) {
      HStack {
        Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
        Spacer()
        Text(selectedCoin?.currentPrice.asCurrencyStringWithSixDecimalPlaces() ?? "")
      }
      Divider()
      HStack {
        Text("Amount Holding:")
        Spacer()
        TextField("eg: 1.4", text: $quantityText)
          .multilineTextAlignment(.trailing)
          .keyboardType(.decimalPad)
      }
      Divider()
      HStack {
        Text("Current Value:")
        Spacer()
        Text(getCurrentPortfolioValue().asCurrencyStringWithTwoDecimalPlaces())
      }
    }
    .animation(.none)
    .padding()
    .font(.headline)
  }
  
  private var trailingNavBarButton: some View {
    HStack(spacing: 10) {
      Image(systemName: "checkmark")
        .opacity(showCheckmark ? 1.0 : 0.0)
      
      Button(action: {
        savedButtonPressed()
      }, label: {
        Text("Save".uppercased())
      })
      .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
    }
    .font(.headline)
  }
  
  func savedButtonPressed() {
    guard let _ = selectedCoin else { return }
    
    withAnimation(.easeIn) {
      showCheckmark = true
      removeSelectedCoin()
    }
    // hide the keyboard
    UIApplication.shared.endEditing()
    // set a delay for 2 seconds then remove the checkmark
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      withAnimation(.easeOut) {
        showCheckmark = false
      }
    }
  }
  
  private func removeSelectedCoin() {
    selectedCoin = nil
    vm.searchText = ""
  }

}

struct PortfolioView_Previews: PreviewProvider {
  static var previews: some View {
    PortfolioView()
      .environmentObject(dev.homeVM)
  }
}