//
//  MenuButtonView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 05.07.2024.
//

import SwiftUI

struct MenuButtonView: View {
    @State var show: Bool = false
    @State var showButtonOne: Bool = false
    @State private var selection: String?
    private var countryDataManager = CountryDataManager.shared
    private let heroData = HeroData.shared
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                mainButton
                if show {
                    CanCircleButton(show: $show, Yoffset: 60,
                                    sanimation: 0.3,
                                    imageName: "countryPicker",
                                    action: { showButtonOne.toggle() })
                    CanCircleButton(show: $show,
                                    Yoffset: 120,
                                    sanimation: 0.2,
                                    imageName: "skillPicker",
                                    action: { presentContentView(with: SkillTreeScreen())})
                    CanCircleButton(show: $show,
                                    Yoffset: 180,
                                    sanimation: 0.1,
                                    imageName: "eriser",
                                    action: { heroData.clearUserDefaults() })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if showButtonOne && show {
                DropDownPicker(
                    hint: "Select Country",
                    options: countryDataManager.countryBackgroundColor.map { $0.0 }, // массив имён стран
                    maxWidth: 180,
                    cornerRadius: 15,
                    selection: $selection,
                    color: .constant(.gray),
                    countryDataManager: countryDataManager // передача объекта CountryDataManager
                )
                .transition(.opacity)
                .animation(.easeInOut, value: showButtonOne)
                .offset(x: geo.size.width - 260, y: geo.size.height)
            }
        }
    }
    
    var mainButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                show.toggle()
            }
        }) {
            ZStack {
                Circle().frame(width: 60)
                    .foregroundColor(.blue.opacity(0.9))
                    .shadow(color: .black, radius: 4, x: 1, y: 3)
                Image(heroData.playerCountry)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
            }
        }
    }
}

struct CanCircleButton: View {
    @Binding var show: Bool
    var Yoffset: CGFloat
    var sanimation: CGFloat
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle().frame(width: 50)
                    .foregroundColor(.blue.opacity(0.9))
                    .shadow(color: .black, radius: 4, x: 1, y: 3)
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
            }
        }
        .offset(y: show ? Yoffset : 0)
        .opacity(show ? 1 : 0)
        .animation(Animation.spring(response: 0.5, dampingFraction: 0.6)
            .delay(show ? sanimation : 0), value: show)
    }
}
