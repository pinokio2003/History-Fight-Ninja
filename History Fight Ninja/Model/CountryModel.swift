//
//  CountryModel.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 01.04.2024.
//

import SpriteKit
import GameKit


class CountryModel: SKNode {
    
    override init() {
        super.init()
        
        let germanyTexture = SKTexture(imageNamed: "Germany")
        let greceTexture  = SKTexture(imageNamed: "Grece")
        let russianEmpireTexture  =  SKTexture(imageNamed: "RussianEmpire")
        let serbiaTexture  = SKTexture(imageNamed: "Serbia")
        
//        let lable = SKLabelNode()
        var country: SKTexture!
        
        switch arc4random_uniform(4) {
        case 1:
            country = germanyTexture
            name = "no"
        case 2:
            country = greceTexture
            name = "yes"
        case 3:
            country = russianEmpireTexture
            name = "yes"
        case 4:
            country = serbiaTexture
            name = "yes"
        default:
            country = germanyTexture
            name = "no"
        }
        
        let countrySprite = SKSpriteNode(texture: country)
        countrySprite.size = CGSize(width: 100, height: 100)
        addChild(countrySprite)
        physicsBody = SKPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
