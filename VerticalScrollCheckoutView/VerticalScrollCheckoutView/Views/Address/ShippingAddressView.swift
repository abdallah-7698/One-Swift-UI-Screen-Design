//
//  ShippingAddressView.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//

import SwiftUI

struct ShippingAddressView: View {
  @State private var fullName = "rafatul islam"
  @State private var email = "rafatul3588@gmail.com"
  @State private var phone = "01017202070"
  @State private var address = ""
  @State private var zipCode = ""
  @State private var city = ""
  @State private var country = ""
  @State private var saveAddress = false
  @State private var currentStep = 0
  
  var body: some View {
//    ScrollView {
      VStack(spacing: 20) {
        CheckoutTextField(title: "Full Name", placeholder: "Full Name", content: $fullName)
      
        CheckoutTextField(title: "Email Address", placeholder: "Email Address", content: $email)
      
        CheckoutTextField(title: "Phone", placeholder: "01000000000", content: $phone, submitLabel: .next)
      
        CheckoutTextField(title: "Address", placeholder: "Type your home address", content: $address)
      
        // Zip Code and City
        HStack(spacing: 12) {
          CheckoutTextField(title: "Zip Code", placeholder: "Enter here", content: $zipCode)
        
          CheckoutTextField(title: "City", placeholder: "Enter here", content: $city, submitLabel: .done)
        }
      
        VStack(alignment: .leading, spacing: 8) {
          Text("Country")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.primary)
        
          CountryPickerView(selectedCountryName: $country)
        }
      
        // Save Shipping Address
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
        .padding(.top, 4)
      
      }
      .padding(.horizontal, 24)
      .padding(.top, 24)
    }
//  }
}
  
#Preview {
  ShippingAddressView()
}
