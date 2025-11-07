//
//  PaymentMethodViewModel.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//
import SwiftUI

class PaymentMethodViewModel: ObservableObject {
  @Published var selectedPaymentType: PaymentType = .creditCard
  @Published var selectedCardId: UUID? = UUID()
  @Published var cardHolderName = "Md Rafatul islam"
  @Published var cardNumber = "333 4444 5555 6666"
  @Published var monthYear = ""
  @Published var cvv = ""
  @Published var country = ""
  @Published var saveCardDetails = false
    
  let subtotal: Double = 450.00
  let shipping: Double = 25.00
  var total: Double { subtotal + shipping }
    
  let creditCards: [CreditCard] = [
    CreditCard(
      id: UUID(),
      type: .visa,
      lastFourDigits: "5433",
      color: .yellow,
      isSelected: true
    ),
    CreditCard(
      id: UUID(),
      type: .mastercard,
      lastFourDigits: "5433",
      color: .gray,
      isSelected: false
    )
  ]
    
  func confirmOrder() {
    print("Order confirmed with \(selectedPaymentType == .creditCard ? "Credit Card" : "Cash on Delivery")")
  }
}
