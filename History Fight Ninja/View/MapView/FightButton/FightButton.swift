//
//  FightButton.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 17.05.2024.
//

import SwiftUI

struct FightButton: View {
    @StateObject var heroData = HeroData.shared
    
    var body: some View {
        ZStack {
            if heroData.isAnimationBeforeFight == false {
                FieldForButton()
                AttacButton(heroData: heroData)
                
            }
            
        }
        .environmentObject(heroData)
    }
}
#Preview {
    FightButton()
}


