////
////  Army.swift
////  History Fight Ninja
////
////  Created by Anatolii Kravchuk on 06.08.2024.
////
//
import Foundation
import SwiftUI

    func defaultArmySkills(manager: SkillTreeManager) -> [Skill] {
        let military = UUID()
        
        let shooting = UUID()
        let tactics = UUID()
        let intelligence = UUID()
        let defense = UUID()
        let flanking = UUID()
        let artillery = UUID()
        let navalForces = UUID()
        
        let airForces = UUID()
        
        let supply = UUID()
        
        let milLogistics = UUID()
        let transportation = UUID()
        let medicalServices = UUID()
        
        let repair = UUID()
        let modernShelters = UUID()
        let drones = UUID()
        
        let spaceForces = UUID()
        
        let wrathOfGod = UUID()
        
        return [
            Skill(id: military,
                  name: "Military",
                  description: "Attack + 5",
                  branch: .army,
                  cost: 222,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "warCraft",
                  action: {},
                  dependencies: [],
                  position: CGPoint(x: 0.55, y: 0.01)),
            //MARK: - tactics:
            Skill(id: shooting,
                  name: "Shooting",
                  description: "Attack +1 for all skill",
                  branch: .army,
                  cost: 111,
                  isUnlocked: false,
                  isPurchased: false,
                  imageName: "shooting",
                  action: { manager.increaseIncome() },
                  dependencies: [military],
                  position: CGPoint(x: 0.35, y: 0.1)),
            Skill(id: intelligence,
                  name: "Intelligence",
                  description: "Hit points +2",
                  branch: .army,
                  cost: 111,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "intelligence",
                  action: { manager.increaseIncome() },
                  dependencies: [shooting],
                  position: CGPoint(x: 0.15, y: 0.2)),
            Skill(id: tactics,
                  name: "Tactics",
                  description: "Hit points +2",
                  branch: .army,
                  cost: 111,
                  isUnlocked: false,
                  isPurchased: false,
                  imageName: "tactical",
                  action: { manager.increaseIncome() },
                  dependencies: [shooting],
                  position: CGPoint(x: 0.30, y: 0.2)),
            Skill(id: defense,
                  name: "Defense",
                  description: "Hit points +2",
                  branch: .army,
                  cost: 111,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "defense",
                  action: { manager.increaseIncome() },
                  dependencies: [shooting],
                  position: CGPoint(x: 0.45, y: 0.2)),
            Skill(id: flanking,
                  name: "Flanking attack",
                  description: "Attack +3",
                  branch: .army,
                  cost: 111,
                  isUnlocked: false,
                  isPurchased: false,
                  imageName: "flanking",
                  action: { manager.increaseIncome() },
                  dependencies: [intelligence],
                  position: CGPoint(x: 0.15, y: 0.3)),
            Skill(id: artillery,
                  name: "Artillery",
                  description: "Attack +5",
                  branch: .army,
                  cost: 111,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "artillery",
                  action: { manager.increaseIncome() },
                  dependencies: [tactics],
                  position: CGPoint(x: 0.3, y: 0.3)),
            Skill(id: navalForces,
                  name: "Naval forces",
                  description: "Attack +3%",
                  branch: .army,
                  cost: 111,
                  isUnlocked: false,
                  isPurchased: false, imageName: "naval",
                  action: { manager.increaseIncome() },
                  dependencies: [defense],
                  position: CGPoint(x: 0.45, y: 0.3)),
            Skill(id: airForces,
                  name: "Air forces",
                  description: "Attack +7%",
                  branch: .army,
                  cost: 111,
                  isUnlocked: false,
                  isPurchased: false,
                  imageName: "aerial",
                  action: { manager.increaseIncome() },
                  dependencies: [flanking],
                  position: CGPoint(x: 0.37, y: 0.37)),
            //MARK: - Supply:
            Skill(id: supply,
                  name: "Army Supply",
                  description: "Health +1",
                  branch: .army,
                  cost: 111,
                  isUnlocked: false,
                  isPurchased: false,
                  imageName: "ArmySupply",
                  action: { manager.increaseIncome() },
                  dependencies: [military],
                  position: CGPoint(x: 0.75, y: 0.1)),
            
            Skill(id: milLogistics,
                  name: "Military logistics",
                  description: "???",
                  branch: .army,
                  cost: 111,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "logisticsArmy",
                  action: { manager.increaseIncome() },
                  dependencies: [supply],
                  position: CGPoint(x: 0.65, y: 0.2)),
            Skill(id: transportation,
                  name: "Logistics",
                  description: "???",
                  branch: .army,
                  cost: 111,
                  isUnlocked: false,
                  isPurchased: false,
                  imageName: "transportation",
                  action: { manager.increaseIncome() },
                  dependencies: [supply],
                  position: CGPoint(x: 0.80, y: 0.2)),
            Skill(id: medicalServices,
                  name: "Medical Services",
                  description: "???",
                  branch: .army,
                  cost: 111,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "medicalServices",
                  action: { manager.increaseIncome() },
                  dependencies: [supply],
                  position: CGPoint(x: 0.95, y: 0.2)),
            
            Skill(id: repair,
                  name: "Repair",
                  description: "???",
                  branch: .army,
                  cost: 111,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "repair",
                  action: { manager.increaseIncome() },
                  dependencies: [milLogistics],
                  position: CGPoint(x: 0.65, y: 0.3)),
            
            Skill(id: modernShelters,
                  name: "Modern Shelters",
                  description: "Health +5",
                  branch: .army,
                  cost: 111,
                  isUnlocked: false,
                  isPurchased: false,
                  imageName: "modernShelters",
                  action: { manager.increaseIncome() },
                  dependencies: [transportation],
                  position: CGPoint(x: 0.80, y: 0.3)),
            
            Skill(id: drones,
                  name: "Drones",
                  description: "Attack +5",
                  branch: .army,
                  cost: 111,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "drones",
                  action: { manager.increaseIncome() },
                  dependencies: [medicalServices],
                  position: CGPoint(x: 0.95, y: 0.3)),
            
            Skill(id: spaceForces,
                  name: "Space Forces",
                  description: "??",
                  branch: .army,
                  cost: 111,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "spaceForces",
                  action: { manager.increaseIncome() },
                  dependencies: [drones],
                  position: CGPoint(x: 0.73, y: 0.37)),
            
            Skill(id: wrathOfGod,
                  name: "Wrath Of God",
                  description: "Give WoG to in battle",
                  branch: .army,
                  cost: 111,
                  isUnlocked: true,
                  isPurchased: false,
                  imageName: "WrathOfGod",
                  action: { manager.increaseIncome() },
                  dependencies: [airForces, spaceForces],
                  position: CGPoint(x: 0.55, y: 0.45))
        ]
    }

//
//let militaryStageSeven = SkillModel(name: "Air forces",
//                                    description: "Сolonies income +4",
//                                    cost: 120,
//                                    imageName: "aerial",
//                                    isUnlocked: false,
//                                    isAviable: true,
//                                    requiredSkill: [militaryStageSix.id],
//                                    action: {})
