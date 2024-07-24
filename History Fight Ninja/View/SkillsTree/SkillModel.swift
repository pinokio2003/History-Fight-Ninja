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
    requiredSkill: []
)

//MARK: Economic:
let ecnomicSkillArray: [SkillModel] = [economcBasicsManufacturing,
                                       economcStageOne,
                                       economcStageTwo,
                                       economcStageThree,
                                       economcStageFour,
                                       economcStageFive,
                                       economcStageSix,
                                       economcStageSeven]
let tradingSkillArray: [SkillModel] =    [tradingStageOne,
                                       tradingStageTwo,
                                       tradingStageThree,
                                       tradingStageFour,
                                       tradingStageFive,
                                       tradingStageSix,
                                       tradingStageSeven,
                                       tradingStageEight]
let economcSklillTree = SkillModel(name: "First",
                                   description: "Income + 5",
                                   cost: 120,
                                   imageName: "Economic",
                                   isUnlocked: false,
                                   isAviable: true,
                                   requiredSkill: [])
//Manufacturing:
let economcBasicsManufacturing = SkillModel(name: "Manufacturing",
                                      description: "Income +1 for all active economic skill",
                                      cost: 280,
                                      imageName: "ManufacturingBasics",
                                      isUnlocked: false,
                                      isAviable: true,
                                            requiredSkill: [economcSklillTree.id])
let economcStageOne = SkillModel(name: "Automation",
                                 description: "Reduces costs by 10%",
                                 cost: 120,
                                 imageName: "EconomcBasicsAutomation",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [economcBasicsManufacturing.id])
let economcStageTwo = SkillModel(name: "Modern Tech",
                                 description: "All industries by 25%",
                                 cost: 120,
                                 imageName: "ModernTechnologies",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [economcStageOne.id])
let economcStageThree = SkillModel(name: "Mass Production",
                                 description: "All industries by 30%",
                                 cost: 120,
                                 imageName: "MassProduction",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [economcStageTwo.id])
let economcStageFour = SkillModel(name: "Saving Resources",
                                 description: "Reduces costs by 10%",
                                 cost: 120,
                                 imageName: "SavingResources",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [economcStageThree.id])
let economcStageFive = SkillModel(name: "Innovation",
                                 description: "Income +4",
                                 cost: 120,
                                 imageName: "Innovation",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [economcStageFour.id])
let economcStageSix = SkillModel(name: "Robotization",
                                 description: "Reduces costs by 10%",
                                 cost: 120,
                                 imageName: "Robotization",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [economcStageFive.id])
let economcStageSeven = SkillModel(name: "Internationalization",
                                 description: "Сolonies income +4",
                                 cost: 120,
                                 imageName: "Internationalization",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [economcStageSix.id])
//Traidng
let tradingStageOne = SkillModel(name: "Trading",
                                 description: "Сolonies income + 2",
                                 cost: 120,
                                 imageName: "Trading",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [economcSklillTree.id])
let tradingStageTwo = SkillModel(name: "Trade agreements",
                                 description: "Сolonies income +1",
                                 cost: 120,
                                 imageName: "TradeAgreements",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [tradingStageOne.id])
let tradingStageThree = SkillModel(name: "Logistics",
                                   description: "Сolonies income + 2",
                                   cost: 120,
                                   imageName: "logistics",
                                   isUnlocked: false,
                                   isAviable: true,
                                   requiredSkill: [tradingStageTwo.id])
let tradingStageFour = SkillModel(name: "Trade missions",
                                  description: "Income + 5",
                                  cost: 120,
                                  imageName: "TradeMissions",
                                  isUnlocked: false,
                                  isAviable: true,
                                  requiredSkill: [tradingStageThree.id])
let tradingStageFive = SkillModel(name: "International exhibitions",
                                  description: "Сolonies income + 3",
                                  cost: 120,
                                  imageName: "InternationalExhibitions",
                                  isUnlocked: false,
                                  isAviable: true,
                                  requiredSkill: [tradingStageFour.id])
let tradingStageSix = SkillModel(name: "Free Trade Zones",
                                 description: "Сolonies income + 4",
                                 cost: 120,
                                 imageName: "FreeTradeZones",
                                 isUnlocked: false,
                                 isAviable: true,
                                 requiredSkill: [tradingStageFive.id])
let tradingStageSeven = SkillModel(name: "Tourism development",
                                   description: "Income + 10",
                                   cost: 120,
                                   imageName: "TourismDevelopment",
                                   isUnlocked: false,
                                   isAviable: true,
                                   requiredSkill: [tradingStageSix.id])
let tradingStageEight = SkillModel(name: "Expansion",
                                   description: "Income + 10",
                                   cost: 120,
                                   imageName: "GlobalExpansion",
                                   isUnlocked: false,
                                   isAviable: true,
                                   requiredSkill: [tradingStageSeven.id])

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
