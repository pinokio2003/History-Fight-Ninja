//
//  SideMapView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 09.05.2024.
//

import SwiftUI

struct SideMapView: View {
//    var heroData = HeroData.shared
    @EnvironmentObject var heroData: HeroData
    @EnvironmentObject var countryDataManager: CountryDataManager

    @State private var currentSize: CGFloat = UIScreen.main.bounds.width / 4
    @State private var fightSize: CGFloat = UIScreen.main.bounds.width / 2
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            HStack(alignment: .top) {
                Spacer()
                VStack(alignment: .center) {
                    if let countryName = countryDataManager.countryNameMap[heroData.name] {
             
                        Image(countryName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.height / 4,height: UIScreen.main.bounds.height / 4)
                            .padding()
                       
                        Text("Power: ")
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.custom("Chalkduster", size: 15))
                            .foregroundStyle(.black)
                            .shadow(color: Color.white.opacity(0.8), radius: 2, x: 1, y: 1)
                        
                        Text("Difficulty: ")
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.custom("Chalkduster", size: 15))
                            .foregroundStyle(.black)
                            .shadow(color: Color.white.opacity(0.8), radius: 2, x: 1, y: 1)
                        
                    } else {
                        Text("   ")
                    }

                    FightButton(heroData: heroData)
                    
                }
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
