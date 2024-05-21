//
//  FightButton.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 17.05.2024.
//

import SwiftUI

struct FightButton: View {
    
    var body: some View {
        ZStack {
            FieldForButton()
            AttacButton()
        }
    }
}
#Preview {
    FightButton()
}


