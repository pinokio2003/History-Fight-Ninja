//
//  PauseButton.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 10.07.2024.
//

import SpriteKit

class PauseButton: SKSpriteNode {
    private var button: SKSpriteNode
    private var isPlaying: Bool = true
    var toggleAction: (() -> Void)?
    
    init(size: CGSize) {
        button = SKSpriteNode(imageNamed: "pauseButton")
        button.size = size
        super.init(texture: nil, color: .clear, size: size)
        isUserInteractionEnabled = true
        addChild(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle() {
        isPlaying = !isPlaying
        let textureName = isPlaying ? "pauseButton" : "unpauseButton"
        button.texture = SKTexture(imageNamed: textureName)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        toggleAction?()
    }
    
    override var isUserInteractionEnabled: Bool {
        get { return true }
        set { }
    }
}
