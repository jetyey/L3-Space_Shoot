//
//  EnemyShot.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class EnemyShot {
    
    var laserSprite = SKSpriteNode(imageNamed: "projectile")    //the image to use as a sprite for the shot
    var parent:SKNode?                                          //the parent scene were the shot will be added
    var position:CGPoint = CGPoint(x: 0, y: 0)                  //coordinates of the shot
    
    /*
     SpriteName
     output: the string "enemyshot"
     function: return the string "enemyshot"
    */
    class func SpriteName() -> String {
        return "enemyshot"
    }
    
    /*
     init
     input: parentNode: the scene where the shot will be added
     pos: position were the shot will spawn on the parent scene
     function: creates a shot and his associated node corresponding to the given parameters
     */
    init(parentNode:SKNode, pos:CGPoint) {
        parent = parentNode
        position = pos
        
        //associate the (already) chosen image to the spriteNode
        let spTexture = SKTexture(imageNamed: "projectile")
        laserSprite = SKSpriteNode(texture: spTexture)
        
        //defines the different properties of the shot's spriteNode
        laserSprite.physicsBody = SKPhysicsBody(texture: spTexture, size: laserSprite.size)
        laserSprite.physicsBody?.isDynamic = true
        laserSprite.physicsBody?.usesPreciseCollisionDetection = true
        laserSprite.physicsBody?.allowsRotation = false
        laserSprite.name = EnemyShot.SpriteName()
        laserSprite.zPosition = 1
        laserSprite.physicsBody?.categoryBitMask = enemyShotBitMask
        laserSprite.physicsBody?.collisionBitMask = playerBitMask
        laserSprite.physicsBody?.contactTestBitMask = playerBitMask
    }
    
    /*
     shoot
     input: finalPos: the final position where the shot will direct itself
     ship: the enemy ship that spawns the shot
     function: the given enemy ship shoots a projectile to the designated coordinates
     */
    func shoot(_ finalPos:CGPoint, ship: Enemy) -> Void {
        laserSprite.position = ship.position    //spawns the shot at the enemy's position
        parent?.addChild(laserSprite)
        let moveAction = SKAction.move(to: finalPos, duration: 0.5)    //tells the shot to move to the final position given in 0.5 seconds
        let arc = atan2(finalPos.x-position.x, position.y-finalPos.y)    //calculate the arc to give to the shot for it to be aligned on the axis between the enemy's position and the final position
        laserSprite.zRotation = arc
        moveAction.timingMode = SKActionTimingMode.easeInEaseOut
        laserSprite.run(moveAction)
        let deleteProjectile = SKAction.removeFromParent()    //delete the projectile once its course is complete
        laserSprite.run(SKAction.sequence([moveAction, deleteProjectile]))
    }
    
}
