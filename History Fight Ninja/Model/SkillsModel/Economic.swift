////
////  Economic.swift
////  History Fight Ninja
////
////  Created by Anatolii Kravchuk on 06.08.2024.
////
//
import SwiftUI
//

func defaultEconomySkills(manager: SkillTreeManager) -> [Skill] {
    let economic = UUID()
    
    let manufacturing = UUID()
    let automation = UUID()
    let modernTech = UUID()
    let massProduction = UUID()
    let savingResources = UUID()
    let innovation = UUID()
    let robotization = UUID()
    let internationalization = UUID()
    
    let trading = UUID()
    let tradeAgreements = UUID()
    let logistics = UUID()
    let tradeMissions = UUID()
    let freeTradeZones = UUID()
    let tourism = UUID()
    let expansion = UUID()
    let exhibition = UUID() //TODO: add image and description
    
    return [
        Skill(id: economic,
              name: "Economic",
              description: "Income + 5",
              branch: .economy,
              isUnlocked: true,
              isPurchased: false,
              imageName: "Economic",
              action: {},
              dependencies: [],
              position: CGPoint(x: 0.55, y: 0.01)),
//MARK: - Manufacturing:
        Skill(id: manufacturing,
              name: "Manufacturing",
              description: "Income +1 for all economic skills",
              branch: .economy,
              isUnlocked: false,
              isPurchased: false,
              imageName: "ManufacturingBasics",
              action: { manager.increaseIncome() },
              dependencies: [economic],
              position: CGPoint(x: 0.35, y: 0.1)),
        Skill(id: automation,
              name: "Automation",
              description: "Reduces costs -5%",
              branch: .economy,
              isUnlocked: true,
              isPurchased: false,
              imageName: "EconomcBasicsAutomation",
              action: { manager.increaseIncome() },
              dependencies: [manufacturing],
              position: CGPoint(x: 0.15, y: 0.2)),
        Skill(id: modernTech,
              name: "Modern Tech",
              description: "Income +2",
              branch: .economy, isUnlocked: false,
              isPurchased: false,
              imageName: "ModernTechnologies",
              action: { manager.increaseIncome() },
              dependencies: [manufacturing],
              position: CGPoint(x: 0.30, y: 0.2)),
        Skill(id: massProduction,
              name: "Mass Production",
              description: "Reduces costs -10%",
              branch: .economy,
              isUnlocked: true,
              isPurchased: false,
              imageName: "MassProduction",
              action: { manager.increaseIncome() },
              dependencies: [manufacturing],
              position: CGPoint(x: 0.45, y: 0.2)),
        Skill(id: savingResources,
              name: "Saving Resources",
              description: "Income + 5",
              branch: .economy,
              isUnlocked: false,
              isPurchased: false,
              imageName: "SavingResources",
              action: { manager.increaseIncome() },
              dependencies: [automation],
              position: CGPoint(x: 0.15, y: 0.3)),
        Skill(id: innovation,
              name: "Innovation",
              description: "Income +5",
              branch: .economy,
              isUnlocked: true,
              isPurchased: false,
              imageName: "Innovation",
              action: { manager.increaseIncome() },
              dependencies: [modernTech],
              position: CGPoint(x: 0.3, y: 0.3)),
        Skill(id: robotization,
              name: "Robotization",
              description: "Reduces costs -10%",
              branch: .economy, isUnlocked: false,
              isPurchased: false, imageName: "Robotization",
              action: { manager.increaseIncome() },
              dependencies: [innovation, massProduction],
              position: CGPoint(x: 0.45, y: 0.3)),
        Skill(id: internationalization,
              name: "Internationalization",
              description: "Income +10",
              branch: .economy, isUnlocked: false,
              isPurchased: false, imageName: "Internationalization",
              action: { manager.increaseIncome() },
              dependencies: [savingResources],
              position: CGPoint(x: 0.37, y: 0.37)),
//MARK: - Traidng:
        Skill(id: trading,
              name: "Trading",
              description: "Сolonies income + 2",
              branch: .economy,
              isUnlocked: false,
              isPurchased: false,
              imageName: "Trading",
              action: { manager.increaseIncome() },
              dependencies: [economic],
              position: CGPoint(x: 0.75, y: 0.1)),
        
        Skill(id: tradeAgreements,
              name: "Trade agreements",
              description: "Сolonies income +1",
              branch: .economy,
              isUnlocked: true,
              isPurchased: false,
              imageName: "TradeAgreements",
              action: { manager.increaseIncome() },
              dependencies: [trading],
              position: CGPoint(x: 0.65, y: 0.2)),
        
        Skill(id: logistics,
              name: "Logistics",
              description: "Сolonies income + 2",
              branch: .economy,
              isUnlocked: false,
              isPurchased: false,
              imageName: "logistics",
              action: { manager.increaseIncome() },
              dependencies: [trading],
              position: CGPoint(x: 0.80, y: 0.2)),
        
        Skill(id: tradeMissions,
              name: "Trade missions",
              description: "Income + 5",
              branch: .economy,
              isUnlocked: true,
              isPurchased: false,
              imageName: "TradeMissions",
              action: { manager.increaseIncome() },
              dependencies: [trading],
              position: CGPoint(x: 0.95, y: 0.2)),
        
        Skill(id: freeTradeZones,
              name: "Free Trade Zones",
              description: "Сolonies income + 2",
              branch: .economy,
              isUnlocked: true,
              isPurchased: false,
              imageName: "FreeTradeZones",
              action: { manager.increaseIncome() },
              dependencies: [tradeAgreements, tourism],
              position: CGPoint(x: 0.65, y: 0.3)),
        
        Skill(id: tourism,
              name: "Tourism development",
              description: "Сolonies income + 3",
              branch: .economy,
              isUnlocked: false,
              isPurchased: false,
              imageName: "TourismDevelopment",
              action: { manager.increaseIncome() },
              dependencies: [logistics],
              position: CGPoint(x: 0.80, y: 0.3)),
        
        Skill(id: expansion,
              name: "Expansion",
              description: "Income + 5",
              branch: .economy,
              isUnlocked: true,
              isPurchased: false,
              imageName: "GlobalExpansion",
              action: { manager.increaseIncome() },
              dependencies: [tradeMissions],
              position: CGPoint(x: 0.95, y: 0.3)),
        
        Skill(id: exhibition,
              name: "Trade missions",
              description: "Income + 10",
              branch: .economy,
              isUnlocked: true,
              isPurchased: false,
              imageName: "TradeMissions",
              action: { manager.increaseIncome() },
              dependencies: [expansion],
              position: CGPoint(x: 0.73, y: 0.37)),
    ]
}
