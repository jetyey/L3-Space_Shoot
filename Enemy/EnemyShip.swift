//
//  Enemy.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class Enemy : SKSpriteNode {
    
    var shipName: String
    var image: String
    var canFireLaser: Bool
    var timer = Timer()
    var hitPoint: Int
    var score: Int
    var shipSpeed: CGFloat
    var fireRate: Double
    
    class func SpriteName() -> String {
        return "enemy"
    }
    
    var finalPos: CGPoint = CGPoint(x: 0, y: 0)
    
    init(shipName:String, image:String, canFire:Bool, hitPoint: Int, score: Int, shipSpeed: CGFloat, fireRate: Double) {
        self.shipName = shipName
        self.image = image
        self.canFireLaser = canFire
        self.hitPoint = hitPoint
        self.score = score
        self.shipSpeed = shipSpeed
        self.fireRate = fireRate
        let shipTexture = SKTexture(imageNamed: image)
        super.init(texture: shipTexture, color: UIColor.clear, size: shipTexture.size())
        self.name = Enemy.SpriteName()
        self.zPosition = 2

        self.physicsBody = SKPhysicsBody(texture: shipTexture, size: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.categoryBitMask = enemyBitMask
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = laserShotBitMask
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.allowsRotation = false
 
        if (canFire) {
            timer = Timer.scheduledTimer(timeInterval: self.fireRate, target: self, selector: #selector(Enemy.fireGun), userInfo: nil, repeats: true)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Func that let's enemies shoot
    @objc func fireGun() {
        if (self.parent != nil) {
            // only fire if sprite is still an enemy, i.e. not when explodiing
            let shot = EnemyShot(parentNode: self.parent!, pos:CGPoint(x: self.position.x,y: self.position.y-self.size.height))
            shot.shoot(finalPos, ship: self)
        }
    }
    
}
