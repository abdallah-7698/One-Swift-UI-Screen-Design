//
//  CashOnDeliveryPaymentView.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//
import SwiftUI

struct CashOnDeliveryPaymentView: View {
  var body: some View {
    VStack(spacing: 24) {

      makeCashIcon()
        .padding(.top, 20)
            
      VStack(spacing: 12) {
        Text("Cash on Delivery")
          .font(.system(size: 24, weight: .bold))
          .foregroundColor(.primary)
                
        Text("Pay with cash when your order arrives")
          .font(.system(size: 15))
          .foregroundColor(.gray)
          .multilineTextAlignment(.center)
      }
            
      // Info Box
      VStack(spacing: 16) {
        InfoRow(
          icon: "checkmark.circle.fill",
          title: "No Prepayment",
          description: "Pay only after receiving your order"
        )
                
        Divider()
                
        InfoRow(
          icon: "hand.raised.fill",
          title: "Inspect First",
          description: "Check your items before payment"
        )
                
        Divider()
                
        InfoRow(
          icon: "dollarsign.circle.fill",
          title: "Exact Change",
          description: "Please prepare exact amount if possible"
        )
      }
      .padding(20)
      .background(Color.white)
      .cornerRadius(16)
      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 2)
            
      // Note
      HStack(spacing: 12) {
        Image(systemName: "info.circle.fill")
          .foregroundColor(.orange)
          .font(.system(size: 20))
                
        Text("Cash payment will be collected by our delivery partner")
          .font(.system(size: 13))
          .foregroundColor(.gray)
          .lineLimit(2)
                
        Spacer()
      }
      .padding(16)
      .background(Color.orange.opacity(0.1))
      .cornerRadius(12)
    }
    .padding(.vertical, 20)
  }
  
  @MainActor
  private func makeCashIcon() -> some View {
    ZStack {
      Circle()
        .fill(
          LinearGradient(
            colors: [Color.orange.opacity(0.1), Color.orange.opacity(0.05)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .frame(width: 140, height: 140)
              
      Circle()
        .fill(
          LinearGradient(
            colors: [Color.orange.opacity(0.2), Color.orange.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .frame(width: 100, height: 100)
              
      ZStack {
        RoundedRectangle(cornerRadius: 8)
          .fill(
            LinearGradient(
              colors: [Color.orange, Color.orange.opacity(0.8)],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )
          .frame(width: 50, height: 35)
                  
        Text("$")
          .font(.system(size: 28, weight: .bold))
          .foregroundColor(.white)
      }
    }
  }
  
}

struct InfoRow: View {
  let icon: String
  let title: String
  let description: String
    
  var body: some View {
    HStack(spacing: 16) {
      Image(systemName: icon)
        .font(.system(size: 24))
        .foregroundColor(.orange)
        .frame(width: 32)
            
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.system(size: 15, weight: .semibold))
          .foregroundColor(.primary)
                
        Text(description)
          .font(.system(size: 13))
          .foregroundColor(.gray)
      }
            
      Spacer()
    }
  }
}


#Preview{
  CashOnDeliveryPaymentView()
}
