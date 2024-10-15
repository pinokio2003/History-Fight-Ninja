//
//  MoneyPanel.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 06.09.2024.
//

import SwiftUI

struct MoneyPanel: View {

    let playerMoney: Int
    
    var body: some View {
        HStack(spacing: 5) {
                Image("Money")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 55)
                    
            Text("\(playerMoney)")
                .font(.headline)
        }
        .frame(height: 30)
        .padding()
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
    }

}

#Preview {
    MoneyPanel(playerMoney: HeroData.shared.playerExperience)
}
