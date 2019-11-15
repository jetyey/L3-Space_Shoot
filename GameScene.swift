//
//  GameScene.swift
// Copyright © 2018 L3AA2. All rights reserved.

import SpriteKit
import CoreMotion
import AudioToolbox

//HitHandlers
typealias EnemyHitHandler = ((SKNode, SKNode, Int) -> Void)
typealias PlayerHitHandler = ((SKNode, SKNode) -> Void)
typealias BonusHitHandler = ((SKNode, SKNode) -> Void)

//Bitmaskes for collisions
let laserShotBitMask:UInt32 = 0x01
let enemyBitMask:UInt32 = 0x02
let playerBitMask:UInt32 = 0x04
let enemyShotBitMask:UInt32 = 0x08
let bonusBitMask:UInt32 = 0x16

class GameScene: SKScene{
    
    //Classes
    var spaceShip: PlayerShip!
    var hud: Hud?
    var enemySpawner : EnemySpawner?
    var collisionDetector : CollisionDetector?
    var artillery: Artillery?
    var bonusSpawner:BonusSpawner?
    var boss: Boss?
    var bg1: Background?
    var bg2: Background?
    var setup: Setup!
    var gameArea: CGRect?
    
    //Sprites
    var pauseButton = SKSpriteNode(imageNamed: "pauseButton")           //Pause button
    var button1 = SKSpriteNode(imageNamed: "boutonmenu")                //Sprite that will carry the PLAY label when pause is pressed
    var button2 = SKSpriteNode(imageNamed: "boutonmenu")                //Sprite that will carry the QUIT label when pause is pressed
    var button3 = SKSpriteNode(imageNamed: "boutonmenu")                //Sprite that will carry the RESTART label when pause is pressed
    var backstart = SKSpriteNode(imageNamed: "backstart")               //Background of the buttons when pause is pressed
    var play = SKLabelNode(fontNamed:"moonhouse")                       //PLAY label when pause is pressed
    var quit = SKLabelNode(fontNamed:"moonhouse")                       //QUIT label when pause is pressed
    var restart = SKLabelNode(fontNamed:"moonhouse")                    //RESTART label when pause is pressed
    let backgroundMusic = SKAudioNode(fileNamed: "MusicGameScene.mp3")  //Bg music
    var playMusic = SKSpriteNode(imageNamed: "playmusic")               //Sprite to play music
    var stopMusic = SKSpriteNode(imageNamed: "stopmusic")               //Sprite to mute music
    
    //Variables
    var bossFight: Bool = false                                     //Determines if the ship is currently in a boss fight or not
    var timeBetweenSpawnBonus = 600                                 //Interval between bonus spawns
    var countBonus = 0                                              //Interval between bonus spawns
    var butnum: Int = 0                                             //Button number (1,2 or 3) of artillery
    var numBoss = 0                                                 //Number of boss parts destroyed
    var waitCounter = 0                                             //Limits the spawn of enemies on screen
    var timeBetweenSpawns = 200                                     //Interval between enemy spawns
    var count = 0                                                   //Interval between enemy spawns
    
