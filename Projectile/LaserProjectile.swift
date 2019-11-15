//
//  LaserProjectile.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class LaserProjectile : Projectile {
    
    /*
     SpriteName
     function: overrides the assigned name of the sprite node
    */
    override class func SpriteName() -> String {
        return "laser"
    }
    
    /*
     shootProjectile
     function: call a shoot action by adding the sprite, animating then deleting it on the GameScene.
     */
    override func shootProjectile(parent2: SKNode) -> Void{
        self.position = CGPoint(x: self.position.x, y: self.position.y+(self.size.height)/2 - 20)
        parent2.addChild(self)
        self.name = LaserProjectile.SpriteName()
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        let explosionSequence = SKAction.sequence([ fadeOut, delete])
        
        self.run(explosionSequence)
    }
    
}
