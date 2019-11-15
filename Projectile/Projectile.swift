//
//  Projectile.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class Projectile: SKSpriteNode {
    
    var spTexture = SKTexture()                   //Variable to store texture of a sprite node
    
    /*
     SpriteName
     function: assigns the name of the sprite node
    */
    class func SpriteName() -> String {
        return "projectile"
    }
    
    /*
     init
     input: pos: The position where the projectile will spawn (player ship's position)
            projectileType: Type of projectile the user is using (normal, laser, or shotgun)
     function: initializes the projectile class. Setting up its physic's body, it's texture etc.
     */
    init(pos: CGPoint, projectileType: String) {
        
        spTexture = SKTexture(imageNamed: projectileType)
        super.init(texture: spTexture, color: UIColor.clear, size: spTexture.size())
        self.position = pos
        
        self.zPosition = 2
        self.physicsBody = SKPhysicsBody(texture: spTexture, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.allowsRotation = false
        self.name = Projectile.SpriteName()
        
        self.physicsBody?.categoryBitMask = laserShotBitMask
        self.physicsBody?.collisionBitMask = enemyBitMask
        self.physicsBody?.contactTestBitMask = enemyBitMask
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     shootProjectile
     function: call a shoot action by adding the sprite, animating then deleting it on the GameScene.
    */
    func shootProjectile(parent2: SKNode) -> Void {
        self.position = CGPoint(x: self.position.x, y: self.position.y-20)
        parent2.addChild(self)
        let finalPos = self.parent?.frame.height
        let moveAction = SKAction.moveBy(x: 0, y: finalPos!+200.0, duration: 0.7)
        let deleteProjectile = SKAction.removeFromParent()
        moveAction.timingMode = SKActionTimingMode.easeInEaseOut
        self.run(SKAction.sequence([moveAction, deleteProjectile]))
    }
    
}
