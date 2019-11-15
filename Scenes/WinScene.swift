//
//  WinScene.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class WinScene: SKScene {
    
    //Labels nodes
    let continu = SKLabelNode(fontNamed:"moonhouse")
    let scoreLabel = SKLabelNode(fontNamed:"moonhouse")
    let continueLabel = SKLabelNode(fontNamed: "moonhouse")
    let replay = SKLabelNode(fontNamed:"moonhouse")
    let quit = SKLabelNode(fontNamed:"moonhouse")
    
    //Sprite nodes
    var button1 = SKSpriteNode(imageNamed: "button")                            //Button that calls the GameScene for replay
    var button2 = SKSpriteNode(imageNamed: "button")                            //Button that calls the MenuScene
    var back = SKSpriteNode(imageNamed: "background")                           //Background WinScene
    var playMusic = SKSpriteNode(imageNamed: "playmusic")                       //This Sprite shows that there isn't music
    var stopMusic = SKSpriteNode(imageNamed: "stopmusic")                       //This Sprite shows that there is music
    var completed = SKSpriteNode(imageNamed: "completed")                       //Congratulation message
    
    let backgroundMusic = SKAudioNode(fileNamed: "WinMusic.mp3")                //Music when you win

    var score = 0                                                               //Variable to store score after the game
    
    override func didMove(to view: SKView) {
        
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 2)
        let forever = SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn]))
        
        //Parameters and display of the background
        let backTexture = SKTexture(imageNamed: "winSceneBg")
        back = SKSpriteNode(texture: backTexture)
        back.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        back.zPosition =  0
        back.size = CGSize(width: 350, height: 600)
        self.addChild(back)
        
        //Parameters to display the "Completed" Sprite Node
        let congrats = SKTexture(imageNamed: "completed")
        completed = SKSpriteNode(texture: congrats)
        completed.position = CGPoint(x: self.frame.width*0.5, y:self.frame.height*0.83)
        completed.zPosition = 102
        completed.size = CGSize(width: 270, height: 130)
        self.addChild(completed)
        
        //Parameters and display of the label that shows your score
        scoreLabel.text = "Your score: \(score)"
        scoreLabel.fontSize = 26;
        scoreLabel.zPosition = 100
        scoreLabel.position = CGPoint(x:self.frame.midX, y:self.frame.height*0.6)
        self.addChild(scoreLabel)
        
        //Parameters and display of the label to play the next mission
        continueLabel.text = "Next mission"
        continueLabel.fontSize = 32
        continueLabel.fontColor = SKColor.white
        continueLabel.position = CGPoint(x:self.frame.midX, y:self.frame.height*0.35)
        let dialogBoxEffect1 = SKAction.colorize(with: UIColor.green, colorBlendFactor: 0.6 , duration: 1)
        let dialogBoxEffect2 = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1 , duration: 1)
        let foreverDialogBoxEffect = SKAction.repeatForever(SKAction.sequence([dialogBoxEffect1, dialogBoxEffect2]))
        continueLabel.run(foreverDialogBoxEffect)
        addChild(continueLabel)
        
        //Parameters and display of the button to go to the GameScene to restart the game
        let button1Texture = SKTexture(imageNamed: "boutonmenu1")
        button1 = SKSpriteNode(texture: button1Texture)
        button1.position = CGPoint(x: self.frame.width*0.25, y:self.frame.height*0.15)
        button1.zPosition = 102
        button1.size = CGSize(width: 150, height: 80)
        self.addChild(button1)
        
        //Parameters and display of the label to go to the GameScene restart the game
        replay.text = "REPLAY"
        replay.fontSize = 27;
        replay.zPosition = 103
        replay.fontColor = SKColor.black
        replay.position = CGPoint(x:self.frame.width*0.25, y:self.frame.height*0.14);
        replay.run(forever)
        self.addChild(replay)
        
        //Parameters and display of the button to go to the MenuScene
        let button2Texture = SKTexture(imageNamed: "boutonmenu1")
        button2 = SKSpriteNode(texture: button2Texture)
        button2.position = CGPoint(x: self.frame.width*0.75, y:self.frame.height*0.15)
        button2.zPosition = 102
        button2.size = CGSize(width: 150, height: 80)
        self.addChild(button2)
        
        //Parameters and display of the button to go to the MenuScene
        quit.text = "QUIT"
        quit.fontSize = 30;
        quit.zPosition = 103
        quit.fontColor = SKColor.black
        quit.run(forever)
        quit.position = CGPoint(x:self.frame.width*0.75, y:self.frame.height*0.14);
        self.addChild(quit)
        
        //If there was a music on the previous scene then there is a music
        if (UserDefaults().integer(forKey: "music") != 1){
            
            let musicStopTexture = SKTexture(imageNamed: "stopmusic")
            stopMusic  = SKSpriteNode(texture: musicStopTexture)
            stopMusic.position = CGPoint(x: self.frame.width*0.95, y:self.frame.height*0.97)
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
            playMusic.position = CGPoint(x: self.frame.width*0.95, y:self.frame.height*0.97)
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
            if node == replay {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 3.0)
                    let scene = GameScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    backgroundMusic.removeFromParent()
                    let play = SKAction.playSoundFileNamed("warping.wav", waitForCompletion: false)
                    let block = SKAction.run({
                        self.scene?.view?.presentScene(scene, transition: transition)
                    })
                    run(SKAction.sequence([play, block]))
                }
            }
            // Quit the game when you tuch quit label
            else if node == quit{
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5)
                    let scene = MenuScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            // when you tuch this label,  you go on the next mission
            else if node == continueLabel{
                if view != nil {
                    var scene: SKScene?
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 3.0)
                    if Setup.planet4Unlocked{
                        scene = MapScene2(size: self.scene!.size)
                    }
                    else{
                        scene = MapScene(size: self.scene!.size)
                    }
                    scene?.scaleMode = SKSceneScaleMode.aspectFit
                    scene?.backgroundColor = UIColor.black
                    backgroundMusic.removeFromParent()
                    let play = SKAction.playSoundFileNamed("warping.wav", waitForCompletion: false)
                    let block = SKAction.run({
                        self.scene?.view?.presentScene(scene!, transition: transition)
                    })
                    run(SKAction.sequence([play, block]))
                }
            }
            // when you touch this sprite, the music is stopped
            else if node == stopMusic {
                if view != nil {
                    stopMusic.removeFromParent()
                    let musicTexture = SKTexture(imageNamed: "playmusic")
                    playMusic  = SKSpriteNode(texture: musicTexture)
                    playMusic.position = CGPoint(x: self.frame.width*0.94, y:self.frame.height*0.95)
                    playMusic.zPosition = 100
                    playMusic.size = CGSize(width: 30, height: 30)
                    self.addChild(playMusic)
                    backgroundMusic.removeFromParent() // Stop the music
                    
                    UserDefaults.standard.set(1, forKey: "music")
                }
            }
            // when you touch this sprite, the music is played
            else if node == playMusic {
                if view != nil {
                    playMusic.removeFromParent()
                    let musicStopTexture = SKTexture(imageNamed: "stopmusic")
                    stopMusic  = SKSpriteNode(texture: musicStopTexture)
                    stopMusic.position = CGPoint(x: self.frame.width*0.94, y:self.frame.height*0.95)
                    stopMusic.zPosition = 100
                    stopMusic.size = CGSize(width: 30, height: 30)
                    self.addChild(stopMusic)
                    addChild(backgroundMusic) //Play the music
                    UserDefaults.standard.set(0, forKey: "music")
                    
                }
            }
        }
    }
}
