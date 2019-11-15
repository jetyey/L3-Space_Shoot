//
//  ArcadeShipSelection.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class ArcadeShipSelectionScene: SKScene {
    
    
    var shipSprite1: SKSpriteNode?
    var shipSprite2: SKSpriteNode?
    var shipSprite3: SKSpriteNode?
    var shipSprite4: SKSpriteNode?
    var shipSprite5: SKSpriteNode?
    var shipSprite6: SKSpriteNode?
    var textureArrayShip = [SKTexture]()                                        //An array of texture images to be animated
    var animationBox = SKSpriteNode(imageNamed: "shipAnimation1")               //The box that will contain the images to be animated
    let label = SKLabelNode(fontNamed: "moonhouse")
    let backButton = SKLabelNode(fontNamed:"moonhouse")
    let backgroundMusic = SKAudioNode(fileNamed: "ShipSelectionMusic.mp3")
    let menuscene: MenuScene = MenuScene()                                  //Class MenuScene
    var cover: SKShapeNode?                                                 //Cover up the ShipSelectionScene when the animation plays
    
    //SkActions
    let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
    let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.5)
    var animate: SKAction?
    let play = SKAction.playSoundFileNamed("warping.wav", waitForCompletion: false)
    let wait = SKAction.wait(forDuration: 2.5)
    
    
    override func didMove(to view: SKView) {
        
        //Setting up texture array
        for index in 1 ... 18 {
            let textureName = "shipAnimation\(index)"
            let texture = SKTexture(imageNamed: textureName)
            textureArrayShip.append(texture)
        }
        animate = SKAction.animate(with: textureArrayShip, timePerFrame: 0.1)
        animationBox.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        animationBox.zPosition = 100
        
        //Setup Cover
        cover = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: self.frame.height))
        cover?.fillColor = SKColor.darkGray
        cover?.alpha = 0.2
        cover?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        cover?.zPosition = 99
        
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
        
        //Label
        label.text = "Choose your spaceship"
        label.position = CGPoint(x: self.frame.midX, y: self.frame.height*0.07)
        label.zPosition = 0
        label.fontSize = 20
        let forever = SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn]))
        label.run(forever)
        self.addChild(label)
        
        //Adding Ships
        
        //1st line
        placeShip(ship: "Ship1", position: CGPoint(x: self.frame.width*0.25, y: self.frame.height*0.75), shipNum: 1)
        placeShip(ship: "Ship2", position: CGPoint(x: self.frame.width*0.75, y: self.frame.height*0.75), shipNum: 2)
        
        //2nd line
        placeShip(ship: "Ship3", position: CGPoint(x: self.frame.width*0.25, y: self.frame.midY), shipNum: 3)
        placeShip(ship: "Ship4", position: CGPoint(x: self.frame.width*0.75, y: self.frame.midY), shipNum: 4)
        
        //3rd line
        placeShip(ship: "Ship5", position: CGPoint(x: self.frame.width*0.25, y: self.frame.height*0.25), shipNum: 5)
        placeShip(ship: "Ship6", position: CGPoint(x: self.frame.width*0.75, y: self.frame.height*0.25), shipNum: 6)
        
        //Music to play or not
        if (menuscene.music != 1){
            backgroundMusic.autoplayLooped = true
            addChild(backgroundMusic)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        if let touch = touches.first {
            
            //Setting up the game
            Setup.score = 10000000
            Setup.image = "background2"
            
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == shipSprite1 {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 1)
                    let scene = GameScene(size: self.scene!.size)
                    Setup.shipName = "Ship1"
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    backgroundMusic.removeFromParent()
                    let playAnimation = SKAction.run {
                        self.animationBox.run(self.animate!)
                        self.addChild(self.cover!)
                        self.addChild(self.animationBox)
                    }
                    run(SKAction.sequence([play, playAnimation, wait]), completion: {
                        self.scene?.view?.presentScene(scene, transition: transition)
                    })
                }
            }
            else if node == shipSprite2 {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 1)
                    let scene = GameScene(size: self.scene!.size)
                    Setup.shipName = "Ship2"
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    backgroundMusic.removeFromParent()
                    let playAnimation = SKAction.run {
                        self.animationBox.run(self.animate!)
                        self.addChild(self.cover!)
                        self.addChild(self.animationBox)
                    }
                    run(SKAction.sequence([play, playAnimation, wait]), completion: {
                        self.scene?.view?.presentScene(scene, transition: transition)
                    })
                }
            }
            else if node == shipSprite3 {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 1)
                    let scene = GameScene(size: self.scene!.size)
                    Setup.shipName = "Ship3"
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    backgroundMusic.removeFromParent()
                    let playAnimation = SKAction.run {
                        self.animationBox.run(self.animate!)
                        self.addChild(self.cover!)
                        self.addChild(self.animationBox)
                    }
                    run(SKAction.sequence([play, playAnimation, wait]), completion: {
                        self.scene?.view?.presentScene(scene, transition: transition)
                    })
                }
            }
            else if node == shipSprite4 {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 1)
                    let scene = GameScene(size: self.scene!.size)
                    Setup.shipName = "Ship4"
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    backgroundMusic.removeFromParent()
                    let playAnimation = SKAction.run {
                        self.animationBox.run(self.animate!)
                        self.addChild(self.cover!)
                        self.addChild(self.animationBox)
                    }
                    run(SKAction.sequence([play, playAnimation, wait]), completion: {
                        self.scene?.view?.presentScene(scene, transition: transition)
                    })
                }
            }
            else if node == shipSprite5 {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 1)
                    let scene = GameScene(size: self.scene!.size)
                    Setup.shipName = "Ship5"
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    backgroundMusic.removeFromParent()
                    let playAnimation = SKAction.run {
                        self.animationBox.run(self.animate!)
                        self.addChild(self.cover!)
                        self.addChild(self.animationBox)
                    }
                    run(SKAction.sequence([play, playAnimation, wait]), completion: {
                        self.scene?.view?.presentScene(scene, transition: transition)
                    })
                }
            }
            else if node == shipSprite6 {
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 1)
                    let scene = GameScene(size: self.scene!.size)
                    Setup.shipName = "Ship6"
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    backgroundMusic.removeFromParent()
                    let playAnimation = SKAction.run {
                        self.animationBox.run(self.animate!)
                        self.addChild(self.cover!)
                        self.addChild(self.animationBox)
                    }
                    run(SKAction.sequence([play, playAnimation, wait]), completion: {
                        self.scene?.view?.presentScene(scene, transition: transition)
                    })
                }
            }
            else if node == backButton{
                if view != nil {
                    let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                    let scene = ArcadeDifficultyScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.aspectFit
                    scene.backgroundColor = UIColor.black
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
    
    
    /*
     placeShip
     input: ship: Sprite of the ship to be displayed
     position: Position of the rectangle where the ship will be placed
     shipNum: To associate the correct sprite node to the variable shipSprite
     Func: Create the ship avatars dto be displayed on scene
     */
    func placeShip(ship: String, position: CGPoint, shipNum: Int) {
        
        //Create box for ship
        let rect = SKShapeNode(rectOf: CGSize(width: self.frame.width*0.33, height: self.frame.width*0.33))
        rect.position = position
        rect.zPosition = 1
        rect.fillColor = SKColor.lightGray
        rect.alpha = 0.2
        
        //Creating ShipNode
        if shipNum == 1 {
            shipSprite1 = SKSpriteNode(imageNamed: ship)
            shipSprite1?.name = ship
            shipSprite1?.size = CGSize(width: 70, height: 70)
            shipSprite1?.zPosition = 2
            shipSprite1?.position = rect.position
            self.addChild(shipSprite1!)
        }
        else if shipNum == 2 {
            shipSprite2 = SKSpriteNode(imageNamed: ship)
            shipSprite2?.name = ship
            shipSprite2?.size = CGSize(width: 70, height: 70)
            shipSprite2?.zPosition = 2
            shipSprite2?.position = rect.position
            self.addChild(shipSprite2!)
        }
        else if shipNum == 3 {
            shipSprite3 = SKSpriteNode(imageNamed: ship)
            shipSprite3?.name = ship
            shipSprite3?.size = CGSize(width: 70, height: 70)
            shipSprite3?.zPosition = 2
            shipSprite3?.position = rect.position
            self.addChild(shipSprite3!)
        }
        else if shipNum == 4 {
            shipSprite4 = SKSpriteNode(imageNamed: ship)
            shipSprite4?.name = ship
            shipSprite4?.size = CGSize(width: 70, height: 70)
            shipSprite4?.zPosition = 2
            shipSprite4?.position = rect.position
            self.addChild(shipSprite4!)
        }
        else if shipNum == 5 {
            shipSprite5 = SKSpriteNode(imageNamed: ship)
            shipSprite5?.name = ship
            shipSprite5?.size = CGSize(width: 70, height: 70)
            shipSprite5?.zPosition = 2
            shipSprite5?.position = rect.position
            self.addChild(shipSprite5!)
        }
        else if shipNum == 6 {
            shipSprite6 = SKSpriteNode(imageNamed: ship)
            shipSprite6?.name = ship
            shipSprite6?.size = CGSize(width: 70, height: 70)
            shipSprite6?.zPosition = 2
            shipSprite6?.position = rect.position
            self.addChild(shipSprite6!)
        }
        
        //Adding Childen on scene
        self.addChild(rect)
    }
}
