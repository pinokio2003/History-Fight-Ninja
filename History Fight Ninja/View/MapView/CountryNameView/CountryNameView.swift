//
//  CountryNameView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 21.05.2024.
//

import SwiftUI

struct CountryNameView: View {
    @EnvironmentObject var countryDataManager: CountryDataManager
    @StateObject var heroData = HeroData.shared

    var body: some View {
        if let countryCode = countryDataManager.countryNameMap[heroData.name] {
            Text(countryCode)
                .padding()
//                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom("Chalkduster", size: 35))
                .foregroundStyle(.red)
                .shadow(color: Color.black.opacity(0.8), radius: 2, x: 1, y: 1)
        } else {
            Text("   ")
        }
    }
}

#Preview {
    CountryNameView()
        .environmentObject(CountryDataManager())
//        .environmentObject(HeroData())
}
