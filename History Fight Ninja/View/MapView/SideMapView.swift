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

    @State private var currentSize: CGFloat = UIScreen.main.bounds.width / 4
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            HStack(alignment: .top) {
                Spacer()
                VStack(alignment: .center) {
//                    Spacer()
                    if let countryCode = mapsDict.countriesDict[heroData.name] {
                    
                        Text(countryCode)
                            .padding()
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.custom("Chalkduster", size: 25))
                            .foregroundStyle(.red)
                            .shadow(color: Color.black.opacity(0.8), radius: 2, x: 1, y: 1)
                        
                        Image(countryCode)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.height / 4,height: UIScreen.main.bounds.height / 4)
                            .padding()
                       
                    } else {
                        Text("   ")
                    }

//                    Text(heroData.name)
//                    Spacer()
                    FightButton()
                    
                }
//                .frame(maxHeight: .infinity)
                Spacer()
            }

        }
        .frame(maxHeight: .infinity)
        .frame(width: currentSize)
        .background(
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.green.opacity(0.7))
                    .blur(radius: 7)
                    .frame(width: currentSize)
            }
                .ignoresSafeArea()
        )
    }
}

#Preview {
    SideMapView()
}
