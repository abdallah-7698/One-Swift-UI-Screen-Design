//
//  PaymentMethodModel.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//

import SwiftUI

enum PaymentType {
  case cashOnDelivery
  case creditCard
}

enum CardType {
  case visa
  case mastercard
}

struct CreditCard: Identifiable {
  let id: UUID
  let type: CardType
  let lastFourDigits: String
  let color: Color
  let isSelected: Bool
}
