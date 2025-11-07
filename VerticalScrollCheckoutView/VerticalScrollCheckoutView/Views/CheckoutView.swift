//
//  CheckoutView.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//

import SwiftUI

enum CheckoutStep {
  case shippingAddress
  case paymentMethod
}

struct CheckoutView: View {
  @State private var fullName = "rafatul islam"
  @State private var email = "rafatul3588@gmail.com"
  @State private var phone = "880 1017202070"
  @State private var address = ""
  @State private var zipCode = ""
  @State private var city = ""
  @State private var country = ""
  @State private var saveAddress = false
  @State private var currentStep = 0
    
  enum CheckoutSteps {
    case shippingAddress
    case paymentMethod
  }
  
  // For Navigation animarion
  @State private var animationDuration: Double = 0.5
  @State private var navigationCompleted = false
  @State private var isValidAddressInfo = false
  
  @State private var activeStep: CheckoutSteps = .shippingAddress

  @EnvironmentObject private var coordinator: Coordinator
  
  var body: some View {
    VStack {
      self.makeHeaderView()
        .padding(.top, 8)
        .padding(.bottom, 16)
        .padding(.horizontal, 16)
      
      Divider()
      
      ScrollViewReader { proxy in
        ScrollView {
          self.makeCurrentStepView(acriveStep: self.activeStep)
            .padding(.horizontal, 40)
            .padding(.vertical, 18)
            .id("Top")
            
          ZStack {
            if activeStep == .shippingAddress {
              ShippingAddressView()
                .transition(.asymmetric(
                  insertion: .move(edge: .leading).combined(with: .opacity),
                  removal: .move(edge: .leading).combined(with: .opacity)
                ))
            } else {
              PaymentMethodView()
                .transition(.asymmetric(
                  insertion: .move(edge: .trailing).combined(with: .opacity),
                  removal: .move(edge: .trailing).combined(with: .opacity)
                ))
            }
          }
          .animation(.easeInOut, value: activeStep)
          
          Divider()
          
          makeNextButton(proxy: proxy)
            .padding()
        }
      }
    }
  }
  
  // MARK: - HeaderView

  @ViewBuilder
  private func makeHeaderView() -> some View {
    HStack {
      Button {
        if activeStep == .paymentMethod {
          self.activeStep = .shippingAddress
        }
        
       // Handel back to previous page
        
      } label: {
        Image(systemName: "chevron.left")
          .foregroundColor(.primary)
      }
      
      Spacer()
      
      Text("Checkout")
        .font(.system(size: 20, weight: .semibold))
      Spacer()
    }
  }
  
  // MARK: - CurrentStepView

  @ViewBuilder
  private func makeCurrentStepView(
    acriveStep: CheckoutSteps
  ) -> some View {
    let isPaymentMethodActive = acriveStep == .paymentMethod
    
    HStack(alignment: .top, spacing: -34) {
      self.makeStepView(
        currentStep: .shippingAddress,
        isActive: true,
        isCompleted: isPaymentMethodActive ? true : false
      )
      
      self.makeStepProgressRectangleView(isActive: isPaymentMethodActive)
        .frame(height: 2)
        .padding(.top, 18)
      
      self.makeStepView(
        currentStep: .shippingAddress,
        isActive: isPaymentMethodActive && self.navigationCompleted ? true : false,
        isCompleted: false
      )
    }
  }
  
  @ViewBuilder
  private func makeStepProgressRectangleView(isActive: Bool) -> some View {
    GeometryReader { geo in
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(Color.CKDarkGray)
          .frame(height: 2)

        Rectangle()
          .fill(Color.orange)
          .frame(width: isActive ? geo.size.width : 0, height: 2)
          .animation(.linear(duration: self.animationDuration), value: isActive)
      }
    }
  }

  @ViewBuilder
  private func makeStepView(
    currentStep: CheckoutSteps = .shippingAddress,
    isActive: Bool = false,
    isCompleted: Bool = false
  ) -> some View {
    let stepColor: Color = isCompleted ? .orange : isActive ? .orange : .CKDarkGray
    let backgroundColor: Color = isCompleted ? .orange : isActive ? .white : .CKDarkGray
    let imageColor: Color = isCompleted ? .white : isActive ? .orange : .white
    let textColor: Color = isCompleted ? .orange : isActive ? .orange : .CKDarkGray
    
    VStack(spacing: 12) {
      ZStack {
        Circle()
          .fill(stepColor)
          .frame(width: 40, height: 40)
              
        Circle()
          .fill(backgroundColor)
          .frame(width: 30, height: 30)
              
        Image(systemName: currentStep == .shippingAddress ? "location.fill" : "creditcard.fill")
          .foregroundColor(imageColor)
          .font(.system(size: 16))
      }
          
      Text(currentStep == .paymentMethod ? "Shipping Address" : "Payment Method")
        .font(.system(size: 13, weight: .medium))
        .foregroundColor(textColor)
    }
  }
  
  // MARK: - NextButton

  @ViewBuilder
  private func makeNextButton(proxy: ScrollViewProxy) -> some View {
    Button(action: {
      Task {
        
        if activeStep == .paymentMethod {
          withAnimation(.snappy) {
            coordinator.push {
              OrderSummaryView(subtotal: 100.0, shipping: 10, total: 110, paymentMethod: .creditCard) {
                print("Completed")
              }.navigationBarBackButtonHidden(true)
            }
          }
        }
        
        self.activeStep = .paymentMethod
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          withAnimation {
            proxy.scrollTo("Top", anchor: .top)
          }
        }
        try? await Task.sleep(for: .seconds(self.animationDuration))
        self.navigationCompleted = true
      }
    }) {
      Text(self.activeStep == .paymentMethod && self.navigationCompleted ? "Confirm ORDER" : "NEXT")
        .font(.system(size: 18, weight: .semibold))
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(Color.orange)
        .cornerRadius(28)
    }
  }
}

#Preview {
  CheckoutView().withNavigation()
}
