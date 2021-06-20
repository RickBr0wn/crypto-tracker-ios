//
//  StatisticsView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import SwiftUI

struct StatisticsView: View {
  let stat: StatisticModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(stat.title)
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
      
      Text(stat.value)
        .font(.headline)
        .foregroundColor(.theme.accent)
      
      HStack(spacing: 4) {
        Image(systemName: "triangle.fill")
          .font(.caption2)
          .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
        
        Text(stat.percentageChange?.asPercentageString() ?? "")
          .font(.caption)
          .bold()
      }
      .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
      .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
    }
    .padding(.top, 10)
  }
}

struct StatisticsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      StatisticsView(stat: dev.stat)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
      
      StatisticsView(stat: dev.stat2)
        .previewLayout(.sizeThatFits)
      
      StatisticsView(stat: dev.stat3)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}
