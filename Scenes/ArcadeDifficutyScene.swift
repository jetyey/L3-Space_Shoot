//
//  ArcadeDifficutyScene.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class ArcadeDifficultyScene: SKScene {
    
    let level1Label = SKLabelNode(fontNamed: "moonhouse")                           //Label for level 1
    let level2Label = SKLabelNode(fontNamed: "moonhouse")                           //Label for level 2
    let level3Label = SKLabelNode(fontNamed: "moonhouse")                           //Label for level 3
    let level4Label = SKLabelNode(fontNamed: "moonhouse")                           //Label for level 4
    let level5Label = SKLabelNode(fontNamed: "moonhouse")                           //Label for level 5
    let label = SKLabelNode(fontNamed: "moonhouse")
    let backButton = SKLabelNode(fontNamed:"moonhouse")
    var rect1: SKShapeNode?                                                         //rectangle box for the level1Label
    var rect2: SKShapeNode?                                                         //rectangle box for the level2Label
    var rect3: SKShapeNode?                                                         //rectangle box for the level3Label
    var rect4: SKShapeNode?                                                         //rectangle box for the level4Label
    var rect5: SKShapeNode?                                                         //rectangle box for the level5Label
    let backgroundMusic = SKAudioNode(fileNamed: "WinMusic.mp3")
    let menuscene: MenuScene = MenuScene()                                          //Class MenuScene
    
    override func didMove(to view: SKView) {
        
        //Background
        let starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield?.position = CGPoint(x: 400, y: 720)
        starfield?.advanceSimulationTime(30)
        starfield?.zPosition = -1
        self.addChild(starfield!)
        
        //Back Button
        backButton.text = "Back"
        backButton.fontSize = 20;
        backButton.zPosition = 1
        backButton.position = CGPoint(x:self.frame.width*0.15, y:self.frame.height*0.95);
        self.addChild(backButton)
        
        //Rectangles
        rect1 = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.8, height: 50))
        rect2 = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.8, height: 50))
        rect3 = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.8, height: 50))
        rect4 = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.8, height: 50))
        rect5 = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.8, height: 50))
        
        //Label
        label.text = "Difficulty Level"
        label.position = CGPoint(x: self.frame.midX, y: self.frame.height*0.8)
        label.zPosition = 0
        label.fontSize = 30
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.5)
        let forever = SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn]))
        label.run(forever)
        self.addChild(label)
        
        //Difficulty Options
        placeLevel(text: "Level 1", rect: rect1!, label: level1Label, position: CGPoint(x: self.frame.midX, y: self.frame.height*0.65))
        placeLevel(text: "Level 2", rect: rect2!, label: level2Label, position: CGPoint(x: self.frame.midX, y: self.frame.height*0.55))
        placeLevel(text: "Level 3", rect: rect3!, label: level3Label, position: CGPoint(x: self.frame.midX, y: self.frame.height*0.45))
        placeLevel(text: "Level 4", rect: rect4!, label: level4Label, position: CGPoint(x: self.frame.midX, y: self.frame.height*0.35))
        placeLevel(text: "Level 5", rect: rect5!, label: level5Label, position: CGPoint(x: self.frame.midX, y: self.frame.height*0.25))
        
        //Music to play or not
        if (menuscene.music != 1){
            backgroundMusic.autoplayLooped = true
            addChild(backgroundMusic)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        if let touch = touches.first {
            
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == rect1 || node == level1Label {
                 if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                    let scene = ArcadeShipSelectionScene(size: self.scene!.size)
                    Setup.difficultyLevel = 1
                    Setup.spawnBonusDelay = 10
                    Setup.lives = 15
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == rect2 || node == level2Label {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                    let scene = ArcadeShipSelectionScene(size: self.scene!.size)
                    Setup.difficultyLevel = 1
                    Setup.spawnBonusDelay = 15
                    Setup.lives = 10
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == rect3 || node == level3Label {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                    let scene = ArcadeShipSelectionScene(size: self.scene!.size)
                    Setup.difficultyLevel = 1
                    Setup.spawnBonusDelay = 20
                    Setup.lives = 5
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == rect4 || node == level4Label {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                    let scene = ArcadeShipSelectionScene(size: self.scene!.size)
                    Setup.difficultyLevel = 4
                    Setup.spawnBonusDelay = 25
                    Setup.lives = 3
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == rect5 || node == level5Label {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                    let scene = ArcadeShipSelectionScene(size: self.scene!.size)
                    Setup.difficultyLevel = 5
                    Setup.spawnBonusDelay = 30
                    Setup.lives = 1
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
            else if node == backButton{
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                    let scene = MenuScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
    
    /*
     placeLevel
     input: text: Text to be displayed by the label
            rect: The rectangle to place the label
            label:  Label
            position: Position of the node created
     Func: Create the node(rect, label with text) and position then on the scene
     */
    func placeLevel(text: String, rect: SKShapeNode, label: SKLabelNode, position: CGPoint) {
        
        rect.position = position
        rect.zPosition = 1
        rect.fillColor = SKColor.lightGray
        rect.alpha = 0.3
        
        //Creating Levels
        label.text = text
        label.zPosition = 2
        label.fontSize = 30
        label.position = CGPoint(x: position.x, y: position.y - 5)
        self.addChild(label)
    
        //Adding Children on scene
        self.addChild(rect)
    }
}
