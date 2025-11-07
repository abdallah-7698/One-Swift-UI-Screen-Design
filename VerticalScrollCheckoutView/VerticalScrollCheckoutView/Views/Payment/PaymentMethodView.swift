//
//  PaymentMethodView.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//
import SwiftUI

// MARK: - Main View

struct PaymentMethodView: View {
  @StateObject private var viewModel = PaymentMethodViewModel()
    
  var body: some View {
    ScrollView {
      VStack(spacing: 24) {
        PaymentTypeSelector(selectedType: $viewModel.selectedPaymentType)
                
        if viewModel.selectedPaymentType == .creditCard {
          CreditCardPaymentView(viewModel: viewModel)
        } else {
          CashOnDeliveryPaymentView()
        }
      }
      .padding(.horizontal, 24)
      .padding(.vertical, 20)
    }
  }
}

// MARK: - Payment Type Selector

struct PaymentTypeSelector: View {
  @Binding var selectedType: PaymentType
    
  var body: some View {
    HStack(spacing: 12) {
      PaymentTypeButton(
        title: "Cash on Delivery",
        icon: "banknote.fill",
        isSelected: selectedType == .cashOnDelivery,
        action: {
          withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedType = .cashOnDelivery
          }
        }
      )
            
      PaymentTypeButton(
        title: "Credit Card",
        icon: "creditcard.fill",
        isSelected: selectedType == .creditCard,
        action: {
          withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedType = .creditCard
          }
        }
      )
    }
  }
}

struct PaymentTypeButton: View {
  let title: String
  let icon: String
  let isSelected: Bool
  let action: () -> Void
    
  var body: some View {
    Button(action: action) {
      HStack(spacing: 8) {
        Image(systemName: icon)
          .font(.system(size: 16, weight: .medium))
                
        Text(title)
          .font(.system(size: 14, weight: .medium))
          .lineLimit(1)
      }
      .foregroundColor(isSelected ? .white : .primary)
      .padding(.horizontal, 10)
      .padding(.vertical, 14)
      .frame(maxWidth: .infinity)
      .background(isSelected ? Color.orange : Color.white)
      .cornerRadius(25)
      .overlay(
        RoundedRectangle(cornerRadius: 25)
          .stroke(isSelected ? Color.clear : Color.gray.opacity(0.3), lineWidth: 1)
      )
    }
  }
}



#Preview {
  PaymentMethodView()
}
