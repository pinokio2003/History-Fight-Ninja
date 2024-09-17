//import SwiftUI
import SpriteKit
import GameKit
import SwiftUI

class GameScene: SKScene {
    //hero Data
    let heroData = HeroData.shared
    //For callback ContentView
    var levelCompleteCallback: (() -> Void)?
    //Devices
    let device = UIDevice.current
    //main
    private let smokeEffect = SKEmitterNode(fileNamed: "smoke")
    private var spawnTimer = Timer()
    private var scoreLable = SKLabelNode()
    private var score: Int = 0
    private var gameTimerLable = SKLabelNode()
    private var time: Int = 60
    private var gameTimer = Timer()
    private var isGameOver = false
    //streak
    private var streakCount: Int = 0
    private var streakIndex: Int = 1
    private var streakPool: [Streak] = []
    //countdown timer preview
    private var countTime = Timer()
    private var countdownTimerNode = SKLabelNode(fontNamed: "Chalkduster")
    private var countdownTime: Int = 3
    //Pause button
    private var pauseButton: PauseButton?
    private var isPause = false
    private var pausedCountryStates: [(node: CountryModel, position: CGPoint, velocity: CGVector)] = []
    
    //healthBar
    private var heroHealthBar = ProgressBar(size: Constants.HealthBar.size,
                                            barColor: Constants.HealthBar.heroColor,
                                            backgroundColor: Constants.HealthBar.backgroundColor)
    var playerHealth: PlayerHealth!

    //Score
    private var heroScore = SKLabelNode(fontNamed: "Chalkduster")
    private var enemyScore = SKLabelNode(fontNamed: "Chalkduster")

    //Lives
    let countryManager = CountryDataManager.shared
    private var enemyLives: CGFloat = 0.00
    private var heroLives: CGFloat = 0.00
    
