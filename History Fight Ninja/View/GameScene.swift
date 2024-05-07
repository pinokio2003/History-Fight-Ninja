import Foundation
import SpriteKit
import GameKit

class GameScene: SKScene {
    //main
    private let smokeEffect = SKEmitterNode(fileNamed: "smoke")
    private var timer = Timer()
    private var scoreLable = SKLabelNode()
    private var score: Int = 0
    //streak
    private var streakCount: CGFloat = 0
    private var streakIndex: Int = 1
    //healthBar
    private var heroHealthBar = ProgressBar(size: CGSize(width: 20, height: 250),
                                            barColor: .green,
                                            backgroundColor: .gray)
    private var enemyHealthBar = ProgressBar(size: CGSize(width: 20, height: 250),
                                             barColor: .red,
                                             backgroundColor: .gray)
    //Lives
    private var enemyLives: CGFloat = 0.00
    private var heroLives: CGFloat = 0.00
    
    override func didMove(to view: SKView) {
        
        //devices
        let device = UIDevice.current
        if device.userInterfaceIdiom == .pad {
            view.scene?.size = CGSize(width: 1334, height: 750)
            view.scene?.scaleMode = .aspectFit
        } else if device.userInterfaceIdiom == .phone {
            view.scene?.size = CGSize(width: 1334, height: 750)
            view.scene?.scaleMode = .aspectFill
        } else {
            view.scene?.size = CGSize(width: 1334, height: 750)
            view.scene?.scaleMode = .aspectFill
        }
        //main
        anchorPoint = .zero
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)

        timer = .scheduledTimer(timeInterval: 2, target: self, selector: #selector(spawnCountry), userInfo: nil, repeats: true)
        
        heroHealthBar.position = CGPoint(x: size.height * 0.15, y: size.width / 4)
        addChild(heroHealthBar)
        
        enemyHealthBar.position = CGPoint(x: size.height * 1.7, y: size.width / 4)
        addChild(enemyHealthBar)
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            _ = atPoint(location)
            let previousLocation = touch.previousLocation(in: self)
//            addStreak()
            
            for node in nodes(at: location){
                if node.name == "yes" {
                    
                    let emitter = SKEmitterNode(fileNamed: "explousion")
                    emitter?.position = node.position
                    emitter?.zPosition = 5
                    addChild(emitter!)
                    addScore()
                    addStreak()
                    
                    node.removeFromParent()
                }
                
                if node.name == "no" {
                    node.removeFromParent()
                    minusLives()
                }
                
                if enemyLives >= 1 {
                    gameOver()
                }
                if heroLives >= 1 {
                    levelComplete()
                }
            }
            
            let path = CGMutablePath()
            path.move(to: location)
            path.addLine(to: previousLocation)
            
            let line = SKShapeNode(path: path)
            line.lineWidth = 8
            line.strokeColor = .black
            addChild(line)
            
            let fadeout = SKAction.fadeOut(withDuration: 0.3)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([fadeout, remove])
            line.run(sequence)
        }
    }
    
    @objc func spawnCountry(){
        
        let randomNumber = Int(GKRandomDistribution(lowestValue: 3, highestValue: 6).nextInt())
        
        for _ in 0..<randomNumber {
            let country = CountryModel()
            country.position = CGPoint(x: GKRandomDistribution(lowestValue: 20, highestValue: Int(size.width)).nextInt(), y: -50)
            country.zPosition = 10
            addChild(country)
            
            if country.position.x < size.width / 2 {
                country.physicsBody?.velocity.dx = CGFloat(arc4random_uniform(300))
            }
            
            if country.position.x > size.width / 2 {
                country.physicsBody?.velocity.dx = CGFloat(-200)
            }
            
            country.physicsBody?.velocity.dy = CGFloat(GKRandomDistribution(lowestValue: 500, highestValue: 700).nextInt())
            country.physicsBody?.angularVelocity = CGFloat(GKRandomDistribution(lowestValue: -5, highestValue: 5).nextInt())
        }
        
    }
    
    func gameOver() {
        let gameOverScene = GameOver(fileNamed: "GameOver")
        view?.presentScene(gameOverScene)
    }
    
    func levelComplete() {
        let levelCompleteScene = GameWin(fileNamed: "GameWin")
        view?.presentScene(levelCompleteScene)
    }
    
    func addScore() {
        scoreLable = childNode(withName: "scoreLable") as! SKLabelNode
        score += 1
        streakCount += 1
        heroHealthBar.progress += (0.01 * CGFloat(streakIndex))
        heroLives = heroHealthBar.progress
        print("lives: \(heroLives)")
        print("bar: \(heroHealthBar.progress)")
        scoreLable.text = "Score: \(score)"
    }
    
    func addStreak() {
        if Int(streakCount) % 5 == 1 && score > 5 {
            let indx = Int(streakCount) / 5 + 1
            streakIndex = indx
            let streak = Streak(text: "X-\(String(indx))", fontSize: 155)
            streak.showFor(duration: 2, in: self, at: CGPoint(x: size.height/1.2, y: size.width/4))
        }
    }

    
    func minusLives() {
        enemyHealthBar.progress += 0.1
        enemyLives += 0.1
        streakCount = 1
    }
}
