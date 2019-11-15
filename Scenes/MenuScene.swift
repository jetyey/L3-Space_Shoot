//
//  MenuScene.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    var playbutton = SKSpriteNode(imageNamed: "play")
    var settingbutton = SKSpriteNode(imageNamed: "setting")
    var highScoreButton = SKSpriteNode(imageNamed: "highscore")
    var back = SKSpriteNode(imageNamed: "Menu1")
    var playMusic = SKSpriteNode(imageNamed: "playmusic")
    var stopMusic = SKSpriteNode(imageNamed: "stopmusic")
    var button1 = SKSpriteNode(imageNamed: "boutonmenu")
    var button2 = SKSpriteNode(imageNamed: "boutonmenu")
    var button3 = SKSpriteNode(imageNamed: "boutonmenu")
    var redline = SKSpriteNode(imageNamed: "redline")
    var redline2 = SKSpriteNode(imageNamed: "redline")
    
    let title1 = SKLabelNode(fontNamed:"moonhouse")
    let title2 = SKLabelNode(fontNamed:"moonhouse")
    var play = SKLabelNode(fontNamed:"moonhouse")
    var setting = SKLabelNode(fontNamed:"moonhouse")
    var highscore = SKLabelNode(fontNamed:"moonhouse")
    var arcade = SKLabelNode(fontNamed: "moonhouse")
    var textureArray = [SKTexture]()
    
    let backgroundMusic = SKAudioNode(fileNamed: "MusicMenu.mp3")
    var music = UserDefaults.standard.integer(forKey: "music")
    
    
    override func didMove(to view: SKView) {
        
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 2)
        let forever = SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn]))
        
        //Parameters and display of the background
        for index in 1 ... 9 {
            let textureName = "Menu\(index)"
            let texture = SKTexture(imageNamed: textureName)
            textureArray.append(texture)
        }
        let animate = SKAction.animate(with: textureArray, timePerFrame: 0.1)
        let runForeverBackground = SKAction.repeatForever(animate)
        back.run(runForeverBackground)
        back.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        back.zPosition = 0
        back.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.addChild(back)
        
        //Parameters and display of the title label
        title1.text = "SPACE"
        title1.fontSize = 55
        title1.zPosition = 100
        title1.fontColor = SKColor.red
        title1.position = CGPoint(x:self.frame.width*0.35, y:self.frame.height*0.82);
        self.addChild(title1)
        
        title2.text = "SHOOT"
        title2.fontSize = 55
        title2.zPosition = 100
        title2.fontColor = SKColor.red
        title2.position = CGPoint(x:self.frame.width*0.6, y:self.frame.height*0.72);
        self.addChild(title2)
        
        let redlineTexture = SKTexture(imageNamed: "redLine")
        redline = SKSpriteNode(texture: redlineTexture)
        redline.position = CGPoint(x: self.frame.width*0.87, y:self.frame.height*0.825)
        redline.zPosition = 99
        redline.size = CGSize(width: 100 , height: 40)
        self.addChild(redline)
        
        let redline2Texture = SKTexture(imageNamed: "redLine")
        redline2 = SKSpriteNode(texture: redline2Texture)
        redline2.position = CGPoint(x: self.frame.width*0.1, y:self.frame.height*0.728)
        redline2.zPosition = 99
        redline2.size = CGSize(width: 80 , height: 40)
        self.addChild(redline2)
        
        //Parameters and display of sprite button
        let button2Texture = SKTexture(imageNamed: "boutonmenu1")
        button2 = SKSpriteNode(texture: button2Texture)
        button2.position = CGPoint(x: self.frame.width*0.5, y:self.frame.height*0.55)
        button2.zPosition = 99
        button2.size = CGSize(width: 230 , height: 80)
        self.addChild(button2)
        
        //Parameters and display of the label ARCADE
        arcade.text = "ARCADE"
        arcade.fontSize = 38
        arcade.zPosition = 100
        arcade.fontColor = SKColor.black
        arcade.position = CGPoint(x:self.frame.midX, y:self.frame.height*0.53);
        arcade.run(forever)
        self.addChild(arcade)
        
        let buttonTexture = SKTexture(imageNamed: "boutonmenu1")
        button1 = SKSpriteNode(texture: buttonTexture)
        button1.position = CGPoint(x: self.frame.width*0.5, y:self.frame.height*0.35)
        button1.zPosition = 99
        button1.size = CGSize(width: 230 , height: 80)
        self.addChild(button1)

        //Parameters and display of the PLAY label
        play.text = "MISSIONS"
        play.fontSize = 35;
        play.zPosition = 100
        play.fontColor = SKColor.black
        play.position = CGPoint(x:self.frame.width*0.5, y:self.frame.height*0.33)
        play.run(forever)
        self.addChild(play)
        
        //Parameters and display of sprite button
        let button3Texture = SKTexture(imageNamed: "boutonmenu1")
        button3 = SKSpriteNode(texture: button3Texture)
        button3.position = CGPoint(x: self.frame.width*0.5, y:self.frame.height*0.15)
        button3.zPosition = 99
        button3.size = CGSize(width: 230 , height: 80)
        self.addChild(button3)
        
        //Parameters and display of the HIGH SCORE label
        highscore.text = "HIGH SCORE"
        highscore.fontSize = 26
        highscore.zPosition = 100
        highscore.fontColor = SKColor.black
        highscore.position = CGPoint(x:self.frame.width*0.5, y:self.frame.height*0.13);
        highscore.run(forever)
        self.addChild(highscore)
        
        //Parameters to display sprites to listen or to stop music
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
        
        //Loading saved data for Mission mode
        Setup.planet2Unlocked = UserDefaults().bool(forKey: "planet2State")
        Setup.planet3Unlocked = UserDefaults().bool(forKey: "planet3State")
        Setup.planet4Unlocked = UserDefaults().bool(forKey: "planet4State")
        Setup.planet5Unlocked = UserDefaults().bool(forKey: "planet5State")
        Setup.planet6Unlocked = UserDefaults().bool(forKey: "planet6State")
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /* Called when a touch begins */
        if let touch = touches.first{
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            if node == play {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
                    let scene = MapScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == button1 {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
                    let scene = MapScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == arcade  {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
                    let scene = ArcadeDifficultyScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == button2  {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
                    let scene = ArcadeDifficultyScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == highscore {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
                    let scene = HighScoreScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == button3{
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
                    let scene = HighScoreScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == playMusic {
                if view != nil {
                    playMusic.removeFromParent()
                    let musicStopTexture = SKTexture(imageNamed: "stopmusic")
                    stopMusic  = SKSpriteNode(texture: musicStopTexture)
                    stopMusic.position = CGPoint(x: self.frame.width*0.95, y:self.frame.height*0.97)
                    stopMusic.zPosition = 100
                    stopMusic.size = CGSize(width: 30, height: 30)
                    self.addChild(stopMusic)
                    addChild(backgroundMusic)
                    music = 0
                    UserDefaults.standard.set(0, forKey: "music")
                }
            }
            else if node == stopMusic {
                if view != nil {
                    stopMusic.removeFromParent()
                    let musicTexture = SKTexture(imageNamed: "playmusic")
                    playMusic  = SKSpriteNode(texture: musicTexture)
                    playMusic.position = CGPoint(x: self.frame.width*0.95, y:self.frame.height*0.97)
                    playMusic.zPosition = 100
                    playMusic.size = CGSize(width: 30, height: 30)
                    self.addChild(playMusic)
                    backgroundMusic.removeFromParent()
                    music = 1
                    UserDefaults.standard.set(1, forKey: "music")
                }
            }
        }
        
    }
}
