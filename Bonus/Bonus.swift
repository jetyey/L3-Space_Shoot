//
//  Bonus.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class Bonus : SKSpriteNode {
    
    var finalPos: CGPoint = CGPoint(x: 0, y: 0)
    
    /*
     SpriteName
     function: assigns the name of the sprite node
    */
    class func SpriteName() -> String {
        return "bonus"
    }
    
    
    init(imageName:String) {
        
        let spTexture = SKTexture(imageNamed: imageName)
        super.init(texture: spTexture, color: UIColor.clear, size: spTexture.size())
        self.name = Bonus.SpriteName()
        
        self.physicsBody = SKPhysicsBody(texture: spTexture, size: self.size)
        self.physicsBody?.categoryBitMask = bonusBitMask
        self.physicsBody?.collisionBitMask = playerBitMask
        self.physicsBody?.contactTestBitMask = playerBitMask
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.allowsRotation = true
        rotateBonus()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    rotationBonus
    function: rotates the sprite node on its anchor
    */
    func rotateBonus() {
        let oneRevolution: SKAction = SKAction.rotate(byAngle: CGFloat.pi/4, duration: 1)
        let repeatRotation:SKAction = SKAction.repeatForever(oneRevolution)
        self.run(repeatRotation)
    }
    
    
}
