//
//  Dificlty.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 12.09.2024.
//

import Foundation

enum Difficulty {
    case easy
    case normal
    case hard
    case impossible
    
    func statusDifficulty() -> [String : Bool] {
        switch self {
            case .easy:
                return ["Easy" : true]
            case .normal:
                return ["Normal" : true]
            case .hard:
                return ["Hard" : true]
            case .impossible:
                return ["Impossible" : false]
        }
    }
}
