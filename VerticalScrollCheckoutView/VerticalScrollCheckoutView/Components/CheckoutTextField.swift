//
//  CheckoutTextField.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//


import SwiftUI

struct CheckoutTextField: View {
  
  let title: String
  let placeholder: String
  @Binding var content: String
  var keyboardType: UIKeyboardType = .default
  var submitLabel: SubmitLabel = .next
  
  // Focus management
  @FocusState private var isFocused: Bool
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.system(size: 14, weight: .medium))
        .foregroundColor(.primary)
      
      TextField(placeholder, text: $content)
        .padding()
        .background(Color.white)
        .overlay(
          RoundedRectangle(cornerRadius: 28)
            .stroke(isFocused ? Color.orange : Color.CKDarkGray, lineWidth: 1.5)
        )
        .tint(.orange)
        .focused($isFocused)
        .submitLabel(submitLabel)
    }
  }
}
