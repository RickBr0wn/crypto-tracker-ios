//
//  XMarkButtonView.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 20/06/2021.
//

import SwiftUI

struct XMarkButton: View {
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    Button(action: {
      presentationMode.wrappedValue.dismiss()
    }, label: {
      Image(systemName: "xmark")
        .font(.headline)
    })
  }
}

struct XMarkButtonView_Previews: PreviewProvider {
  static var previews: some View {
    XMarkButton()
  }
}
