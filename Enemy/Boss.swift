//
//  Boss.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit


class Boss : Enemy {
    
    override class func SpriteName() -> String {
        return "boss"
    }
    
    /*
     init
     input: the enemy's attributes except for timer
     function: creates a boss and his associated node corresponding to the given inputs
    */
    override init(shipName:String, image:String, canFire:Bool, hitPoint: Int, score: Int, shipSpeed: CGFloat, fireRate: Double){
        super.init(shipName: shipName, image: image, canFire: canFire, hitPoint: hitPoint, score: score, shipSpeed: shipSpeed, fireRate: fireRate)
        self.name = Boss.SpriteName()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     move
     function: Continually moves the boss across the x axis of the screen
    */
    func move(){
        var random = arc4random_uniform(UInt32((self.parent?.frame.maxX)!))
        if (random > Int((self.parent?.frame.maxX)!)) { random =  UInt32((self.parent?.frame.maxX)!-self.frame.width/2) }
        if (random < Int((self.parent?.frame.minX)!)) { random =  UInt32((self.parent?.frame.maxX)!+self.frame.width/2) }
            let moveAction = SKAction.move(to: CGPoint( x: CGFloat(random), y: self.position.y), duration: TimeInterval(self.shipSpeed))
        let forever = SKAction.repeatForever(SKAction.sequence([moveAction]))
        self.run(forever)

    }
    
    /*
     rotate
     func: Rotating action of a node
     */
    func rotate(){
        let rotate1 = SKAction.rotate(byAngle: (-0.2275), duration: 1.5)
        let rotate2 = SKAction.rotate(byAngle: (0.45), duration: 3)
        let rotateForever = SKAction.repeatForever(SKAction.sequence([rotate1, rotate2, rotate1]))
        self.run(rotateForever)
    }
    
    /*
     fireGun
     function: creates a laser at the enemy's position and tells it to move forward
    */ 
    @objc override func fireGun() {
        if (self.parent != nil) {
            // only fire if sprite is still an enemy, i.e. not when explodiing
            let shot = EnemyShot(parentNode: self.parent!, pos: CGPoint(x: self.position.x, y: self.position.y-self.size.height))
            shot.shoot(CGPoint(x: self.position.x, y: 0 - (self.parent?.frame.maxY)!) , ship: self)
        }
    }
    
}
