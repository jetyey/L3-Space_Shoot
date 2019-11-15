//
// GameOverScene.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class GameOverScene : SKScene {
    
    let scoreLabel = SKLabelNode(fontNamed:"moonhouse")                                 //Score obtained
    let replay = SKLabelNode(fontNamed:"moonhouse")                                     //Restart label
    let quit = SKLabelNode(fontNamed:"moonhouse")                                       //Quit label
    let highscoreLabel1 = SKLabelNode(fontNamed: "moonhouse")                           //Displays the current highest stored score in arcade
    
    var back = SKSpriteNode(imageNamed: "background")                                   //Scene's background
    var gameover = SKSpriteNode(imageNamed: "gameover")                                 //GameOver message
    var button1 = SKSpriteNode(imageNamed: "button")                                    //Sprite that will contain replay node
    var button2 = SKSpriteNode(imageNamed: "button")                                    //Sprite that will contain quit node
    var playMusic = SKSpriteNode(imageNamed: "playmusic")                               //node to play music
    var stopMusic = SKSpriteNode(imageNamed: "stopmusic")                               //Node to stop the music
    var rect: SKShapeNode?                                                              //rectangle box for the highscoreLabel1
    var score = 0
    
    var highscore1 = UserDefaults.standard.integer(forKey: "1st")                       //Storage for the highest score in arcade
    var highscore2 = UserDefaults.standard.integer(forKey: "2nd")                       //Storage for the 2nd highest score in arcade
    var highscore3 = UserDefaults.standard.integer(forKey: "3rd")                       //Storage for the 3rd highest score in arcade
    var difficultyLevel1 = UserDefaults.standard.object(forKey: "arcadeDifficulty1")    //Storage for difficulty level
    var difficultyLevel2 = UserDefaults.standard.object(forKey: "arcadeDifficulty2")    //Storage for difficulty level
    var difficultyLevel3 = UserDefaults.standard.object(forKey: "arcadeDifficulty3")    //Storage for difficulty level

    let backgroundMusic = SKAudioNode(fileNamed: "GameOverMusic.mp3")                   //Bg music
    
    
    override func didMove(to view: SKView) {
        
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 2)
        let forever = SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn]))
        
        let backTexture = SKTexture(imageNamed: "gameOverScreen")
        back = SKSpriteNode(texture: backTexture)
        back.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        back.zPosition = -1
        back.size = CGSize(width: 350, height: 600)
        self.addChild(back)
        
        let gameoverTexture = SKTexture(imageNamed: "GameOver")
        gameover = SKSpriteNode(texture: gameoverTexture)
        gameover.position = CGPoint(x: self.frame.width*0.5, y:self.frame.height*0.83)
        gameover.zPosition = 1
        gameover.size = CGSize(width: 270, height: 130)
        self.addChild(gameover)
        
        scoreLabel.text = "Your score : \(score)"
        scoreLabel.fontSize = 29;
        scoreLabel.zPosition = 2
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.35)
        self.addChild(scoreLabel)
        
        let button1Texture = SKTexture(imageNamed: "boutonmenu1")
        button1 = SKSpriteNode(texture: button1Texture)
        button1.position = CGPoint(x: self.frame.width*0.25, y:self.frame.height*0.15)
        button1.zPosition = 1
        button1.size = CGSize(width: 150, height: 80)
        self.addChild(button1)
        
        replay.text = "RESTART"
        replay.fontSize = 23
        replay.zPosition = 2
        replay.fontColor = SKColor.black
        replay.position = CGPoint(x:self.frame.width*0.25, y:self.frame.height*0.14);
        replay.run(forever)
        self.addChild(replay)
        
        let button2Texture = SKTexture(imageNamed: "boutonmenu1")
        button2 = SKSpriteNode(texture: button2Texture)
        button2.position = CGPoint(x: self.frame.width*0.75, y:self.frame.height*0.15)
        button2.zPosition = 1
        button2.size = CGSize(width: 150, height: 80)
        self.addChild(button2)
        
        quit.text = "QUIT"
        quit.fontSize = 30;
        quit.zPosition = 2
        quit.fontColor = SKColor.black
        quit.run(forever)
        quit.position = CGPoint(x:self.frame.width*0.75, y:self.frame.height*0.14);
        self.addChild(quit)
        
        if score > UserDefaults().integer(forKey: "1st"){
            highscore3 = highscore2
            UserDefaults.standard.set(highscore3, forKey: "3rd")                                //Stores the highscore
            if highscore3 != 0 {
                difficultyLevel3 = difficultyLevel2                                             //Change the difficulty of 2nd place to 3rd place
                UserDefaults.standard.set(difficultyLevel3, forKey: "arcadeDifficulty3")        //Change the stored difficulty of highscore3
            }
            highscore2 = highscore1
            UserDefaults.standard.set(highscore2, forKey: "2nd")                                //Stores the highscore
            if highscore2 != 0 {
                difficultyLevel2 = difficultyLevel1                                             //Change the difficulty of 1st place to 2nd place
                UserDefaults.standard.set(difficultyLevel2, forKey: "arcadeDifficulty2")        //Change the stored difficulty of highscore2
            }
            highscore1 = score
            UserDefaults.standard.set(highscore1, forKey: "1st")                                //Stores the highscore
            highscoreLabel1.text = "HighScore : \(UserDefaults().integer(forKey: "1st"))"
            difficultyLevel1 = Setup.arcadeDifficuty as Any
            UserDefaults.standard.set(difficultyLevel1, forKey: "arcadeDifficulty1")            //Change the stored difficulty of highscore1
        }
            
        else if score > UserDefaults().integer(forKey: "2nd"){
            highscore3 = highscore2
            UserDefaults.standard.set(highscore3, forKey: "3rd")                                //Stores the highscore
            if highscore3 != 0 {
                difficultyLevel3 = difficultyLevel2                                             //Change the difficulty of 2nd place to 3rd place
                UserDefaults.standard.set(difficultyLevel3, forKey: "arcadeDifficulty3")        //Change the stored difficulty of highscore3
            }
            highscore2 = score
            UserDefaults.standard.set(score, forKey: "2nd")                                     //Stores the highscore
            highscoreLabel1.text = "HighScore : \(UserDefaults().integer(forKey: "2nd"))"
            difficultyLevel2 = Setup.arcadeDifficuty as Any
            UserDefaults.standard.set(difficultyLevel2, forKey: "arcadeDifficulty2")            //Change the stored difficulty of highscore2
        }
            
        else if score > UserDefaults().integer(forKey: "3rd") {
            highscore3 = score
            UserDefaults.standard.set(score, forKey: "3rd")                                 //Stores the highscore
            highscoreLabel1.text = "HighScore : \(UserDefaults().integer(forKey: "3rd"))"
            difficultyLevel3 = Setup.arcadeDifficuty as Any
            UserDefaults.standard.set(difficultyLevel3, forKey: "arcadeDifficulty3")        //Change the stored difficulty of highscore2
            
        }
        
        //Rectangle to contain highscoreLabel
        rect = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.95, height: 80))
        rect?.fillColor = UIColor(red: 0.73, green: 0.67, blue: 0.23, alpha: 0.2)
        rect?.position = CGPoint(x: self.frame.midX, y: self.frame.height*0.61)
        rect?.strokeColor = UIColor(red: 0.98, green: 0.98, blue: 0.73, alpha: 1)
        rect?.glowWidth = 0.8
        rect?.zPosition = 2
        addChild(rect!)
        
        //Setup highest score to be displayed
        highscoreLabel1.text = "High Score : \(highscore1)"
        highscoreLabel1.fontSize = 30
        highscoreLabel1.fontColor = SKColor.white
        highscoreLabel1.position = CGPoint(x: self.frame.midX, y: self.frame.height*0.60)
        highscoreLabel1.zPosition = 1
        let dialogBoxEffect1 = SKAction.colorize(with: UIColor.green, colorBlendFactor: 0.6 , duration: 0.5)
        let dialogBoxEffect2 = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1 , duration: 0.5)
        let foreverDialogBoxEffect = SKAction.repeatForever(SKAction.sequence([dialogBoxEffect1, dialogBoxEffect2]))
        highscoreLabel1.run(foreverDialogBoxEffect)
        addChild(highscoreLabel1)
        
        //If there was a music on the previous scene then there is a music
        if (UserDefaults().integer(forKey: "music") != 1){
            
            let musicStopTexture = SKTexture(imageNamed: "stopmusic")
            stopMusic  = SKSpriteNode(texture: musicStopTexture)
            stopMusic.position = CGPoint(x: self.frame.width*0.94, y:self.frame.height*0.95)
            stopMusic.zPosition = 100
            stopMusic.size = CGSize(width: 30, height: 30)
            self.addChild(stopMusic)
            
            backgroundMusic.autoplayLooped = true
            addChild(backgroundMusic)
        }
        // If there wasn't a music on the previous scene then there isn't a music
        else {
            let musicTexture = SKTexture(imageNamed: "playmusic")
            playMusic  = SKSpriteNode(texture: musicTexture)
            playMusic.position = CGPoint(x: self.frame.width*0.94, y:self.frame.height*0.95)
            playMusic.zPosition = 100
            playMusic.size = CGSize(width: 30, height: 30)
            self.addChild(playMusic)
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            // Replay the game when you tuch replay label
            if node == replay || node == button1 {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
                    let scene = ShipSelectionScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            // Quit the game when you tuch quit label
            else if node == quit || node == button2{
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
                    let scene = MenuScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            // When you touch highscoreLabel1, transition to HighscoreScene
            else if node == highscoreLabel1 || node == rect {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
                    let scene = HighScoreScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            // The music stops
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
            // The music plays
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
        }
    }
}
