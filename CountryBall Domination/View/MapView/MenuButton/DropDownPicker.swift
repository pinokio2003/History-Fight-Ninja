//
//  DropDownPicker.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 15.07.2024.
//

import SwiftUI

struct DropDownPicker: View {
    var hint: String
    var options: [String]
    var maxWidth: CGFloat = 180
    var cornerRadius: CGFloat = 15
    @Binding var selection: String?
    @Binding var color: Color
    @State private var showOption: Bool = false
    @ObservedObject var countryDataManager: CountryDataManager // добавлено
    private let heroData = HeroData.shared

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(selection ?? hint)
                        .font(.custom("Eracake", size: 13))
                        .foregroundStyle(selection == nil ? .gray : .primary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 15)
                .frame(width: size.width, height: size.height)
                .contentShape(Rectangle())
                .onTapGesture {
                    showOption.toggle()
                }
                .zIndex(10)
                
                if showOption {
                    OptionView()
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2)
            )
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
        }
        .frame(width: maxWidth, height: 50)
        .padding(.trailing, maxWidth + 120)
    }
    
    // Option View
    @ViewBuilder
    func OptionView() -> some View {
        ScrollView {
            VStack(spacing: 3) {
                ForEach(countryDataManager.countryBackgroundColorDifficlty, id: \.0) { (countryName, countryColor, countryCode, countryPower) in
                    HStack(spacing: 0) {
                        Text(countryName)
                            .font(.custom("Chalkduster", size: 15))
//                            .bold()
//                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                            .foregroundColor(transformedColor(color: countryColor))
                            .lineLimit(1)
                            .frame(width: maxWidth, height: 40)
                            .contentShape(Rectangle())
                            .background(countryColor)
                            .onTapGesture {
                                selection = countryName
                                showOption = false
                                print("Selected option: \(countryName)") // Добавьте эту строку для отладки
                                print("Selected option: \(countryCode)")
                                heroData.name = countryCode
                                heroData.isCountrySelected = true
                            }
                    }
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(transformColorForStroke(color: countryColor), lineWidth: 2)
                    )
                }
            }
        }
        .frame(height: min(CGFloat(countryDataManager.countryBackgroundColor.count) * 40, 200))
    }
}

