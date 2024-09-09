//
//  IncomeView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 06.09.2024.
//

import SwiftUI

struct IncomePanel: View {
    let income: Int
    
    var body: some View {
        HStack(spacing: 5) {
                Image("income")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 45)
                    
            Text(" + \(income)")
                .font(.headline)
        }
        .frame(height: 30)
        .padding()
    }

}
#Preview {
    IncomePanel(income: HeroData.shared.playerIncome)
}
