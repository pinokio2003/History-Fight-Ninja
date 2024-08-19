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
    var isUnlocked: Bool
    var isPurchased: Bool
    let imageName: String
    let action: () -> Void // Замыкание нельзя закодировать напрямую
    let dependencies: [UUID]
    let position: CGPoint
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, branch, isUnlocked, isPurchased, imageName, dependencies, positionX, positionY
    }
    
    init(id: UUID, name: String, description: String, branch: SkillBranch, isUnlocked: Bool, isPurchased: Bool, imageName: String, action: @escaping () -> Void, dependencies: [UUID], position: CGPoint) {
        self.id = id
        self.name = name
        self.description = description
        self.branch = branch
        self.isUnlocked = isUnlocked
        self.isPurchased = isPurchased
        self.imageName = imageName
        self.action = action
        self.dependencies = dependencies
        self.position = position
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        branch = try container.decode(SkillBranch.self, forKey: .branch)
        isUnlocked = try container.decode(Bool.self, forKey: .isUnlocked)
        isPurchased = try container.decode(Bool.self, forKey: .isPurchased)
        imageName = try container.decode(String.self, forKey: .imageName)
        dependencies = try container.decode([UUID].self, forKey: .dependencies)
        let x = try container.decode(CGFloat.self, forKey: .positionX)
        let y = try container.decode(CGFloat.self, forKey: .positionY)
        position = CGPoint(x: x, y: y)
        
        action = {} // Замыкание по умолчанию (его не сохраняем)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(branch, forKey: .branch)
        try container.encode(isUnlocked, forKey: .isUnlocked)
        try container.encode(isPurchased, forKey: .isPurchased)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(dependencies, forKey: .dependencies)
        try container.encode(position.x, forKey: .positionX)
        try container.encode(position.y, forKey: .positionY)
    }
}

enum SkillBranch: String, Codable {
    case economy
    case army
}
