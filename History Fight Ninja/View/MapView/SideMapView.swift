//
//  SideMapView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 09.05.2024.
//

import SwiftUI

struct SideMapView: View {
    @EnvironmentObject var heroData: HeroData
    @EnvironmentObject var mapsDict: MapsModelData
    
    var body: some View {
        ZStack {

            if let countryCode = mapsDict.countriesDict[heroData.name] {
                VStack(alignment: .center) {
                    Text(countryCode)
                    
                    Image(countryCode)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.height / 4,height: UIScreen.main.bounds.height / 4)
                }
            } else {
                Text("   ")
            }
            Text(heroData.name)

        }
        .background(Color.clear)
        .frame(width: UIScreen.main.bounds.height * 0.5,height: UIScreen.main.bounds.height)
    }
}

#Preview {
    SideMapView()
}
