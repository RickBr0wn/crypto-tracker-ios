//
//  HomeStatsView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import SwiftUI

struct HomeStatsView: View {
  @EnvironmentObject var vm: HomeViewModel
  @Binding var showPortfolio: Bool
  
  var body: some View {
    HStack {
      ForEach(vm.statistics) { stat in
        StatisticsView(stat: stat)
          .frame(width: UIScreen.main.bounds.width / 3)
      }
    }
    .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
  }
}

struct HomeStatsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeStatsView(showPortfolio: .constant(false))
      .environmentObject(dev.homeVM)
  }
}
