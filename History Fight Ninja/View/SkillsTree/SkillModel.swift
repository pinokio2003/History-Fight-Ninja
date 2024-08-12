//
//  SkillModel.swift
//  SkillTree
//
//  Created by Anatolii Kravchuk on 19.07.2024.
//

import SwiftUI

struct SkillModel: Identifiable {
    var id = UUID()
    let name: String
    let description: String
    let cost: Int
    var imageName: String
    var isUnlocked: Bool
    var isAviable: Bool
    var requiredSkill: [UUID]
    var action: () -> Void

    func image() -> Image {
        if let cachedImage = ImageCache.shared.getImage(forKey: imageName) {
            return Image(uiImage: cachedImage)
        } else {
            let newImage = UIImage(named: imageName) ?? UIImage()
            ImageCache.shared.setImage(newImage, forKey: imageName)
            return Image(uiImage: newImage)
        }
    }
}

// Пример SkillModel для использования в Preview
let exampleSkill = SkillModel(
    id: UUID(),
    name: "Example Skill",
    description: "This is an example skill for preview",
    cost: 100,
    imageName: "ManufacturingBasics",
    isUnlocked: false,
    isAviable: true,
    requiredSkill: [],
    action: {}
)


// Image cache
class ImageCache {
    static let shared = ImageCache()
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
