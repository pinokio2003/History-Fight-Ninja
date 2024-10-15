//
//  SkillModel.swift
//  SkillTree
//
//  Created by Anatolii Kravchuk on 19.07.2024.
//

import SwiftUI

struct Skill: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let branch: SkillBranch
    var baseCost: Int
    var cost: Int
    var isUnlocked: Bool
    var isPurchased: Bool
    let imageName: String
    let dependencies: [UUID]
    let position: CGPoint
    
    // Новое свойство для хранения action
    var actionKey: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, branch, baseCost, cost, isUnlocked, isPurchased, imageName, dependencies, positionX, positionY, actionKey
    }
    
    init(id: UUID, name: String, description: String, branch: SkillBranch, baseCost: Int, cost: Int, isUnlocked: Bool, isPurchased: Bool, imageName: String, actionKey: String, dependencies: [UUID], position: CGPoint) {
        self.id = id
        self.name = name
        self.description = description
        self.branch = branch
        self.baseCost = baseCost
        self.cost = cost
        self.isUnlocked = isUnlocked
        self.isPurchased = isPurchased
        self.imageName = imageName
        self.actionKey = actionKey
        self.dependencies = dependencies
        self.position = position
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        branch = try container.decode(SkillBranch.self, forKey: .branch)
        baseCost = try container.decode(Int.self, forKey: .baseCost)
        cost = try container.decode(Int.self, forKey: .cost)
        isUnlocked = try container.decode(Bool.self, forKey: .isUnlocked)
        isPurchased = try container.decode(Bool.self, forKey: .isPurchased)
        imageName = try container.decode(String.self, forKey: .imageName)
        dependencies = try container.decode([UUID].self, forKey: .dependencies)
        let x = try container.decode(CGFloat.self, forKey: .positionX)
        let y = try container.decode(CGFloat.self, forKey: .positionY)
        position = CGPoint(x: x, y: y)
        actionKey = try container.decode(String.self, forKey: .actionKey)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(branch, forKey: .branch)
        try container.encode(baseCost, forKey: .baseCost)
        try container.encode(cost, forKey: .cost)
        try container.encode(isUnlocked, forKey: .isUnlocked)
        try container.encode(isPurchased, forKey: .isPurchased)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(dependencies, forKey: .dependencies)
        try container.encode(position.x, forKey: .positionX)
        try container.encode(position.y, forKey: .positionY)
        try container.encode(actionKey, forKey: .actionKey)
    }
}

enum SkillBranch: String, Codable {
    case economy
    case army
}
