//
//  HighScoreScene.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class HighScoreScene: SKScene {
    
    var backimage = SKSpriteNode(imageNamed: "highScoreBg")
    var title1 = SKLabelNode(fontNamed:"moonhouse")
    var title2 = SKLabelNode(fontNamed:"moonhouse")
    var back = SKLabelNode(fontNamed:"moonhouse")
    
    var blueline1 = SKSpriteNode(imageNamed: "blueline")
    var blueline2 = SKSpriteNode(imageNamed: "blueline")
    var blueline3 = SKSpriteNode(imageNamed: "blueline")
    var redline = SKSpriteNode(imageNamed: "redline")
    var redline2 = SKSpriteNode(imageNamed: "redline")
    
    var rect1: SKShapeNode?                                                         //rectangle box for the highscoreLabel1
    var rect2: SKShapeNode?                                                         //rectangle box for the highscoreLabel2
    var rect3: SKShapeNode?                                                         //rectangle box for the highscoreLabel3
    
    let backgroundMusic = SKAudioNode(fileNamed: "GameOverMusic.mp3")
    let gameoverscene: GameOverScene = GameOverScene()
    
    override func didMove(to view: SKView) {
        
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 2)
        let forever = SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn]))
        
        //Setup rectangles for highscore labels
        rect1 = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.95, height: 80))
        rect1?.fillColor = UIColor(red: 0.73, green: 0.67, blue: 0.23, alpha: 0.4)
        rect1?.position = CGPoint(x: self.size.width/2, y: self.size.height*0.6)
        rect1?.strokeColor = UIColor(red: 0.98, green: 0.98, blue: 0.73, alpha: 1)
        rect1?.glowWidth = 0.8
        rect1?.zPosition = 99
        rect2 = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.95, height: 80))
        rect2?.fillColor = UIColor(red: 0.73, green: 0.67, blue: 0.23, alpha: 0.4)
        rect2?.position = CGPoint(x: self.size.width/2, y: self.size.height*0.4)
        rect2?.strokeColor = UIColor(red: 0.98, green: 0.98, blue: 0.73, alpha: 1)
        rect2?.glowWidth = 0.8
        rect2?.zPosition = 99
        rect3 = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.95, height: 80))
        rect3?.fillColor = UIColor(red: 0.73, green: 0.67, blue: 0.23, alpha: 0.4)
        rect3?.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        rect3?.strokeColor = UIColor(red: 0.98, green: 0.98, blue: 0.73, alpha: 1)
        rect3?.glowWidth = 0.8
        rect3?.zPosition = 99
        
        let backTexture = SKTexture(imageNamed: "highScoreBg")
        backimage = SKSpriteNode(texture: backTexture)
        backimage.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        backimage.zPosition = 0
        backimage.size = CGSize(width: 350, height: 600)
        self.addChild(backimage)
        
        title1.text = "HIGH"
        title1.fontSize = 55
        title1.zPosition = 100
        title1.fontColor = SKColor.red
        title1.position = CGPoint(x:self.frame.width*0.25, y:self.frame.height*0.82);
        self.addChild(title1)
        
        title2.text = "SCORES"
        title2.fontSize = 55
        title2.zPosition = 100
        title2.fontColor = SKColor.red
        title2.position = CGPoint(x:self.frame.width*0.6, y:self.frame.height*0.72);
        self.addChild(title2)
        
        let redlineTexture = SKTexture(imageNamed: "redLine")
        redline = SKSpriteNode(texture: redlineTexture)
        redline.position = CGPoint(x: self.frame.width*0.78, y:self.frame.height*0.825)
        redline.zPosition = 99
        redline.size = CGSize(width: 170 , height: 40)
        self.addChild(redline)
        
        let redline2Texture = SKTexture(imageNamed: "redLine")
        redline2 = SKSpriteNode(texture: redline2Texture)
        redline2.position = CGPoint(x: self.frame.width*0.05, y:self.frame.height*0.728)
        redline2.zPosition = 99
        redline2.size = CGSize(width: 52 , height: 40)
        self.addChild(redline2)
        
        back.text = "Back"
        back.fontSize = 20
        back.zPosition = 100
        back.position = CGPoint(x:self.frame.width*0.15, y:self.frame.height*0.95)
        self.addChild(back)
        
        let highscoreLabel1 = SKLabelNode(fontNamed: "moonhouse")
        
        highscoreLabel1.text = "1st:  \(gameoverscene.difficultyLevel1 ?? "")   \(gameoverscene.highscore1)"
        highscoreLabel1.fontSize = 30
        highscoreLabel1.fontColor = UIColor(red: 0.12, green: 0.52, blue: 1, alpha: 1)
        highscoreLabel1.position = CGPoint(x: self.size.width/2, y: self.size.height*0.6)
        highscoreLabel1.zPosition = 100
        addChild(rect1!)
        addChild(highscoreLabel1)
        
        let bluelineTexture = SKTexture(imageNamed: "blueLine")
        blueline1 = SKSpriteNode(texture: bluelineTexture)
        blueline1.position = CGPoint(x: self.frame.width*0.5, y:self.frame.height*0.7)
        blueline1.zPosition = 99
        blueline1.size = CGSize(width: 240 , height: 150)
        blueline1.run(forever)
        self.addChild(blueline1)
        
        let highscoreLabel2 = SKLabelNode(fontNamed: "moonhouse")
        
        highscoreLabel2.text = "2nd:  \(gameoverscene.difficultyLevel2 ?? "")   \(gameoverscene.highscore2)"
        highscoreLabel2.fontSize = 30
        highscoreLabel2.fontColor = UIColor(red: 0.12, green: 0.52, blue: 1, alpha: 1)
        highscoreLabel2.position = CGPoint(x: self.size.width/2, y: self.size.height*0.4)
        highscoreLabel2.zPosition = 100
        addChild(rect2!)
        addChild(highscoreLabel2)
        
        let blueline2Texture = SKTexture(imageNamed: "blueLine")
        blueline2 = SKSpriteNode(texture: blueline2Texture)
        blueline2.position = CGPoint(x: self.frame.width*0.5, y:self.frame.height*0.5)
        blueline2.zPosition = 99
        blueline2.size = CGSize(width: 240 , height: 150)
        blueline2.run(forever)
        self.addChild(blueline2)
        
        let highscoreLabel3 = SKLabelNode(fontNamed: "moonhouse")
        
        highscoreLabel3.text = "3rd:  \(gameoverscene.difficultyLevel3 ?? "")   \(gameoverscene.highscore3)"
        highscoreLabel3.fontSize = 30
        highscoreLabel3.fontColor = UIColor(red: 0.12, green: 0.52, blue: 1, alpha: 1)
        highscoreLabel3.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        highscoreLabel3.zPosition = 100
        addChild(rect3!)
        addChild(highscoreLabel3)
        
        let blueline3Texture = SKTexture(imageNamed: "blueLine")
        blueline3 = SKSpriteNode(texture: blueline3Texture)
        blueline3.position = CGPoint(x: self.frame.width*0.5, y:self.frame.height*0.3)
        blueline3.zPosition = 99
        blueline3.size = CGSize(width: 240 , height: 150)
        blueline3.run(forever)
        self.addChild(blueline3)
        
        //Music
        if (UserDefaults().integer(forKey: "music") != 1){
            backgroundMusic.autoplayLooped = true
            addChild(backgroundMusic)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        if let touch = touches.first{
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            if node == back {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5)
                    let scene = MenuScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
    
}