    override func didMove(to view: SKView) {
        isUserInteractionEnabled = true
        heroData.resetScoreAndTime()
     
        //devices
        
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
        
        for _ in 0..<5 {  // Предположим, нам нужно максимум 5 объектов
            let streak = Streak(text: "", fontSize: 155)
            streak.isHidden = true
            addChild(streak)
            streakPool.append(streak)
        }
    
        
        setupScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if pauseButton?.contains(location) == true {
            pauseButton?.touchesBegan(touches, with: event)
            return
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isPaused && !isGameOver else { return }
        
        for touch in touches {
            let location = touch.location(in: self)
            _ = atPoint(location)
            let previousLocation = touch.previousLocation(in: self)
            
            for node in nodes(at: location){
                if node.name == "no" {
                    
                    let emitter = SKEmitterNode(fileNamed: "explousion")
                    emitter?.position = node.position
                    emitter?.zPosition = 5
                    addChild(emitter!)
                    addScore(enemyPower: countryManager.countryPowerMap[heroData.name]!)
                    addStreak()
                    node.removeFromParent()
                }
                
                if node.name == "yes" {
                    node.removeFromParent()
                    minusLives() //countryDataManager.countryPowerMap[heroData.name]
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
    //MARK: - Spawn country models
    @objc func spawnCountry(){
        
        let randomNumber = Int(GKRandomDistribution(lowestValue: Constants.spawnMinValue,
                                                    highestValue: Constants.spawnMaxValue).nextInt())
        for _ in 0..<randomNumber {
            let country = CountryModel()
            country.position = CGPoint(x: GKRandomDistribution(lowestValue: Constants.spawnMinX, highestValue: Int(size.width)).nextInt(), y: -50)
            country.zPosition = 10
            addChild(country)
            
            if country.position.x < size.width / 2 {
                country.physicsBody?.velocity.dx = CGFloat(arc4random_uniform(300))
            }
            
            if country.position.x > size.width / 2 {
                country.physicsBody?.velocity.dx = CGFloat(-200)
            }
            
            country.physicsBody?.velocity.dy = CGFloat(GKRandomDistribution(lowestValue: Constants.spawnMinVelocityY, highestValue: Constants.spawnMaxVelocityY).nextInt())
            country.physicsBody?.angularVelocity = CGFloat(GKRandomDistribution(lowestValue: Constants.spawnMinAngularVelocity, highestValue: Constants.spawnMaxAngularVelocity).nextInt())
        }
    }
    
    //MARK: - Setup Scene
    private func setupScene() {
        //main
        anchorPoint = .zero
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        heroHealthBar.position = CGPoint(x: size.height * 0.15, y: size.width / 4)
        addChild(heroHealthBar)

        setupPlayerHealth()
        // Start Countdown
        startCountdown()
    }
    //MARK: - Game Over
    func gameOver() {
        guard !isGameOver else { return }
        isGameOver = true
        
        let heroData = HeroData.shared
        cancelTimers()
        removeAllCountries()
        
        heroData.isRestartPushing = false
        
        guard let view = view else {
            print("Error: Scene is not available.")
            return
        }
        
        let fadeOutAction = SKAction.fadeOut(withDuration: Constants.fadeOutDuration)
        
        view.scene?.run(fadeOutAction) {
            if let window = view.window {
                UIView.transition(with: window, duration: Constants.fadeOutDuration, options: .transitionCrossDissolve, animations: {
                    view.presentScene(nil)
                    // Create the new SwiftUI view and hosting controller
                    let gameOverView = GameOvewView()
                    let hostController = UIHostingController(rootView: gameOverView)
                    let navController = UINavigationController(rootViewController: hostController)
                    window.rootViewController = navController
                }, completion: { _ in
                    // Explicitly release the current scene to free up memory
                    self.removeAllActions()
                    self.removeAllChildren()
                    self.removeFromParent()
                })
            }
        }
    }
    
    func startNewGame() {
        isGameOver = false
    }
    
    //MARK: level complete
    func levelComplete() {
        let heroData = HeroData.shared
        heroData.gameTime = time
        heroData.playerScore = score
        let newPower = heroData.playerPower // if needed
        removeAllCountries()
        cancelTimers()
        countryManager.updateCountryColor(byName: heroData.enemyName, newColor: .green, newPower: newPower)
        countryManager.updateCountryBackgroundColor()
        heroData.resetAllData()
        
        if let view = view, let window = view.window {
            // Удаление всех дочерних узлов и самой сцены
            view.presentScene(nil)
            let contentView = ScoreBoardView()
            let hostController = UIHostingController(rootView: contentView)
            let navController = UINavigationController(rootViewController: hostController)
            window.rootViewController = navController
        }
    }
    
    func addScore(enemyPower: Int) {
        let heroAttack = Double(heroData.playerAttack) * 0.0001
        let enemyHealth = Double((1000) / enemyPower ) * 0.001
        scoreLable = childNode(withName: "scoreLable") as! SKLabelNode
        score += 1
        streakCount += 1
        scoreLable.text = "Score: \(score)"
        //enemy health + helth bar
        heroHealthBar.progress += (enemyHealth * CGFloat(streakIndex) + heroAttack)//+= (CGFloat((enemyPower / 100)) * CGFloat(streakIndex))
        heroLives = heroHealthBar.progress
        print(heroAttack)
        print(heroLives)
    }
  //MARK: - Scores, streaks and others:
    
    func addStreak() {
            if Int(streakCount) % 5 == 1 && score > 5 {
                let indx = Int(streakCount) / 5 + 1
                if streakIndex >= heroData.maxStreak {
                    streakIndex = heroData.maxStreak
                    print("streak index < maxStreak: \(streakIndex), max streak : \(heroData.maxStreak)")
                } else {
                    streakIndex = indx
                    print("streak index else: \(streakIndex)")
                }

                if let streak = streakPool.first(where: { $0.isHidden }) {
                    let newText = "X-\(String(streakIndex))"
                    streak.updateText(newText)
                    streak.isHidden = false
                    streak.showFor(duration: 2, in: self, at: CGPoint(x: size.height/1.2, y: size.width/4))
                }
            }
        }
//MARK: - Health Player:
    func setupPlayerHealth() {
        let maxHealthCount = heroData.playerHealth - 3
        var healthPosition = CGPoint(x: size.width, y: size.height)
        
        if device.userInterfaceIdiom == .pad {
            healthPosition = CGPoint(x: size.width - 80, y: size.height / 2 - CGFloat(maxHealthCount * 40))
        } else {
            healthPosition = CGPoint(x: size.width - 80, y: size.height / 2 - CGFloat(maxHealthCount * 40))
        }

        playerHealth = PlayerHealth(maxHealth: heroData.playerHealth,
                                    parentNode: self,
                                    healthImageName: "health",
                                    position: healthPosition,
                                    spriteSize: 40,
                                    spacing: 5)
    }
    
    
    func minusLives() {
        playerHealth.decreaseHealth()
        streakCount = 1
        if playerHealth.getCurrentHealth() == 0 {
            gameOver()
        }
    }
    
    func startCountdown() {
        countdownTimerNode.text = "\(countdownTime)"
        countdownTimerNode.fontSize = 250
        countdownTimerNode.fontColor = .red
        countdownTimerNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        countdownTimerNode.zPosition = 100
        addChild(countdownTimerNode)
        
        countTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    //Start timer before "Go"
    @objc func updateCountdown() {
        countdownTime -= 1
        if countdownTime > 0 {
            countdownTimerNode.text = "\(countdownTime)"
        }
        if countdownTime == 0 {
            countdownTimerNode.text = "GO !"
            startSpawnTimer()
            globalGameTimer()
        }
        if countdownTime < 0 {
            countTime.invalidate()
            countdownTimerNode.removeFromParent()
            //Add pause button
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.createPauseButton()
            }
        }
        print(countdownTime)
    }
    //Start global game timer
    @objc func startGameTimer() {
        gameTimerLable = childNode(withName: "timerLable") as! SKLabelNode
        time -= 1
        if time >= 0 {
            if gameTimerLable.isHidden {
                gameTimerLable.isHidden = false
            }
            gameTimerLable.text = ("\(time)")
            print("time : \(time)")
        } else {
            gameOver()
        }
    }
    
    func globalGameTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startGameTimer), userInfo: nil, repeats: true)
    }
    
    func cancelTimers() {
        gameTimer.invalidate()
        spawnTimer.invalidate()
        print("timers are canceled")
    }
    
    //Spawn timer for cointry node
    func startSpawnTimer() {
        spawnTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(spawnCountry), userInfo: nil, repeats: true)
    }
    
    // Function to remove all country models from scene when game is over
    private func removeAllCountries() {
        for child in children {
            if child is CountryModel {
                child.removeFromParent()
            }
        }
    }
    
    private func fadeOutWithColor(_ color: SKColor, duration: TimeInterval) -> SKAction {
        let colorOverlay = SKAction.colorize(with: color, colorBlendFactor: 1.0, duration: duration)
        let fadeOut = SKAction.fadeOut(withDuration: duration)
        return SKAction.group([colorOverlay, fadeOut])
    }
    
    //MARK: - Game pause button and func
    private func createPauseButton() {
        pauseButton?.removeFromParent()
        pauseButton = PauseButton(size: CGSize(width: 80, height: 80))
        
        //"if device" needed for correct using phone cose .scale are different
        if device.userInterfaceIdiom == .pad {
            pauseButton?.position = CGPoint(x: size.width - 80, y: size.height - 120 )
        } else {
            pauseButton?.position = CGPoint(x: size.width - 80, y: size.height - 180 )
        }
        pauseButton?.zPosition = 100
        pauseButton?.toggleAction = { [weak self] in
            self?.togglePause()
        }
        addChild(pauseButton!)
    }
    
    private func togglePause() {
        isPause = !isPause
        pauseButton?.toggle()
        
        if isPause {
            pauseGame()
        } else {
            resumeGame()
        }
    }
    
    private func pauseGame() {
        self.isPaused = true
        spawnTimer.invalidate()
        gameTimer.invalidate()
        
        // Сохраняем состояние каждого CountryModel
        pausedCountryStates = children.compactMap { node -> (CountryModel, CGPoint, CGVector)? in
            guard let country = node as? CountryModel else { return nil }
            return (country, country.position, country.physicsBody?.velocity ?? .zero)
        }
        
        // Останавливаем все CountryModel
        children.compactMap { $0 as? CountryModel }.forEach { country in
            country.physicsBody?.velocity = .zero
            country.physicsBody?.angularVelocity = 0
        }
        
        // Создаем затемненный фон на весь экран
        let pauseOverlay = SKShapeNode(rectOf: CGSize(width: self.size.width * 2, height: self.size.height * 2))
        pauseOverlay.fillColor = SKColor.black.withAlphaComponent(0.5)
        pauseOverlay.strokeColor = .clear
        pauseOverlay.zPosition = 90
        pauseOverlay.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        pauseOverlay.name = "pauseOverlay"
        addChild(pauseOverlay)
        
        let pauseLabel = SKLabelNode(fontNamed: "Chalkduster")
        pauseLabel.text = "Pause"
        pauseLabel.fontSize = 48
        pauseLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        pauseLabel.zPosition = 100
        pauseLabel.name = "pauseLabel"
        addChild(pauseLabel)
    }
    
    private func resumeGame() {
        self.isPaused = false
        // Восстанавливаем позиции CountryModel
        for (country, position, _) in pausedCountryStates {
            country.position = position
        }
        // Добавляем небольшую задержку перед восстановлением скорости
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            // Восстанавливаем скорость каждого CountryModel
            for (country, _, velocity) in self.pausedCountryStates {
                country.physicsBody?.velocity = velocity
            }
            // Очищаем сохраненные состояния
            self.pausedCountryStates.removeAll()
        }
        
        startSpawnTimer()
        globalGameTimer()
        
        childNode(withName: "pauseOverlay")?.removeFromParent()
        childNode(withName: "pauseLabel")?.removeFromParent()
    }
}
