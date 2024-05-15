//
//  PlayerDataModel.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 09.05.2024.
//

import Foundation
import SwiftUI

class HeroData: ObservableObject {
    @Published var name: String = ""
    @Published var isSelected: Bool = false
//    init(names: [String] = []) {
//        self.names = names
//    }
//    
//    func addNameTo(_ name: String) {
//        names.append(name)
//        print(names)
//    }
}

