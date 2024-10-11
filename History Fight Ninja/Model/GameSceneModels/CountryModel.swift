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
        var shadowColor: UIColor!
        
        switch arc4random_uniform(2) {
        case 1:
            country = enemyTexture
            name = "no"
                shadowColor = .green
        default:
            country = playerName
            name = "yes"
                shadowColor = .red
        }
        
        // Создаем тень как чистый цветной круг
        let shadowSize: CGFloat = 105 // Размер тени
        let shadowSprite = SKShapeNode(circleOfRadius: shadowSize / 2)
        shadowSprite.fillColor = shadowColor
        shadowSprite.strokeColor = .clear
        shadowSprite.alpha = 0.6 // Настройте прозрачность по вашему усмотрению
        shadowSprite.zPosition = -1 // Размещаем тень позади основного спрайта
        addChild(shadowSprite)
        
        // Создаем основной спрайт
        let countrySprite = SKSpriteNode(texture: country)
        countrySprite.size = CGSize(width: 100, height: 100)
        addChild(countrySprite)
        
        physicsBody = SKPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
