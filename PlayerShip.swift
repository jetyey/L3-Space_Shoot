//
//  PlayerShip.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class PlayerShip: SKSpriteNode {
    
    var parentNode : SKNode                //class GameScene
    var firePressed: Bool = false          //Sets the SpriteNode to fire or not
    var initialYPos: CGFloat = 0.0         //takes the initial Y position set in game scene
    var projNum: Int = 0                   //Projectile number (0: normal, 1: Laser, 2: shotgun)
    let fireRate = 5                       //limits the projectiles on screen
    var fireWaitCount = 0                  //stops projectile spawn when fireRate is reached
    var shipSprite: SKSpriteNode = SKSpriteNode(imageNamed: "Ship1")         //Sprite of player's ship
    
    /*
     SpriteName
     function: overrides the assigned name of the sprite node
    */
    class func SpriteName() -> String {
        return "player"
    }
    
    /*
     getCurrentPosition
     function: function that gets the player ship's current (x,y) position
    */
    func getCurrentPosition() -> CGPoint{
        return shipSprite.position
    }

    /*
     changePosition
     function: function that changes the player ship's current (x,y) position
    */
    func changePosition(pos: CGFloat) -> Void{
        shipSprite.position.x += pos
    }
    
    //Initialization
    init (initialYPos:CGFloat, image: String, parent:SKScene, pos:CGPoint){
        self.initialYPos = initialYPos
        parentNode = parent
        shipSprite = SKSpriteNode(imageNamed: image)
        let spTexture = SKTexture(imageNamed: image)
        super.init(texture: spTexture, color: UIColor.clear, size: spTexture.size())
        shipSprite.physicsBody = SKPhysicsBody(texture: spTexture, size: shipSprite.size)
        shipSprite.physicsBody?.categoryBitMask = playerBitMask
        shipSprite.physicsBody?.collisionBitMask = enemyBitMask
        shipSprite.physicsBody?.contactTestBitMask = enemyBitMask
        shipSprite.name = PlayerShip.SpriteName()

        shipSprite.physicsBody?.isDynamic = false
        shipSprite.physicsBody?.allowsRotation = false
        
        shipSprite.xScale = 1.5
        shipSprite.yScale = 1.5
        shipSprite.position = pos
        shipSprite.zPosition = 2
        parentNode.addChild(shipSprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     updateAction
     function: updates playership's action. Here it lets the ship shoot
    */
    func updateAction() -> Void{
        if (firePressed){
            if(fireWaitCount >= fireRate) {
                firePressed = false
                fireLaser()
                fireWaitCount = 0
            }
            fireWaitCount += 1
        }
    }
    
    /*
     fireLaser
     func: the func is called when player ship shoots
    */
    func fireLaser() -> Void {
        if (projNum == 0){
            let shot = Projectile(pos: CGPoint(x: shipSprite.position.x, y: shipSprite.position.y+shipSprite.size.height), projectileType: "playerProjectile")
            shot.shootProjectile(parent2: self.parentNode)
        }
        else if (projNum == 1){
            let shot = LaserProjectile(pos: CGPoint(x: shipSprite.position.x, y: shipSprite.position.y+shipSprite.size.height), projectileType: "laser")
            shot.shootProjectile(parent2: self.parentNode)
        }
        else if (projNum == 2){
            let shot = ShotgunProjectile(pos: CGPoint(x: shipSprite.position.x, y: shipSprite.position.y+shipSprite.size.height), projectileType: "shotgun")
            shot.shootProjectile(parent2: self.parentNode)
        }

    }
    
    /*
     invincibility
     func: render ship temporarily invinsible when shot
    */
    func invincibility(){
        shipSprite.physicsBody?.categoryBitMask = 0
        shipSprite.physicsBody?.collisionBitMask = 0
        shipSprite.physicsBody?.contactTestBitMask = 0
        
        let pulsedRed = SKAction.sequence([
            SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.2),
            SKAction.wait(forDuration: 0.1),
            SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.2)])
        shipSprite.run(pulsedRed)
        shipSprite.run(pulsedRed)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.shipSprite.physicsBody?.categoryBitMask = playerBitMask
            self.shipSprite.physicsBody?.collisionBitMask = enemyBitMask
            self.shipSprite.physicsBody?.contactTestBitMask = enemyBitMask
        }
    }
    
}
