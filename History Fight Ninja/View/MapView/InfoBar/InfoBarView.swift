//
//  InfoBarView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 06.09.2024.
//

import SwiftUI

struct InfoBarView: View {
    @ObservedObject var heroData: HeroData
    
    var body: some View {
        HStack(spacing: 5) {
            MoneyPanel(playerMoney: heroData.playerExperience)
            
            IncomePanel(income: heroData.playerIncome)
            
            EnergyPanel(playerEnergyMax: heroData.playerEnergyMax,
                        playerEnergy: heroData.playerEnergy)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 45)
        .cornerRadius(10)
        .background(Color.gray.opacity(0.5))
    }
}

#Preview {
    InfoBarView(heroData: HeroData.shared)
}
