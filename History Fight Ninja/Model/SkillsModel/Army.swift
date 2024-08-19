////
////  Army.swift
////  History Fight Ninja
////
////  Created by Anatolii Kravchuk on 06.08.2024.
////
//
//import Foundation
//
////MARK: - Army
//
//
//
//let militarySkillArray: [SkillModel] =    [militaryBasicsManufacturing,
//                                           militaryStageOne,
//                                           militaryStageTwo,
//                                           militaryStageThree,
//                                           militaryStageFour,
//                                           militaryStageFive,
//                                           militaryStageSix,
//                                           militaryStageSeven]
//
//
//let militarySklillTree = SkillModel(name: "Military",
//                                    description: "Attack + 5",
//                                    cost: 120,
//                                    imageName: "warCraft",
//                                    isUnlocked: false,
//                                    isAviable: true,
//                                    requiredSkill: [],
//                                    action: {print("It,s working")})
////Manufacturing:
//let militaryBasicsManufacturing = SkillModel(name: "Shooting",
//                                             description: "Attack +1 for all active war skill",
//                                             cost: 120,
//                                             imageName: "shooting",
//                                             isUnlocked: false,
//                                             isAviable: true,
//                                             requiredSkill: [militarySklillTree.id],
//                                             action: {})
//let militaryStageOne = SkillModel(name: "Tactics",
//                                  description: "Hit points +2",
//                                  cost: 120,
//                                  imageName: "tactical",
//                                  isUnlocked: false,
//                                  isAviable: true,
//                                  requiredSkill: [militaryBasicsManufacturing.id],
//                                  action: {})
//let militaryStageTwo = SkillModel(name: "Intelligence",
//                                  description: "Attack +2",
//                                  cost: 120,
//                                  imageName: "intelligence",
//                                  isUnlocked: false,
//                                  isAviable: true,
//                                  requiredSkill: [militaryStageOne.id],
//                                  action: {})
//let militaryStageThree = SkillModel(name: "Defense",
//                                    description: "Hit points +2",
//                                    cost: 120,
//                                    imageName: "defense",
//                                    isUnlocked: false,
//                                    isAviable: true,
//                                    requiredSkill: [militaryStageTwo.id],
//                                    action: {})
//let militaryStageFour = SkillModel(name: "Flanking attack",
//                                   description: "Attack +3",
//                                   cost: 120,
//                                   imageName: "flanking",
//                                   isUnlocked: false,
//                                   isAviable: true,
//                                   requiredSkill: [militaryStageThree.id],
//                                   action: {})
//
//
//let militaryStageFive = SkillModel(name: "Artillery",
//                                   description: "Attack +3",
//                                   cost: 120,
//                                   imageName: "artillery",
//                                   isUnlocked: false,
//                                   isAviable: true,
//                                   requiredSkill: [militaryStageFour.id],
//                                   action: {})
//
//let militaryStageSix = SkillModel(name: "Naval forces",
//                                  description: "Attack, hit points +2",
//                                  cost: 120,
//                                  imageName: "Innovation",
//                                  isUnlocked: false,
//                                  isAviable: true,
//                                  requiredSkill: [militaryStageFive.id],
//                                  action: {})
//
//let militaryStageSeven = SkillModel(name: "Air forces",
//                                    description: "Сolonies income +4",
//                                    cost: 120,
//                                    imageName: "aerial",
//                                    isUnlocked: false,
//                                    isAviable: true,
//                                    requiredSkill: [militaryStageSix.id],
//                                    action: {})
