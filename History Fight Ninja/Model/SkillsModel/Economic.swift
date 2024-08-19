////
////  Economic.swift
////  History Fight Ninja
////
////  Created by Anatolii Kravchuk on 06.08.2024.
////
//
//import Foundation
//
//
////MARK: Economic:
//let ecnomicSkillArray: [SkillModel] = [economcBasicsManufacturing,
//                                       economcStageOne,
//                                       economcStageTwo,
//                                       economcStageThree,
//                                       economcStageFour,
//                                       economcStageFive,
//                                       economcStageSix,
//                                       economcStageSeven]
//let tradingSkillArray: [SkillModel] =    [tradingStageOne,
//                                       tradingStageTwo,
//                                       tradingStageThree,
//                                       tradingStageFour,
//                                       tradingStageFive,
//                                       tradingStageSix,
//                                       tradingStageSeven,
//                                       tradingStage Eight]

//let economcSklillTree = SkillModel(name: "First",
//                                   description: "Income + 5",
//                                   cost: 120,
//                                   imageName: "Economic",
//                                   isUnlocked: false,
//                                   isAviable: true,
//                                   requiredSkill: [],
//                                   action: {})
////Manufacturing:
///
//let economcBasicsManufacturing = SkillModel(name: "Manufacturing",
//                                      description: "Income +1 for all active economic skill",
//                                      cost: 280,
//                                      imageName: "ManufacturingBasics",
//                                      isUnlocked: false,
//                                      isAviable: true,
//                                            requiredSkill: [economcSklillTree.id],
//                                            action: {})
//let economcStageOne = SkillModel(name: "Automation",
//                                 description: "Reduces costs by 10%",
//                                 cost: 120,
//                                 imageName: "EconomcBasicsAutomation",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                 requiredSkill: [economcBasicsManufacturing.id],
//                                 action: {})
//let economcStageTwo = SkillModel(name: "Modern Tech",
//                                 description: "All industries by 25%",
//                                 cost: 120,
//                                 imageName: "ModernTechnologies",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                 requiredSkill: [economcStageOne.id],
//                                 action: {})
//let economcStageThree = SkillModel(name: "Mass Production",
//                                 description: "All industries by 30%",
//                                 cost: 120,
//                                 imageName: "MassProduction",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                   requiredSkill: [economcStageTwo.id],
//                                   action: {})
//let economcStageFour = SkillModel(name: "Saving Resources",
//                                 description: "Reduces costs by 10%",
//                                 cost: 120,
//                                 imageName: "SavingResources",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                  requiredSkill: [economcStageThree.id],
//                                  action: {})
//let economcStageFive = SkillModel(name: "Innovation",
//                                 description: "Income +4",
//                                 cost: 120,
//                                 imageName: "Innovation",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                  requiredSkill: [economcStageFour.id],
//                                  action: {})
//let economcStageSix = SkillModel(name: "Robotization",
//                                 description: "Reduces costs by 10%",
//                                 cost: 120,
//                                 imageName: "Robotization",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                 requiredSkill: [economcStageFive.id],
//                                 action: {})
//let economcStageSeven = SkillModel(name: "Internationalization",
//                                 description: "Сolonies income +4",
//                                 cost: 120,
//                                 imageName: "Internationalization",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                   requiredSkill: [economcStageSix.id],
//                                   action: {})

////Traidng
//let tradingStageOne = SkillModel(name: "Trading",
//                                 description: "Сolonies income + 2",
//                                 cost: 120,
//                                 imageName: "Trading",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                 requiredSkill: [economcSklillTree.id],
//                                 action: {})
//let tradingStageTwo = SkillModel(name: "Trade agreements",
//                                 description: "Сolonies income +1",
//                                 cost: 120,
//                                 imageName: "TradeAgreements",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                 requiredSkill: [tradingStageOne.id],
//                                 action: {})
//let tradingStageThree = SkillModel(name: "Logistics",
//                                   description: "Сolonies income + 2",
//                                   cost: 120,
//                                   imageName: "logistics",
//                                   isUnlocked: false,
//                                   isAviable: true,
//                                   requiredSkill: [tradingStageTwo.id],
//                                   action: {})
//let tradingStageFour = SkillModel(name: "Trade missions",
//                                  description: "Income + 5",
//                                  cost: 120,
//                                  imageName: "TradeMissions",
//                                  isUnlocked: false,
//                                  isAviable: true,
//                                  requiredSkill: [tradingStageThree.id],
//                                  action: {})
//let tradingStageFive = SkillModel(name: "International exhibitions",
//                                  description: "Сolonies income + 3",
//                                  cost: 120,
//                                  imageName: "InternationalExhibitions",
//                                  isUnlocked: false,
//                                  isAviable: true,
//                                  requiredSkill: [tradingStageFour.id],
//                                  action: {})
//let tradingStageSix = SkillModel(name: "Free Trade Zones",
//                                 description: "Сolonies income + 4",
//                                 cost: 120,
//                                 imageName: "FreeTradeZones",
//                                 isUnlocked: false,
//                                 isAviable: true,
//                                 requiredSkill: [tradingStageFive.id],
//                                 action: {})
//let tradingStageSeven = SkillModel(name: "Tourism development",
//                                   description: "Income + 10",
//                                   cost: 120,
//                                   imageName: "TourismDevelopment",
//                                   isUnlocked: false,
//                                   isAviable: true,
//                                   requiredSkill: [tradingStageSix.id],
//                                   action: {})
//let tradingStageEight = SkillModel(name: "Expansion",
//                                   description: "Income + 10",
//                                   cost: 120,
//                                   imageName: "GlobalExpansion",
//                                   isUnlocked: false,
//                                   isAviable: true,
//                                   requiredSkill: [tradingStageSeven.id],
//                                   action: {})