    override init(size: CGSize){
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        Setup.gameState = true                                     //initalise gamestate to true (scene is not paused)

        super.init(size: size)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func didMove(to view: SKView) {
       
        setup = Setup(scene: self)                                 //Class Setup

        //Moving background setup
        bg1 = setup.setupbackground()                              // set up the first background
        bg2 = setup.setupbackground()                              // set up the second background
        bg2?.position.y = self.frame.maxY + self.frame.midY        //Places the second background right on top of the first background so that when they both scroll there is no gap between the two
        
        setup.setupHud()                                           //HUD setup
        setup.setupPauseButton()                                   //Pause button setup
        spaceShip = setup.setupShip()                              //Player ship setup
        setupPhysicsWorld()                                        //PhysicsWorld setup
        
        artillery = Artillery(parentNode: self)
        enemySpawner = EnemySpawner(parent: self)
        bonusSpawner = BonusSpawner(parent: self)
        
        //Either stops or plays the sound effects and bg music
        if (UserDefaults().integer(forKey: "music") != 1){
            
            let musicStopTexture = SKTexture(imageNamed: "stopmusic")
            stopMusic  = SKSpriteNode(texture: musicStopTexture)
            stopMusic.position = CGPoint(x: self.frame.width*0.85, y:self.frame.height*0.97)
            stopMusic.zPosition = 100
            stopMusic.size = CGSize(width: 30, height: 30)
            self.addChild(stopMusic)
            
            backgroundMusic.autoplayLooped = true
            addChild(backgroundMusic)
        }
        else {
            let musicTexture = SKTexture(imageNamed: "playmusic")
            playMusic  = SKSpriteNode(texture: musicTexture)
            playMusic.position = CGPoint(x: self.frame.width*0.85, y:self.frame.height*0.97)
            playMusic.zPosition = 100
            playMusic.size = CGSize(width: 30, height: 30)
            self.addChild(playMusic)
        }
        
    }
    
    //Called when a touch begins
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if let touch = touches.first{
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            if node == pauseButton {
                if view != nil {
                    pauseButton.removeFromParent()
                    let backstartTexture = SKTexture(imageNamed: "backgroundStart")
                    backstart = SKSpriteNode(texture: backstartTexture)
                    backstart.position = CGPoint(x: self.frame.width*0.52, y:self.frame.height*0.5)
                    backstart.zPosition = 132
                    backstart.size = CGSize(width: 240, height: 280)
                    self.addChild(backstart)
                    
                    let button1Texture = SKTexture(imageNamed: "boutonmenu1")
                    button1 = SKSpriteNode(texture: button1Texture)
                    button1.position = CGPoint(x: 0, y: 80)
                    button1.zPosition = 133
                    button1.size = CGSize(width: 150, height: 70)
                    backstart.addChild(button1)
                    
                    play.text = "PLAY"
                    play.fontSize = 30
                    play.zPosition = 134
                    play.fontColor = SKColor.black
                    play.position = CGPoint(x: 0, y: -7)
                    button1.addChild(play)
                    
                    let button2Texture = SKTexture(imageNamed: "boutonmenu1")
                    button2 = SKSpriteNode(texture: button2Texture)
                    button2.position = CGPoint(x: 0, y: -80)
                    button2.zPosition = 133
                    button2.size = CGSize(width: 150, height: 70)
                    backstart.addChild(button2)
                    
                    quit.text = "QUIT"
                    quit.fontSize = 30
                    quit.zPosition = 134
                    quit.fontColor = SKColor.black
                    quit.position = CGPoint(x: 0, y: -7)
                    button2.addChild(quit)
                    
                    let button3Texture = SKTexture(imageNamed: "boutonmenu1")
                    button3 = SKSpriteNode(texture: button3Texture)
                    button3.zPosition = 133
                    button3.size = CGSize(width: 150, height: 70)
                    backstart.addChild(button3)
                    
                    restart.text = "RESTART"
                    restart.fontSize = 23
                    restart.zPosition = 134
                    restart.fontColor = SKColor.black
                    restart.position = CGPoint(x: 0, y: -7)
                    button3.addChild(restart)
                    
                    Setup.gameState = false
                    self.isPaused = true
                }
            }
            else if node == button1 || node == play{
                if view != nil {
                    self.addChild(pauseButton)
                    button2.removeFromParent()
                    button1.removeFromParent()
                    play.removeFromParent()
                    quit.removeFromParent()
                    backstart.removeFromParent()
                    Setup.gameState = true
                    self.isPaused = false
                }
            }
            else if node == button2 || node == quit{
                let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5)
                let scene = MenuScene(size: self.scene!.size)
                scene.scaleMode = SKSceneScaleMode.aspectFit
                scene.backgroundColor = UIColor.black
                self.scene?.view?.presentScene(scene, transition: transition)
            }
            else if node == stopMusic {
                if view != nil {
                    stopMusic.removeFromParent()
                    let musicTexture = SKTexture(imageNamed: "playmusic")
                    playMusic  = SKSpriteNode(texture: musicTexture)
                    playMusic.position = CGPoint(x: self.frame.width*0.85, y:self.frame.height*0.97)
                    playMusic.zPosition = 100
                    playMusic.size = CGSize(width: 30, height: 30)
                    self.addChild(playMusic)
                    backgroundMusic.removeFromParent()
                    
                    UserDefaults.standard.set(1, forKey: "music")
                }
            }
            else if node == playMusic {
                if view != nil {
                    playMusic.removeFromParent()
                    let musicStopTexture = SKTexture(imageNamed: "stopmusic")
                    stopMusic  = SKSpriteNode(texture: musicStopTexture)
                    stopMusic.position = CGPoint(x: self.frame.width*0.85, y:self.frame.height*0.97)
                    stopMusic.zPosition = 100
                    stopMusic.size = CGSize(width: 30, height: 30)
                    self.addChild(stopMusic)
                    addChild(backgroundMusic)
                    
                    UserDefaults.standard.set(0, forKey: "music")
                }
            }
            else if node == button3 || node == restart {
                let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5)
                let scene = GameScene(size: self.scene!.size)
                scene.scaleMode = SKSceneScaleMode.aspectFit
                scene.backgroundColor = UIColor.black
                self.scene?.view?.presentScene(scene, transition: transition)
            }
            else if (node == artillery?.button1 || node == artillery?.button2 || node == artillery?.button3) {
                if (view != nil && Setup.gameState == true) {
                    
                    if (node == artillery?.button1){
                        artillery?.useButton(butnum: 1, spaceShip: spaceShip!)
                    }
                    else if (node == artillery?.button2){
                        artillery?.useButton(butnum: 2, spaceShip: spaceShip!)
                    }
                    else if (node == artillery?.button3){
                        artillery?.useButton(butnum: 3, spaceShip: spaceShip!)
                    }
                }
            }
            else if node == artillery?.xButtton {
                if view != nil {
                    artillery?.removeInfoBoxBonus()
                    Setup.gameState = true
                    self.isPaused = false
                }
            }
            else {
                if (UserDefaults().integer(forKey: "music") != 1){
                    run(SKAction.playSoundFileNamed("LaserEffect.mp3", waitForCompletion: false))
                }
                spaceShip?.firePressed = true
            }
        }
    }
    

    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        bg1?.scrollBackground(speed: 2.0)   // makes the first background scrolls, the speed must be a number that can be devided by 2
        bg2?.scrollBackground(speed: 2.0)   // makes the second background scrolls, the speed must be a number that can be devided by 2
        // this simulates a scrolling background, two nodes of the same image scrolls at the same speed, one of the node is right on top of the other one
        
        spaceShip?.updateAction()
        
        if !bossFight {                     //if there is no boss on the screen the game spawns a new wave of enemies
            spawnNewEnemy()
        }
        spawnNewBonus()
        
        if (waitCounter > 100)             //removes enemies outside the screen so that the game isn't overloaded with sprites
        {
            enemySpawner?.removeEnemiesOutsideScreen()
            waitCounter = 0
        }
        waitCounter += 1
    }
    
    /*
     setupPhysicsWorld
     func: Setups the parameters "Physics world" in the scene
    */
    func setupPhysicsWorld() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.name = "edge"
        collisionDetector = CollisionDetector(g: enemyHit, e: playerHit, b: playerGetBonus)
        self.physicsWorld.contactDelegate = collisionDetector
    }


    /*
     enemyHit
     input: enemyNode: Node containing the enemy hit
            laserNode: Node containing the laser that hit the enemy
            score: Variable containing the score of the enemy hit
     func: Called when CollisionDetector detects collision between enemy node and a laser node.
           Also calls Boss if conditions are met.
    */
    func enemyHit(_ enemyNode:SKNode,laserNode:SKNode, score: Int) {
        
        hud?.updateScoreLabel(point: score)
        
        let expl:Explosion = Explosion()
        if laserNode.name == "laser" {
            let explosion = SKAction.run {
                expl.spawnExplosion(parent: self, spawnPosition: enemyNode.position)
            }
            let seq = SKAction.sequence([SKAction.wait(forDuration: 0.1), SKAction.removeFromParent(), explosion])
            enemyNode.run(seq)
        }
        else{
            expl.spawnExplosion(parent: self, spawnPosition: enemyNode.position)
            enemyNode.removeFromParent()
            laserNode.removeFromParent()
        }
        
        //Counts how many parts of the boss is destroyed and if ==3, the main boss body can be destroyed
        if enemyNode.name == "boss" {
            numBoss += 1
            if numBoss == 3 {
                enemySpawner?.boss?.physicsBody?.categoryBitMask = enemyBitMask
                enemySpawner?.boss?.physicsBody?.collisionBitMask = 0
                enemySpawner?.boss?.physicsBody?.contactTestBitMask = laserShotBitMask
            }
        }
        
        //Condition to call a boss on scene
        if ( (hud?.score)! >= Setup.score! && !bossFight) {
            Setup.callBoss = true
            setup.callBossToScene()
            bossFight = true
        }
        
        //Condition to end game if planet has a boss
        if numBoss == 4 && bossFight{
            let destroyed = SKAction.run{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let randomPos = CGPoint(x: Int(arc4random_uniform(UInt32(enemyNode.frame.maxX))), y: Int(arc4random_uniform(UInt32(enemyNode.frame.maxY))))
                    expl.spawnExplosion(parent: self, spawnPosition: randomPos)
                }
            }
           /* let explosion = SKAction.run {
                expl.spawnExplosion(parent: self, spawnPosition: enemyNode.position)
            }*/
            let end = SKAction.run {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.endGameWin()
                }
            }
            run(SKAction.sequence([destroyed, destroyed, destroyed, destroyed, destroyed, end]))
        }
        
        //Condition to end game if planet does not have a boss
        if ((hud?.score)! >= Setup.score! && !Setup.spawnBoss!) {
            let explosion = SKAction.run {
                expl.spawnExplosion(parent: self, spawnPosition: enemyNode.position)
            }
            let end = SKAction.run {
                self.endGameWin()
            }
            run(SKAction.sequence([explosion, end]))
            
        }
    
    }
    
    /*
     playerHit
     input: player: the player node. The 1st argument of PlayerHitHandler
            hitObject: the object node. The 2nd argument of PlayerHitHandler
     func: Called when player or its projectile is in collision with an enemy or its projectile
    */
    func playerHit(_ player:SKNode, hitObject:SKNode) {
        
        hud?.updateLivesLabel()                         //(-1) to player's life
        hitObject.physicsBody?.isDynamic = false
        hitObject.physicsBody?.categoryBitMask = 0
        hitObject.removeFromParent()
        spaceShip?.invincibility()
        
        // Animate a hit on the player ship
        let expl:Explosion = Explosion()
        expl.spawnExplosion(parent: self, spawnPosition: (self.spaceShip?.getCurrentPosition())!)
        
        //Condition to call GameOverScene
        if ((hud?.lives)! < 1) {
            let explosion = SKAction.run {
                expl.spawnExplosion(parent: self, spawnPosition: (self.spaceShip?.getCurrentPosition())!)
            }
            let end = SKAction.run {
                self.endGame()
            }
            run(SKAction.sequence([explosion, end]))
        }
    }
    
    /*
     playerGetBonus
     input: player: the player node. The 1st argument of BonusHitHandler
            hitObject: the bonus node. The 2nd argument of BonusHitHandler
     func: Called when player is in collision with a bonus
     */
    func playerGetBonus(_ player:SKNode, hitObject:SKNode) {
        if(hitObject.name == "health"){
            artillery?.displayInfo(bonusName: hitObject.name!)          //InfoBox for health is displayed once
            hud?.updateLivesBonusLabel()                                //Updates life (+1)
        }
        else if( hitObject.name == "laserBonus" || hitObject.name == "shotgunBonus"){
            butnum += 1
            if (butnum == 4){
                butnum = 1                                             //When artillery is full of bonuses, it replaces the first "button" of artillery
                artillery?.updateButton(butnum: butnum, name: hitObject.name!)      //Updates the artillery when a bonus collides with the player
            }
            artillery?.displayInfo(bonusName: hitObject.name!)                      //InfoBox of the bonus. Displayed once
            artillery?.updateButton(butnum: butnum, name: hitObject.name!)          //Updates the artillery when a bonus collides with the player
        }
    }
    
    /*
     endGameWin
     func: Called when the player completes a mission.
    */
    func endGameWin(){
        
        let transition = SKTransition.reveal(with: SKTransitionDirection.up, duration: 2.0)
        
        let scene = WinScene(size: self.scene!.size)
        scene.score = (hud?.score)!
        scene.scaleMode = SKSceneScaleMode.aspectFit
        scene.backgroundColor = UIColor.black
        
        if(Setup.planetNumber == 1){
            Setup.planet2Unlocked = true                                            //Unlocks planet 2
            setup.planet2State = Setup.planet2Unlocked                              //set the state to unlocked
            UserDefaults.standard.set(setup.planet2State, forKey: "planet2State")   //Saves the variablue as true(planet unlocked)
        }else if (Setup.planetNumber == 2){
            Setup.planet3Unlocked = true                                            //Unlocks planet 3
            setup.planet3State = Setup.planet3Unlocked                              //set the state to unlocked
            UserDefaults.standard.set(setup.planet3State, forKey: "planet3State")   //Saves the variablue as true(planet unlocked)
        }else if (Setup.planetNumber == 3){
            Setup.planet4Unlocked = true                                            //Unlocks planet 4
            setup.planet4State = Setup.planet4Unlocked                              //set the state to unlocked
            UserDefaults.standard.set(setup.planet4State, forKey: "planet4State")   //Saves the variablue as true(planet unlocked)
        }else if (Setup.planetNumber == 4){
            Setup.planet5Unlocked = true                                            //Unlocks planet 5
            setup.planet5State = Setup.planet5Unlocked                              //set the state to unlocked
            UserDefaults.standard.set(setup.planet5State, forKey: "planet5State")   //Saves the variablue as true(planet unlocked)
        }else if (Setup.planetNumber == 5){
            Setup.planet6Unlocked = true                                            //Unlocks planet 6
            setup.planet6State = Setup.planet6Unlocked                              //set the state to unlocked
            UserDefaults.standard.set(setup.planet6State, forKey: "planet6State")   //Saves the variablue as true(planet unlocked)
        }
        
        self.scene?.view?.presentScene(scene, transition: transition)               //Transition to WinScene
        
    }
    
    /*
     endGame
     func: Called when player looses(Life = 0)
    */
    func endGame() {
        let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1)
        
        let scene = GameOverScene(size: self.scene!.size)
        scene.score = (hud?.score)!
        scene.scaleMode = SKSceneScaleMode.aspectFit
        scene.backgroundColor = UIColor.black
        
        self.scene?.view?.presentScene(scene, transition: transition)
    }

    /*
     spawnNewEnemy
     func: Spawns an enemy when called.
    */
    func spawnNewEnemy() {
        if (count > timeBetweenSpawns){
            enemySpawner?.spawnWave(playerPos: (spaceShip?.getCurrentPosition())!, playerScore:(hud?.score)!)
            count = 0
            if (timeBetweenSpawns > 50) {
                timeBetweenSpawns -= setup.difficultySpeed()
            }
        }
        count += 1
    }
    
    /*
     spawnNewBonus
     Func: Spawns bonuses with a certain condition (interval in secs). Uses countBonus as a varable that increments 1 to count the time and limit the spawns with the timeBetweenSpawnBonus variable
    */
    func spawnNewBonus() {
        if ((countBonus > timeBetweenSpawnBonus) && ((countBonus/100) % Setup.spawnBonusDelay! == 0)) {
            bonusSpawner?.spawnNewBonus((self.spaceShip?.getCurrentPosition())!)
            countBonus = 0
        }
        countBonus += 1
    }
    
    
    //PlayerShip movements
    override func touchesMoved( _ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            if (Setup.gameState == true){
                let pointOfTouch = touch.location(in: self)
                let previousPointOfTouch = touch.previousLocation(in: self)
            
                let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
                spaceShip?.changePosition(pos: amountDragged)
        
                if (spaceShip?.shipSprite.position.x)! >= (gameArea?.maxX)! - (spaceShip?.shipSprite.size.width)!/2{
                    spaceShip?.shipSprite.position.x = (gameArea?.maxX)! - (spaceShip?.shipSprite.size.width)!/2
                }
                if (spaceShip?.shipSprite.position.x)! <= (gameArea?.minX)! + (spaceShip?.shipSprite.size.width)!/2{
                    spaceShip?.shipSprite.position.x = (gameArea?.minX)! + (spaceShip?.shipSprite.size.width)!/2
                }
            }
        }
    }
    
}
