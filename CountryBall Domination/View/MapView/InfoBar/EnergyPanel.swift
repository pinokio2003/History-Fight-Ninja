//
//  EnergyPanel.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 06.09.2024.
//

import SwiftUI

struct EnergyPanel: View {
    let playerEnergyMax: Int
    let playerEnergy: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<playerEnergyMax, id: \.self) { index in
                Image(index < playerEnergy ? "energyFull" : "energyEmpty")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
            }
            Text("\(playerEnergy)/\(playerEnergyMax) ")
                .font(.headline)
        }
        .cornerRadius(10)
    }
}


//#Preview {
//    EnergyPanel()
//}
