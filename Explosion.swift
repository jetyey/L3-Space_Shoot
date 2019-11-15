//
//  Explosion.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit


class Explosion: SKNode{

    func spawnExplosion(parent: SKNode, spawnPosition: CGPoint){
    
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = spawnPosition
        explosion.zPosition = 19
        explosion.setScale(0)
        parent.addChild(explosion)
        
        var play: SKAction?
        if UserDefaults().integer(forKey: "music") == 1 {
            play = SKAction.playSoundFileNamed("nothing", waitForCompletion: false)
        }
        else{
            play = SKAction.playSoundFileNamed("Explosion.wav", waitForCompletion: false)
        }
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
    
        let explosionSequence = SKAction.sequence([play!,scaleIn, fadeOut, delete])
    
        explosion.run(explosionSequence)
    }
}
