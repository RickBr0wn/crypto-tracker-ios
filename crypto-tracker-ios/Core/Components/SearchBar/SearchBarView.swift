//
//  SearchBarView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import SwiftUI

struct SearchBarView: View { 
  
  @Binding var searchText: String
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
        .disableAutocorrection(true)
      
      TextField("Search by name or symbol..", text: $searchText)
        .foregroundColor(.theme.accent)
        .overlay(
          Image(systemName: "xmark.circle.fill")
            .padding(10)
            .offset(x: 10.0)
            .foregroundColor(.theme.accent)
            .opacity(searchText.isEmpty ? 0.0 : 1.0)
            .onTapGesture {
              UIApplication.shared.endEditing()
              searchText = ""
            },
          alignment: .trailing
        )
    }
    .font(.headline)
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 25.0)
        .fill(Color.theme.background)
        .shadow(color: .theme.accent.opacity(0.25), radius: 10, x: 0.0, y: 0.0)
    )
    .padding()
  }
}

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
      
      SearchBarView(searchText: .constant(""))
    }
  }
}
