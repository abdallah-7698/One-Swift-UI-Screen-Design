//
//  CreditCardView.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//
import SwiftUI

// MARK: - Credit Card Content

struct CreditCardPaymentView: View {
  @ObservedObject var viewModel: PaymentMethodViewModel
    
  var body: some View {
    VStack(spacing: 24) {
      CreditCardSelector(
        cards: viewModel.creditCards,
        selectedCardId: $viewModel.selectedCardId
      )
            
      PaymentForm(
        cardHolderName: $viewModel.cardHolderName,
        cardNumber: $viewModel.cardNumber,
        monthYear: $viewModel.monthYear,
        cvv: $viewModel.cvv,
        country: $viewModel.country,
        saveCardDetails: $viewModel.saveCardDetails
      )
    }
  }
}

// MARK: - Credit Card Selector

struct CreditCardSelector: View {
  let cards: [CreditCard]
  @Binding var selectedCardId: UUID?
    
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Saved Cards")
        .font(.system(size: 16, weight: .bold))
        .foregroundColor(.primary)
            
      ScrollViewReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 20) {
            ForEach(cards) { card in
              CreditCardView(
                card: card,
                isSelected: selectedCardId == card.id,
                onTap: {
                  withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedCardId = card.id
                    proxy.scrollTo(card.id, anchor: .center)
                  }
                }
              )
              .id(card.id) // important for scrolling
            }
          }
          .padding(.horizontal, 4)
          .padding(.vertical, 8)
        }
      }
    }
  }
}
// MARK: - ⚠️ NOTE: -->  This view for visa and mastercard only so if there is any other way you have to make change
struct CreditCardView: View {
  let card: CreditCard
  let isSelected: Bool
  let onTap: () -> Void
  @State private var isPressed = false
    
  var body: some View {
    Button(action: onTap) {
      VStack(alignment: .leading, spacing: 0) {
        // Card Header
        HStack {
          Image(systemName: card.type == .visa ? "wave.3.right" : "circle.grid.2x2.fill")
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.white.opacity(0.9))
                    
          Spacer()
                    
          Text(card.type == .visa ? "VISA" : "MASTERCARD")
            .font(.system(size: 11, weight: .black))
            .foregroundColor(.white)
            .tracking(1)
        }
        .padding(.bottom, 20)
                
        // Card Number
        VStack(alignment: .leading, spacing: 12) {
          HStack(spacing: 8) {
            ForEach(0 ..< 3) { _ in
              Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 6, height: 6)
              Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 6, height: 6)
              Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 6, height: 6)
              Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 6, height: 6)
            }
                        
            Text(card.lastFourDigits)
              .font(.system(size: 18, weight: .bold))
              .foregroundColor(.white)
              .tracking(2)
          }
                    
          // Card Footer
          HStack {
            VStack(alignment: .leading, spacing: 2) {
              Text("VALID THRU")
                .font(.system(size: 7, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
                            
              Text("03/27")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
            }
                        
            Spacer()
                        
            if isSelected {
              HStack(spacing: 4) {
                Image(systemName: "checkmark.circle.fill")
                  .font(.system(size: 16, weight: .bold))
                  .foregroundColor(.white)
                                
                Text("Selected")
                  .font(.system(size: 10, weight: .bold))
                  .foregroundColor(.white)
              }
              .padding(.horizontal, 10)
              .padding(.vertical, 6)
              .cornerRadius(12)
            }
          }
        }
      }
      .padding(20)
      .frame(width: 280, height: 170)
      .background(
        ZStack {
          // Gradient Background
          LinearGradient(
            colors: card.color == .yellow ?
              [Color(red: 1.0, green: 0.6, blue: 0.0), Color(red: 1.0, green: 0.8, blue: 0.2)] :
              [Color(red: 0.2, green: 0.2, blue: 0.25), Color(red: 0.3, green: 0.3, blue: 0.35)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
                    
          // Decorative Circles
          GeometryReader { geometry in
            Circle()
              .fill(Color.white.opacity(0.05))
              .frame(width: 120, height: 120)
              .offset(x: geometry.size.width - 60, y: -30)
                        
            Circle()
              .fill(Color.white.opacity(0.05))
              .frame(width: 80, height: 80)
              .offset(x: -20, y: geometry.size.height - 40)
          }
        }
      )
      .cornerRadius(20)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(
            isSelected ? Color.orange : Color.clear,
            lineWidth: 3
          )
      )
      .shadow(
        color: isSelected ? Color.orange.opacity(0.4) : Color.black.opacity(0.1),
        radius: isSelected ? 15 : 8,
        x: 0,
        y: isSelected ? 8 : 4
      )
      .scaleEffect(isPressed ? 0.95 : 1.0)
      .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
      .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
    .buttonStyle(PlainButtonStyle())
    .simultaneousGesture(
      DragGesture(minimumDistance: 0)
        .onChanged { _ in isPressed = true }
        .onEnded { _ in isPressed = false }
    )
  }
}

// MARK: - Payment Form

struct PaymentForm: View {
  @Binding var cardHolderName: String
  @Binding var cardNumber: String
  @Binding var monthYear: String
  @Binding var cvv: String
  @Binding var country: String
  @Binding var saveCardDetails: Bool
    
  var body: some View {
    VStack(spacing: 20) {
      CheckoutTextField(
        title: "Card Holder Name",
        placeholder: "Enter cardholder name",
        content: $cardHolderName
      )
      
      CheckoutTextField(
        title: "Card Number",
        placeholder: "Enter card number",
        content: $cardNumber,
        keyboardType: .numberPad
      )
      
      HStack(spacing: 12) {
        CheckoutTextField(
          title: "Month/Year",
          placeholder: "Enter here",
          content: $monthYear
        )
        
        CheckoutTextField(
          title: "CVV",
          placeholder: "Enter here",
          content: $cvv
        )
      }
            
      CountryPickerView(selectedCountryName: $country)
            
      SaveCardCheckbox(saveAddress: $saveCardDetails)
    }
  }
}

// MARK: - Save Card Checkbox

struct SaveCardCheckbox: View {
  @Binding var saveAddress: Bool
  
  var body: some View {
    HStack(spacing: 12) {
      Button(action: {
        saveAddress.toggle()
      }) {
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .stroke(saveAddress ? Color.orange : Color.gray.opacity(0.3), lineWidth: 2)
            .frame(width: 22, height: 22)
          
          if saveAddress {
            Image(systemName: "checkmark")
              .foregroundColor(.orange)
              .font(.system(size: 12, weight: .bold))
          }
        }
      }
          
      Text("Save shipping address")
        .font(.system(size: 14))
        .foregroundColor(.primary)
          
      Spacer()
    }
  }
}

#Preview {
  CreditCardPaymentView(viewModel: PaymentMethodViewModel())
}
