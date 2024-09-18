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
        
        let enemyTexture = SKTexture(imageNamed: HeroData.shared.enemyName)
        let playerName = SKTexture(imageNamed: HeroData.shared.playerCountry)
            
        var country: SKTexture!
        
        switch arc4random_uniform(2) {
        case 1:
            country = enemyTexture
            name = "no"
        default:
            country = playerName
            name = "yes"
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
