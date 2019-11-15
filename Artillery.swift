//
//  Artillery.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class Artillery {
    
    var button1 : SKShapeNode?      //button 1 of artillery
    var button2 : SKShapeNode?      //button 2 of artillery
    var button3 : SKShapeNode?      //button 3 of artillery
    var buttonname1: String?         //button name1: it will take the projectile name
    var buttonname2: String?         //button name2: it will take the projectile name
    var buttonname3: String?         //button name3: it will take the projectile name
    var parent: SKNode?             //class GameScene
    var spaceShip: PlayerShip?       //class PlayerShip
   
    
    //Info Box about the bonuses
    var infoBoxBonus: SKSpriteNode?    //Information box that appears when a bonus is touched for the 1st time
    var xButtton: SKSpriteNode?        //"x" to close the infobox
    var healthInfo: Int = 1            //variable to set the apparition of the infoBox once for health
    var laserInfo: Int = 1             //variable to set the apparition of the infoBox once for laser
    var shotgunInfo: Int = 1           //variable to set the apparition of the infoBox once for shotgun
    
    /*
     SpriteName
     function: overrides the assigned name of the sprite node
    */
    class func SpriteName() -> String {
        return "artillery"
    }
    
    /*
     init
     input: parentNode: Set parent as GameScene's scene
     function: Initialize the artillery by creating the nodes on scene
     */
    init(parentNode: SKNode){
        parent = parentNode
        createButton()
    }
    
    /*
     createButton
     function: creates the artillery in GameScene
    */
    func createButton(){
        //Button 1
        //Create shape
        button1 = SKShapeNode(circleOfRadius: 23)
        button1?.fillColor = SKColor.white
        button1?.strokeColor = SKColor.white
        button1?.glowWidth = 1.0
        button1?.fillTexture = SKTexture(imageNamed: "buttonTexture")
        //Position
        button1?.position = CGPoint(x: (parent?.frame.minX)!+23, y: (parent?.frame.height)!*0.16)
        button1?.zPosition = 5
        //Naming
        button1?.name = Artillery.SpriteName()
        
        //Button 2
        button2 = SKShapeNode(circleOfRadius: 23)
        button2?.fillColor = SKColor.white
        button2?.strokeColor = SKColor.white
        button2?.glowWidth = 1.0
        button2?.fillTexture = SKTexture(imageNamed: "buttonTexture")
        //Position
        button2?.position = CGPoint(x: (parent?.frame.minX)!+23, y: (parent?.frame.height)!*0.25)
        button2?.zPosition = 5
        //Naming
        button2?.name = Artillery.SpriteName()
        
        //Button 3
        button3 = SKShapeNode(circleOfRadius: 23)
        button3?.fillColor = SKColor.white
        button3?.strokeColor = SKColor.white
        button3?.glowWidth = 1.0
        button3?.fillTexture = SKTexture(imageNamed: "buttonTexture")
        //Position
        button3?.position = CGPoint(x: (parent?.frame.minX)!+23, y: (parent?.frame.height)!*0.34)
        button3?.zPosition = 5
        //Naming
        button3?.name = Artillery.SpriteName()
 
        //Adding Sprites
        parent?.addChild(button1!)
        parent?.addChild(button2!)
        parent?.addChild(button3!)
    }
    
    /*
     updateButton
     input: butnum: Button number (1,2 or 3)
            name: the name of the bonus collided to the playerShip
     function: Updates the artillery when bonus collides with the ship
    */
    func updateButton(butnum:Int, name: String){
        if (butnum == 1){
            removeBonus(butnum: butnum)
            button1?.fillTexture = SKTexture(imageNamed: name)
            buttonname1 = name
        }
        else if (butnum == 2){
            removeBonus(butnum: butnum)
            button2?.fillTexture = SKTexture(imageNamed: name)
            buttonname2 = name
        }
        else if (butnum == 3){
            removeBonus(butnum: butnum)
            button3?.fillTexture = SKTexture(imageNamed: name)
            buttonname3 = name
        }
    }
    
    /*
     useButton
     input: butnum: Button number (1,2 or 3)
            spaceShip: PlayerShip to change it's projetile
     function: Apply the change to the playerShip's projectie when bonus is used in the artillery
    */
    func useButton(butnum: Int, spaceShip: PlayerShip){
        if butnum == 1{
            if (buttonname1 == "laserBonus"){
                spaceShip.projNum = 1
                removeBonus(butnum: butnum)
                buttonname1 = ""
                
                //Reverts back the projectile to its normal state
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                    spaceShip.projNum = 0
                }
            }
            else if (buttonname1 == "shotgunBonus"){
                spaceShip.projNum = 2
                removeBonus(butnum: butnum)
                buttonname1 = ""
                
                //Reverts back the projectile to its normal state
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    spaceShip.projNum = 0
                }
            }
        }
        else if butnum == 2{
            if (buttonname2 == "laserBonus"){
                spaceShip.projNum = 1
                removeBonus(butnum: butnum)
                buttonname2 = ""
                
                //Reverts back the projectile to its normal state
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                    spaceShip.projNum = 0
                }
            }
            else if (buttonname2 == "shotgunBonus"){
                spaceShip.projNum = 2
                removeBonus(butnum: butnum)
                buttonname2 = ""
                
                //Reverts back the projectile to its normal state
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    spaceShip.projNum = 0
                }
            }
        }
        else if butnum == 3{
            if (buttonname3 == "laserBonus"){
                spaceShip.projNum = 1
                removeBonus(butnum: butnum)
                buttonname3 = ""
                
                //Reverts back the projectile to its normal state
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                    spaceShip.projNum = 0
                }
            }
            else if (buttonname3 == "shotgunBonus"){
                spaceShip.projNum = 2
                removeBonus(butnum: butnum)
                buttonname3 = ""
                
                //Reverts back the projectile to its normal state
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    spaceShip.projNum = 0
                }
            }
        }
    }
    
    /*
    removeBonus
    input: butnum: to know what button is to be emptied
    function: removes the bonus in artillery
    */
    func removeBonus(butnum: Int) {
        if (butnum == 1){
            button1?.fillTexture = SKTexture(imageNamed: "buttonTexture")
        }
        else if (butnum == 2){
            button2?.fillTexture = SKTexture(imageNamed: "buttonTexture")
        }
        else if (butnum == 3){
            button3?.fillTexture = SKTexture(imageNamed: "buttonTexture")
        }
    }
    
    /*
     displayInfo
     input: bonusName: to know what info will be displayed
     func: displays the infoBox of the bonusName
    */
    func displayInfo(bonusName: String){
        
        if healthInfo == 1 || laserInfo == 1 || shotgunInfo == 1 {
            //Setup SKSpriteNodes
            var bonus: SKSpriteNode
            var rect: SKShapeNode
            let labelSprite: SKSpriteNode = SKSpriteNode(imageNamed: "HealthInfo")
            
            //Setup infoBox
            infoBoxBonus = SKSpriteNode(imageNamed: "infoBonusBox")
            infoBoxBonus?.size = CGSize(width: (parent?.frame.width)!, height: (parent?.frame.height)!/2)
            infoBoxBonus?.zPosition = 20
            infoBoxBonus?.position = CGPoint(x: (parent?.frame.midX)!, y: (parent?.frame.midY)!)
            
            //SetUp X button
            xButtton =  SKSpriteNode(imageNamed: "xButton")
            xButtton?.size = CGSize(width: 45, height: 45)
            xButtton?.zPosition = 21
            xButtton?.position = CGPoint(x: 140 , y: 125)
            infoBoxBonus?.addChild(xButtton!)
            
            //Setup box containing bonus
            rect = SKShapeNode(rectOf: CGSize(width: 80, height: 80))
            rect.fillColor = SKColor.black
            rect.zPosition = 30
            rect.position.y = 50
            
            //Setup bonus detected
            if bonusName == "health" && healthInfo == 1{
                parent?.isPaused = true
                bonus = SKSpriteNode(imageNamed: "health")
                bonus.size = CGSize(width: 70, height: 60)
                rect.addChild(bonus)
                infoBoxBonus?.addChild(rect)
                
                //Label - Info
                labelSprite.texture = SKTexture(imageNamed: "HealthInfo")
                infoBoxBonus?.addChild(labelSprite)
                labelSprite.zPosition = 30
                labelSprite.position.y = -40
                
                healthInfo = 0
                Setup.gameState = false
                parent?.addChild(infoBoxBonus!)
            }
            else if bonusName == "laserBonus" && laserInfo == 1{
                parent?.isPaused = true
                bonus = SKSpriteNode(imageNamed: "laserBonus")
                bonus.size = CGSize(width: 60, height: 60)
                rect.addChild(bonus)
                infoBoxBonus?.addChild(rect)
                
                //Label - Info
                labelSprite.texture = SKTexture(imageNamed: "LaserInfo")
                infoBoxBonus?.addChild(labelSprite)
                labelSprite.zPosition = 30
                labelSprite.position.y = -50
                labelSprite.setScale(1.5)
                
                laserInfo = 0
                Setup.gameState = false
                parent?.addChild(infoBoxBonus!)
            }
            else if bonusName == "shotgunBonus" && shotgunInfo == 1{
                parent?.isPaused = true
                bonus = SKSpriteNode(imageNamed: "shotgunBonus")
                bonus.size = CGSize(width: 60, height: 60)
                rect.addChild(bonus)
                infoBoxBonus?.addChild(rect)
                
                //Label - Info
                labelSprite.texture = SKTexture(imageNamed: "ShotgunInfo")
                infoBoxBonus?.addChild(labelSprite)
                labelSprite.zPosition = 30
                labelSprite.position.y = -50
                labelSprite.setScale(1.5)
                
                shotgunInfo = 0
                Setup.gameState = false
                parent?.addChild(infoBoxBonus!)
            }
        }
    }
    
    /*
     removeInfoBox
     func: removes the infoBox on the scene
    */
    func removeInfoBoxBonus(){
        infoBoxBonus?.removeFromParent()
    }
    
}
