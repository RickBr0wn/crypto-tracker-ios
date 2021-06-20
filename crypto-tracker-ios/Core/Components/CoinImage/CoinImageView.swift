//
//  CoinImageView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import SwiftUI

struct CoinImageView: View {
  @StateObject var vm: CoinImageViewModel
  
  init(coin: CoinModel) {
    /// The underscore is representing the view models State Object, because the vm can't be accessed here.
    _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
  }
  
  var body: some View {
    ZStack {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else if vm.isLoading {
        ProgressView()
      } else {
        Image(systemName: "questionmark")
          .foregroundColor(.theme.secondaryText)
      }
    }
  }
}

struct CoinImageView_Previews: PreviewProvider {
  static var previews: some View {
    CoinImageView(coin: dev.coin)
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
