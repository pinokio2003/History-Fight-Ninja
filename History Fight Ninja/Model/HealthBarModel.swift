//
//  HealthBarModel.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 12.04.2024.
//

import Foundation
import SpriteKit

class ProgressBar: SKNode {
    
    private var backgroundNode: SKSpriteNode!
    private var progressBarNode: SKSpriteNode!
    private var capsuleNode: SKSpriteNode!
    
        var progress: CGFloat = 0.0 {
            didSet {
                updateProgressBar()
            }
        }
        
        var barWidth: CGFloat {
            return backgroundNode.size.width
        }
        
        var barHeight: CGFloat {
            return backgroundNode.size.height
        }
        
        init(size: CGSize, barColor: SKColor, backgroundColor: SKColor) {
            super.init()
            
            backgroundNode = SKSpriteNode(color: backgroundColor, size: size)
            addChild(backgroundNode)
            
            progressBarNode = SKSpriteNode(color: barColor, size: CGSize(width: size.width, height: 0))
            progressBarNode.anchorPoint = CGPoint(x: 0.5, y: 0)
            progressBarNode.position = CGPoint(x: 0, y: -size.height / 2)
            addChild(progressBarNode)
            
            capsuleNode = SKSpriteNode(imageNamed: "HealthBarCapsule")
//            capsuleNode.size = backgroundNode.size * 2
            capsuleNode.size.width = backgroundNode.size.width * 12
            capsuleNode.size.height = backgroundNode.size.height * 1.2
            capsuleNode.position = CGPoint(x: backgroundNode.position.x - 7, y: backgroundNode.position.y)
            addChild(capsuleNode)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func updateProgressBar() {
            let newHeight = barHeight * progress
            progressBarNode.size.height = newHeight
        }
    }
