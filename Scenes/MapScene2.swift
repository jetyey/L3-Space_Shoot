//
//  MapScene2.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class MapScene2: SKScene{
    
    var world4: SKShapeNode?                    //planet no.4
    var world5: SKShapeNode?                    //planet no.5
    var world6: SKShapeNode?                    //planet no.6
    var dialogbox: SKSpriteNode?                //Sprite that appear when planet is touched (only appear one at a time in the scene)
    var infoButton: SKSpriteNode?               //touchable to display the infoBox (also appears one at a time)
    var playButton: SKSpriteNode?               //Button that calls the GameScene
    var infoBox: SKSpriteNode?                  //Informatin about the planet touched (only appears one at a time)
    var buttonNextMap: SKSpriteNode?            //Button to go to the MapScene2
    var limitter: Int = 0                       //Limits the sprite dialogBox to spawn once in the Scene
    var infoNumber: Int = 0                     //Which information will appear
    var gameSceneNumber = 0                     //Which parameters to run for the gameScene
    let backButton = SKLabelNode(fontNamed:"moonhouse")                  //Return to MenusScene
    let backgroundMusic = SKAudioNode(fileNamed: "MapMusic.mp3")        //Bg music
    var playMusic = SKSpriteNode(imageNamed: "playmusic")               //Play music
    var stopMusic = SKSpriteNode(imageNamed: "stopmusic")               //Mute
    let menuscene: MenuScene = MenuScene()                              //Class MenuScene
    
    
    override func didMove(to view: SKView) {
        
        //Background
        let backTexture = SKTexture(imageNamed: "mapBackground")
        let back = SKSpriteNode(texture: backTexture)
        back.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        back.zPosition = -1
        back.size = CGSize(width: self.frame.width , height: self.frame.height)
        self.addChild(back)
        
        //Back Button
        backButton.text = "Back"
        backButton.fontSize = 20;
        backButton.zPosition = 1
        backButton.position = CGPoint(x:self.frame.width*0.15, y:self.frame.height*0.95);
        self.addChild(backButton)
        
        //Planet 4
        world4 = SKShapeNode(circleOfRadius: 10)
        if Setup.planet4Unlocked{
            world4?.setScale(2)
        }
        world4?.fillColor = UIColor.white
        world4?.strokeColor = UIColor(red: 0.98, green: 0.98, blue: 0.73, alpha: 0.5)
        world4?.glowWidth = 0.3
        world4?.fillTexture = SKTexture(imageNamed: "planet4")
        world4?.position = CGPoint(x: (self.frame.width)*0.8, y: self.frame.height*0.2)
        self.addChild(world4!)
        
        //Planet 5
        world5 = SKShapeNode(circleOfRadius: 10)
        if Setup.planet5Unlocked{
            world5?.setScale(2)
        }
        world5?.fillColor = UIColor.white
        world5?.strokeColor = UIColor(red: 0.98, green: 0.98, blue: 0.73, alpha: 0.5)
        world5?.glowWidth = 0.3
        world5?.fillTexture = SKTexture(imageNamed: "planet5")
        world5?.position = CGPoint(x: (self.frame.width)*0.3, y: self.frame.height*0.5)
        self.addChild(world5!)
        
        //Planet 6
        world6 = SKShapeNode(circleOfRadius: 10)
        if Setup.planet6Unlocked{
            world6?.setScale(2)
        }
        world6?.fillColor = UIColor.white
        world6?.strokeColor = UIColor(red: 0.98, green: 0.98, blue: 0.73, alpha: 0.5)
        world6?.glowWidth = 0.3
        world6?.fillTexture = SKTexture(imageNamed: "planet6")
        world6?.position = CGPoint(x: (self.frame.width)*0.5, y: self.frame.height*0.8)
        self.addChild(world6!)
        
        //Button next map
        buttonNextMap = SKSpriteNode(imageNamed: "arrow")
        buttonNextMap?.size = CGSize(width: 60, height: 40)
        buttonNextMap?.xScale = -1
        buttonNextMap?.position = CGPoint(x: self.frame.width*0.1, y: self.frame.minY+((buttonNextMap?.size.height)!/2))
        buttonNextMap?.zPosition = 3
        self.addChild(buttonNextMap!)
        
        //Music either add on scene play or mute button
        if (UserDefaults().integer(forKey: "music") != 1){
            let musicStopTexture = SKTexture(imageNamed: "stopmusic")
            stopMusic = SKSpriteNode(texture: musicStopTexture)
            stopMusic.position = CGPoint(x: self.frame.width*0.95, y:self.frame.height*0.97)
            stopMusic.zPosition = 100
            stopMusic.size = CGSize(width: 30, height: 30)
            self.addChild(stopMusic)
            
            backgroundMusic.autoplayLooped = true
            addChild(backgroundMusic)
        }
        else {
            let musicTexture = SKTexture(imageNamed: "playmusic")
            playMusic = SKSpriteNode(texture: musicTexture)
            playMusic.position = CGPoint(x: self.frame.width*0.95, y:self.frame.height*0.97)
            playMusic.zPosition = 100
            playMusic.size = CGSize(width: 30, height: 30)
            self.addChild(playMusic)
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        if let touch = touches.first {
            
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            //If planet4 is touched
            if node == world4 && Setup.planet4Unlocked {
                if (view != nil){
                    //Removes all dialogBox or infoBox on scene. Limits it with only the planet touched touched
                    if (limitter > 0){
                        for _ in 1...limitter {
                            dialogbox?.removeFromParent()
                            infoBox?.removeFromParent()
                            limitter -= 1
                        }
                    }
                    dialogbox = worldEdittor(imageNamed: "dialogBox", planetName: "planet4")
                    dialogbox?.position = CGPoint(x: (self.frame.width)*0.5, y: self.frame.height*0.32)
                    if (limitter == 0) {
                        self.addChild(dialogbox!)
                        infoNumber = 1
                        limitter += 1
                    }
                }
            }
            //If planet5 is touched and it is unlocked
            else if node == world5 && Setup.planet5Unlocked {
                if (view != nil){
                    //Removes all dialogBox or infoBox on scene. Limits it with only the planet touched touched
                    if (limitter > 0){
                        for _ in 1...limitter {
                            dialogbox?.removeFromParent()
                            infoBox?.removeFromParent()
                            limitter -= 1
                        }
                    }
                    dialogbox = worldEdittor(imageNamed: "dialogBox", planetName: "planet5")
                    dialogbox?.position = CGPoint(x: (self.frame.width)*0.5, y: self.frame.height*0.62)
                    if (limitter == 0) {
                        self.addChild(dialogbox!)
                        infoNumber = 2
                        limitter += 1
                    }
                }
            }
            //If planet6 is touched and it is unlocked
            else if node == world6 && Setup.planet6Unlocked {
                if (view != nil){
                    //Removes all dialogBox or infoBox on scene. Limits it with only the planet touched touched
                    if (limitter > 0){
                        for _ in 1...limitter {
                            dialogbox?.removeFromParent()
                            infoBox?.removeFromParent()
                            limitter -= 1
                        }
                    }
                    dialogbox = worldEdittor(imageNamed: "dialogBox", planetName: "planet6")
                    dialogbox?.position = CGPoint(x: (self.frame.width)*0.5, y: self.frame.height*0.92)
                    if (limitter == 0) {
                        self.addChild(dialogbox!)
                        infoNumber = 3
                        limitter += 1
                    }
                }
            }
            //When touched more information will be displayed about the planet
            else if node == infoButton {
                if (view != nil){
                    dialogbox?.removeFromParent()
                    infoBoxEdittor()
                }
            }
            //Starts the GameScene
            else if node == playButton {
                let transition = SKTransition.reveal(with: SKTransitionDirection.right, duration: 1.0)
                if gameSceneNumber == 4 {
                    let scene = ShipSelectionScene(size: self.scene!.size)
                    //Setting up the game
                    Setup.score = 40                          // Score objective
                    Setup.image = "background4"               //Background of the planet
                    Setup.lives = 4                           // lives available
                    Setup.spawnBonusDelay = 20                // Delay between each bonus spawn
                    Setup.difficultyLevel = 2                 // Level of difficulty
                    Setup.planetNumber = gameSceneNumber      // assign the planet number you will play
                    Setup.spawnBoss = false                   // if boss will spawn or not
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
                else if gameSceneNumber == 5 {
                    let scene = ShipSelectionScene(size: self.scene!.size)
                    //Setting up the game
                    Setup.score = 40                         // Score objective
                    Setup.image = "background5"              //Background of the planet
                    Setup.lives = 4                          // Lives available
                    Setup.spawnBonusDelay = 20               // Delay between each bonus spawn
                    Setup.difficultyLevel = 2                // Level of difficulty
                    Setup.planetNumber = gameSceneNumber     // Assign the planet number you will play
                    Setup.spawnBoss = false                  // if boss will spawn or not
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
                else if gameSceneNumber == 6 {
                    let scene = ShipSelectionScene(size: self.scene!.size)
                    //Setting up the game
                    Setup.score = 50                        // Score objective
                    Setup.image = "background6"             //Background of the planet
                    Setup.lives = 4                         // Lives available
                    Setup.spawnBonusDelay = 30              // Delay between each bonus spawn
                    Setup.difficultyLevel = 3               // Level of difficulty
                    Setup.planetNumber = gameSceneNumber    // Assign the planet number you will play
                    Setup.spawnBoss = true                  // if boss will spawn or not
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == stopMusic {
                if view != nil {
                    stopMusic.removeFromParent()
                    let musicTexture = SKTexture(imageNamed: "playmusic")
                    playMusic  = SKSpriteNode(texture: musicTexture)
                    playMusic.position = CGPoint(x: self.frame.width*0.94, y:self.frame.height*0.95)
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
                    stopMusic.position = CGPoint(x: self.frame.width*0.94, y:self.frame.height*0.95)
                    stopMusic.zPosition = 100
                    stopMusic.size = CGSize(width: 30, height: 30)
                    self.addChild(stopMusic)
                    addChild(backgroundMusic)
                    
                    UserDefaults.standard.set(0, forKey: "music")
                }
            }
            else if node == backButton {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5)
                    let scene = MenuScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            //Transitions to the previous map
            else if node == buttonNextMap {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                    let scene = MapScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else {
                dialogbox?.removeFromParent()
                infoBox?.removeFromParent()
                infoNumber = 0
                gameSceneNumber = 0
            }
        }
    }
    
    
    /*
     worldEdittor
     input: imageNamed: The image of the dialogBox to be displayed
     planetName: The sprite name of the planet to be displayed
     func: Creates the dialog box when the planet is touched
     */
    func worldEdittor(imageNamed: String, planetName: String) -> SKSpriteNode{
        
        //Dialog Box
        dialogbox = SKSpriteNode(imageNamed: imageNamed)
        dialogbox?.zPosition = 2
        let dialogBoxEffect1 = SKAction.colorize(with: UIColor.green, colorBlendFactor: 0.6 , duration: 1)
        let dialogBoxEffect2 = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1 , duration: 1)
        let foreverDialogBoxEffect = SKAction.repeatForever(SKAction.sequence([dialogBoxEffect1, dialogBoxEffect2]))
        dialogbox?.run(foreverDialogBoxEffect)
        
        //Planet Image
        let planet = SKSpriteNode(imageNamed: planetName)
        planet.zPosition = 2
        planet.position.x = 75
        dialogbox?.addChild(planet)
        
        //Information Button
        infoButton = SKSpriteNode(imageNamed: "moreInfo")
        infoButton?.zPosition = 2
        infoButton?.position.x = -50
        infoButton?.size = CGSize(width: 90, height: 75)
        infoButton?.alpha = 0.5
        
        //Make it glow
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 1)
        let forever = SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn]))
        infoButton?.run(forever)
        dialogbox?.addChild(infoButton!)
        
        return(dialogbox)!
        
    }
    
    /*
     infoBoxEdittor
     Func: Creates the information box when the dialogbox is touched to display information about the planet
     */
    func infoBoxEdittor() {
        
        //Information Box
        infoBox = SKSpriteNode(imageNamed: "infoBox")
        infoBox?.size = CGSize(width: self.frame.width, height: self.frame.height/2)
        infoBox?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        infoBox?.zPosition = 3
        
        //Picture
        var planet: SKSpriteNode?
        
        //Information
        let labelSprite: SKSpriteNode = SKSpriteNode(imageNamed: "Planet1Label")
        infoBox?.addChild(labelSprite)
        labelSprite.position = CGPoint(x: 0, y: 0)
        labelSprite.zPosition = 4
        
        if infoNumber == 1 {
            labelSprite.texture = SKTexture(imageNamed: "Planet4Label")
            planet = SKSpriteNode(imageNamed: "planet4")
            gameSceneNumber = 4
        }
        else if infoNumber == 2 {
            labelSprite.texture = SKTexture(imageNamed: "Planet5Label")
            planet = SKSpriteNode(imageNamed: "planet5")
            gameSceneNumber = 5
        }
        else if infoNumber == 3 {
            labelSprite.texture = SKTexture(imageNamed: "Planet6Label")
            planet = SKSpriteNode(imageNamed: "planet6")
            gameSceneNumber = 6
        }
        planet?.position = CGPoint(x: -2.5, y: ((infoBox?.size.height)!/2)-35)
        planet?.zPosition = 4
        infoBox?.addChild(planet!)
        
        //PlayButton
        playButton = SKSpriteNode(imageNamed: "playButton")
        playButton?.zPosition = 4
        playButton?.position.y = -90
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 1)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.5)
        let forever = SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn]))
        playButton?.run(forever)
        infoBox?.addChild(playButton!)
        
        self.addChild(infoBox!)
    }
}
