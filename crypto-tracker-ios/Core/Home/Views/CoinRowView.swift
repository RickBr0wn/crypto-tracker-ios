//
//  CoinRowView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 19/06/2021.
//

import SwiftUI

struct CoinRowView: View {
  let coin: CoinModel
  let showHoldingColumn: Bool
  
  var body: some View {
    HStack(spacing: 0) {
      leftHandColumn
      Spacer()
      showHoldingColumn ? centerColumn : nil
      rightHandColumn
    }
    .font(.subheadline)
  }
}

extension CoinRowView {
  private var leftHandColumn: some View {
    HStack {
      Text("\(coin.rank)")
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .frame(minWidth: 30)
      
      CoinImageView(coin: coin)
        .frame(width: 30, height: 30)
      
      Text("\(coin.symbol.uppercased())")
        .font(.headline)
        .padding(.leading, 6)
        .foregroundColor(.theme.accent)
    }
  }
  
  private var centerColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentHoldingsValue.asCurrencyStringWithTwoDecimalPlaces())
        .bold()
      Text((coin.currentHoldings ?? 0).asNumberStringWithTwoDecmimalPlaces())
    }
    .foregroundColor(.theme.accent)
  }
  
  private var rightHandColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentPrice.asCurrencyStringWithSixDecimalPlaces())
      Text(coin.priceChangePercentage24H?.asPercentageString() ?? "0.00%")
        .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? .theme.green : .theme.red)
    }
    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
  }
}

struct CoinRowView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CoinRowView(coin: dev.coin, showHoldingColumn: true)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
        .padding()
      
      CoinRowView(coin: dev.coin, showHoldingColumn: false)
        .previewLayout(.sizeThatFits)
        .padding()
    }
  }
}
