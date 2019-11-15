//
//  LaserProjectile.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

//Convert int variable degree to radian
extension Int{
    var degreesToRadian: Double { return Double(self) * .pi / 180 }
}

class ShotgunProjectile : Projectile {
    
    
    var laserSprite1: Projectile?     //1st sprite in the far left
    var laserSprite2: Projectile?     //2nd sprite in the far left
    var laserSprite4: Projectile?     //4th sprite in the far right
    var laserSprite5: Projectile?     //5th sprite in the far right
    
    /*
     SpriteName
     function: overrides the assigned name of the sprite node
    */
    override class func SpriteName() -> String {
        return "shotgun"
    }
    
    /*
     init
     input: parentNode: GameScene
     pos: The position where the projectile will spawn (player ship's position)
     projectileType: Type of projectile the user is using (normal, laser, or shotgun)
     function: initializes the projectile class. Setting up its physic's body, it's texture etc.
                It also adds the 4 sprites of shootgun.
    */
    override init(pos: CGPoint, projectileType: String){
        super.init(pos: pos, projectileType: projectileType)
        
        //applying textture
        laserSprite1 = Projectile(pos: pos, projectileType: "shotgun")
        laserSprite2 = Projectile(pos: pos, projectileType: "shotgun")
        laserSprite4 = Projectile(pos: pos, projectileType: "shotgun")
        laserSprite5 = Projectile(pos: pos, projectileType: "shotgun")
        
        //Setup
        laserSprite1?.zPosition = 1
        laserSprite2?.zPosition = 1
        laserSprite4?.zPosition = 1
        laserSprite5?.zPosition = 1
       
        laserSprite1?.name = ShotgunProjectile.SpriteName()
        laserSprite2?.name = ShotgunProjectile.SpriteName()
        laserSprite4?.name = ShotgunProjectile.SpriteName()
        laserSprite5?.name = ShotgunProjectile.SpriteName()
        
        //Physics body
        laserSprite1?.physicsBody = SKPhysicsBody(texture: spTexture, size: (laserSprite1?.size)!)
        laserSprite2?.physicsBody = SKPhysicsBody(texture: spTexture, size: (laserSprite2?.size)!)
        laserSprite4?.physicsBody = SKPhysicsBody(texture: spTexture, size: (laserSprite4?.size)!)
        laserSprite5?.physicsBody = SKPhysicsBody(texture: spTexture, size: (laserSprite5?.size)!)
        laserSprite1?.physicsBody?.isDynamic = false
        laserSprite2?.physicsBody?.isDynamic = false
        laserSprite4?.physicsBody?.isDynamic = false
        laserSprite5?.physicsBody?.isDynamic = false
        laserSprite1?.physicsBody?.allowsRotation = false
        laserSprite2?.physicsBody?.allowsRotation = false
        laserSprite4?.physicsBody?.allowsRotation = false
        laserSprite5?.physicsBody?.allowsRotation = false
        laserSprite1?.physicsBody?.categoryBitMask = laserShotBitMask
        laserSprite2?.physicsBody?.categoryBitMask = laserShotBitMask
        laserSprite4?.physicsBody?.categoryBitMask = laserShotBitMask
        laserSprite5?.physicsBody?.categoryBitMask = laserShotBitMask
        laserSprite1?.physicsBody?.collisionBitMask = enemyBitMask
        laserSprite2?.physicsBody?.collisionBitMask = enemyBitMask
        laserSprite4?.physicsBody?.collisionBitMask = enemyBitMask
        laserSprite5?.physicsBody?.collisionBitMask = enemyBitMask
        laserSprite1?.physicsBody?.contactTestBitMask = enemyBitMask
        laserSprite2?.physicsBody?.contactTestBitMask = enemyBitMask
        laserSprite4?.physicsBody?.contactTestBitMask = enemyBitMask
        laserSprite5?.physicsBody?.contactTestBitMask = enemyBitMask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     shootProjectile
     function: call a shoot action by adding the sprites, animating then deleting them on the GameScene.
    */
    override func shootProjectile(parent2: SKNode) {
        
        let deleteProjectile = SKAction.removeFromParent()
        
        //1st laserSprite
        laserSprite1?.position = CGPoint(x: self.position.x, y: self.position.y-20)
        parent2.addChild(laserSprite1!)
        laserSprite1?.zRotation = CGFloat(25.degreesToRadian)
        let moveProjectile1 = SKAction.move(to: CGPoint(x: -100, y: (laserSprite1?.position.x)!/cos((laserSprite1?.zRotation)!) * 3), duration: 0.4)
        let sequence1 = SKAction.sequence([moveProjectile1, deleteProjectile])
        laserSprite1?.run(sequence1)
        
        //2nd laserSprite
        laserSprite2?.position = CGPoint(x: self.position.x, y: self.position.y-20)
        parent2.addChild(laserSprite2!)
        laserSprite2?.zRotation = CGFloat((13).degreesToRadian)
        let moveProjectile2 = SKAction.move(to: CGPoint(x: -100, y: (laserSprite2?.position.x)!/cos((laserSprite2?.zRotation)!) * 5.5), duration: 0.35)
        let sequence2 = SKAction.sequence([moveProjectile2, deleteProjectile])
        laserSprite2?.run(sequence2)
        
        //3rd laserSprite
        self.position = CGPoint(x: self.position.x, y: self.position.y-20)
        parent2.addChild(self)
        let finalPos = self.parent?.frame.height
        let moveAction = SKAction.moveBy(x: 0, y: finalPos!+200.0, duration: 0.7)
        moveAction.timingMode = SKActionTimingMode.easeInEaseOut
        self.run(moveAction)
        
        //4th laserSprite
        laserSprite4?.position = CGPoint(x: self.position.x, y: self.position.y-20)
        parent2.addChild(laserSprite4!)
        laserSprite4?.zRotation = CGFloat((-13).degreesToRadian)
        let moveProjectile3 = SKAction.move(to: CGPoint(
            x: (parent?.frame.width)!+100, y: (((parent?.frame.width)!)-(laserSprite4?.position.x)!)/cos((laserSprite4?.zRotation)!) * 5.5), duration: 0.35)
        let sequence3 = SKAction.sequence([moveProjectile3, deleteProjectile])
        laserSprite4?.run(sequence3)
        
        //5th laserSprite
        laserSprite5?.position = CGPoint(x: self.position.x, y: self.position.y-20)
        parent2.addChild(laserSprite5!)
        laserSprite5?.zRotation = CGFloat((-25).degreesToRadian)
        let moveProjectile4 = SKAction.move(to: CGPoint(
            x: (parent?.frame.width)!+100, y: (((parent?.frame.width)!)-(laserSprite5?.position.x)!)/cos((laserSprite5?.zRotation)!) * 3),  duration: 0.4)
        let sequence4 = SKAction.sequence([moveProjectile4, deleteProjectile])
        laserSprite5?.run(sequence4)
    }
    
}

