//
//  OrderSummaryView.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//
import SwiftUI

struct OrderSummaryView: View {
  let subtotal: Double
  let shipping: Double
  let total: Double
  let paymentMethod: PaymentType
  let onConfirm: () -> Void
  
  @EnvironmentObject private var coordinator: Coordinator

  
  var body: some View {
    VStack(spacing: 20) {
      
      makeHeaderView()
        .padding(.top, 8)
        .padding(.bottom, 16)
        .padding(.horizontal, 16)
      
      // Summary Details
      VStack(spacing: 16) {
        SummaryRow(title: "Subtotal", value: subtotal)
        SummaryRow(title: "Shipping", value: shipping)
              
        Divider()
              
        HStack {
          Text("Total")
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.primary)
                  
          Spacer()
                  
          Text("$\(String(format: "%.2f", total))")
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.orange)
        }
              
        Divider()
              
        HStack {
          Text("Payment Method")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.gray)
                  
          Spacer()
                  
          HStack(spacing: 6) {
            Image(systemName: paymentMethod == .creditCard ? "creditcard.fill" : "banknote.fill")
              .font(.system(size: 14))
              .foregroundColor(.orange)
                      
            Text(paymentMethod == .creditCard ? "Credit Card" : "Cash on Delivery")
              .font(.system(size: 14, weight: .medium))
              .foregroundColor(.primary)
          }
        }
      }
      .padding(20)
      .background(Color.white)
      .cornerRadius(16)
      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 2)
          
      Spacer()
      
      // Action Button
      Button(action: onConfirm) {
        HStack(spacing: 8) {
          Text(paymentMethod == .creditCard ? "PAY NOW" : "CONFIRM ORDER")
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
                  
          Image(systemName: paymentMethod == .creditCard ? "creditcard.fill" : "checkmark.circle.fill")
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(
          LinearGradient(
            colors: [Color.orange, Color.orange.opacity(0.8)],
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        .cornerRadius(28)
        .shadow(color: Color.orange.opacity(0.3), radius: 10, x: 0, y: 5)
      }
    }
    .padding(.top, 8)
    .padding(.horizontal, 24)
    .padding(.vertical, 20)
  }
  
  @ViewBuilder
  private func makeHeaderView() -> some View {
    HStack {
      Button {
        coordinator.pop()
      } label: {
        Image(systemName: "chevron.left")
          .foregroundColor(.primary)
      }
      
      Spacer()
      
      Text("Order Summary")
        .font(.system(size: 20, weight: .semibold))
      Spacer()
    }
  }
  
}

struct SummaryRow: View {
  let title: String
  let value: Double
    
  var body: some View {
    HStack {
      Text(title)
        .font(.system(size: 15))
        .foregroundColor(.gray)
            
      Spacer()
            
      Text("$\(String(format: "%.2f", value))")
        .font(.system(size: 15, weight: .medium))
        .foregroundColor(.primary)
    }
  }
}

#Preview {
    let viewModel = PaymentMethodViewModel()
    return OrderSummaryView(
        subtotal: viewModel.subtotal,
        shipping: viewModel.shipping,
        total: viewModel.total,
        paymentMethod: viewModel.selectedPaymentType,
        onConfirm: viewModel.confirmOrder
    ).withNavigation()
}
