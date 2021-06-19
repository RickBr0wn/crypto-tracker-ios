//
//  Double.swift
//  crypto-tracker-ios
//
//  Created by Rick Brown on 19/06/2021.
//

import Foundation

extension Double {
  /// Convert a `Double` into a currency with 2 decimal places
  /// ```
  /// Converts 1234.56 to $1,234.56
  /// Converts 12.3456 to $12.34
  /// Converts 0.123456 to $0.12
  /// ```
  private var formatCurrencyToTwoDecimalPlaces: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    // formatter.locale = .current // <- default value
    // formatter.currencyCode = "usd" // <- change the currency
    // formatter.currencySymbol = "$" // <- change the currency symbol
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }
  /// Convert a `Double` into a currency as a `String` with 2 decimal places
  /// ```
  /// Converts 1234.56 to "$1,234.56"
  /// Converts 12.3456 to "$12.34"
  /// Converts 0.123456 to "$0.12"
  /// ```
  func asCurrencyStringWithTwoDecimalPlaces() -> String {
    let number = NSNumber(value: self)
    return formatCurrencyToTwoDecimalPlaces.string(from: number) ?? "$0.00"
  }
  /// Convert a `Double` into a currency with 2-6 decimal places
  /// ```
  /// Converts 1234.56 to $1,234.56
  /// Converts 12.3456 to $12.3456
  /// Converts 0.123456 to $0.123456
  /// ```
  private var formatCurrencyToSixDecimalPlaces: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    // formatter.locale = .current // <- default value
    // formatter.currencyCode = "usd" // <- change the currency
    // formatter.currencySymbol = "$" // <- change the currency symbol
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 6
    return formatter
  }
  /// Convert a `Double` into a currency as a `String` with 2-6 decimal places
  /// ```
  /// Converts 1234.56 to "$1,234.56"
  /// Converts 12.3456 to "$12.3456"
  /// Converts 0.123456 to "$0.123456"
  /// ```
  func asCurrencyStringWithSixDecimalPlaces() -> String {
    let number = NSNumber(value: self)
    return formatCurrencyToSixDecimalPlaces.string(from: number) ?? "$0.00"
  }
  /// Convert a `Double` into a `String` representation
  /// ```
  /// Converts 1.23456 to "$1.23"
  /// ```
  func asNumberStringWithTwoDecmimalPlaces() -> String {
    return String(format: "%.2f", self)
  }
  /// Convert a `Double` into a `String` representation with percent symbol
  /// ```
  /// Converts 1.23456 to "1.23%"
  /// ```
  func asPercentageString() -> String {
    return asNumberStringWithTwoDecmimalPlaces() + "%"
  }
}
