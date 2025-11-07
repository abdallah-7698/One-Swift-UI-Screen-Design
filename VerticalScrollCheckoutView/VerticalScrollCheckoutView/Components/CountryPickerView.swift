//
//  CountryPickerView.swift
//  VerticalScrollCheckoutView
//
//  Created by name on 07/11/2025.
//
import SwiftUI

struct CountryPickerView: View {
  @Binding var selectedCountryName: String
    
  var body: some View {
    CountryPicker(
      selection: $selectedCountryName,
      options: [
        Country(name: "Egypt", flag: "🇪🇬"),
        Country(name: "United States", flag: "🇺🇸"),
        Country(name: "Canada", flag: "🇨🇦"),
        Country(name: "Germany", flag: "🇩🇪"),
        Country(name: "France", flag: "🇫🇷"),
        Country(name: "Japan", flag: "🇯🇵")
      ]
    )
  }
}

struct Country: Identifiable, Equatable {
  let id = UUID()
  let name: String
  let flag: String
}

enum DropDownPickerState {
  case top
  case bottom
}

struct CountryPicker: View {
  @Binding var selection: String
  var state: DropDownPickerState = .bottom
  var options: [Country]
  var maxWidth: CGFloat = 220
    
  @State private var showDropdown = false
  @SceneStorage("drop_down_zindex") private var index = 1000.0
  @State private var zindex = 1000.0
    
  var body: some View {
    VStack(spacing: 0) {
      if state == .top && showDropdown {
        optionsView()
          .transition(.move(edge: .bottom).combined(with: .opacity))
      }
      
      HStack {
        if let country = options.first(where: { $0.name == selection }) {
          Text(country.flag)
          Text(country.name)
            .foregroundColor(.primary)
        } else {
          Text("Choose your country")
            .foregroundColor(.gray)
        }
        
        Spacer(minLength: 0)
                  
        Image(systemName: state == .top ? "chevron.up" : "chevron.down")
          .font(.title3)
          .foregroundColor(.orange)
          .rotationEffect(.degrees(showDropdown ? -180 : 0))
          .animation(.spring(response: 0.4, dampingFraction: 0.6), value: showDropdown)
      }
      .padding(.horizontal, 15)
      .frame(height: 50)
      .background(.white)
      .contentShape(Rectangle())
      .onTapGesture {
        index += 1
        zindex = index
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
          showDropdown.toggle()
        }
      }
      .zIndex(10)
      
      if state == .bottom {
        if showDropdown {
          optionsView()
            .transition(.move(edge: .top).combined(with: .opacity))
        }
      }
    }
    .animation(.spring(response: 0.4, dampingFraction: 0.7), value: showDropdown)
    .clipped()
    .background(.white)
    .cornerRadius(14)
    .overlay(
      RoundedRectangle(cornerRadius: 14)
        .stroke(showDropdown ? Color.orange : Color.gray.opacity(0.5), lineWidth: 1)
        .animation(.easeInOut(duration: 0.25), value: showDropdown)
    )
    .zIndex(zindex)
  }
    
  @ViewBuilder
  private func optionsView() -> some View {
    VStack(spacing: 0) {
      ForEach(options) { option in
        HStack {
          Text(option.flag)
          Text(option.name)
                    
          Spacer()
                    
          Image(systemName: "checkmark")
            .foregroundColor(.orange)
            .opacity(selection == option.name ? 1 : 0)
        }
        .foregroundStyle(selection == option.name ? Color.primary : Color.gray)
        .frame(height: 44)
        .padding(.horizontal, 15)
        .contentShape(Rectangle())
        .onTapGesture {
          withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            selection = option.name
            showDropdown = false
          }
        }
                
        if option != options.last {
          Divider()
        }
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.white)
        .shadow(color: .orange.opacity(0.15), radius: 4, y: 2)
    )
    .zIndex(1)
  }
}

#Preview {
  @Previewable @State var selectedCountryName = ""
  CountryPickerView(selectedCountryName: $selectedCountryName)
    .padding()
    .previewLayout(.sizeThatFits)
}
