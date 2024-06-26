//
//  SideMapRightView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 30.05.2024.
//

import SwiftUI

struct SideMapRightView: View {
    //    var heroData = HeroData.shared
    @EnvironmentObject var heroData: HeroData
    @EnvironmentObject var countryDataManager: CountryDataManager
    
    @State private var currentSize: CGFloat = UIScreen.main.bounds.width / 4
    @State private var maxSize: CGFloat = UIScreen.main.bounds.width / 2
    @State private var fightSize: CGFloat = UIScreen.main.bounds.width / 2
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            HStack(alignment: .top) {
                Spacer()
                VStack(alignment: .center) {
                    
                    if heroData.isAnimationBeforeFight {
                        Image(heroData.playerCountry)
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
                        
                        
                        if heroData.isAnimationBeforeFight == false {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: 170, height: 170)
                        }
                    }
                }
                Spacer()
            }
        }
        .frame(maxHeight: .infinity)
        .frame(width: heroData.isAnimationBeforeFight ? maxSize : 0, alignment: .leading)
        .background(
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue.opacity(0.7))
                    .blur(radius: 7)
                    .frame(width: heroData.isAnimationBeforeFight ? maxSize + 75 : 0, alignment: .leading)
            }
                .ignoresSafeArea()
        )
//        .animation(.easeInOut(duration: 0.3), value: heroData.isAnimationBeforeFight)
    }
}

#Preview {
    SideMapRightView()
}
