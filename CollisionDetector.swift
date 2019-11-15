//
// CollisionDetector.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class CollisionDetector : NSObject, SKPhysicsContactDelegate {
    
    var enemyHitHandler : EnemyHitHandler?    //the function to call if an ennemy is destroyed
    var playerHitHandler : PlayerHitHandler?  //the function to call if the player's ship is hit by an enemy's ship or a enemy's projectile
    var bonusHitHandler : BonusHitHandler?    //the function to call if the player touched a bonus
    
    /*
     init
     input: g: the enemyHitHandler
     e: the PlayerHitHandler
     b: the bonusHitHandler
     function: initializes the CollisionDetector with the given functions as its parameters
    */
    init(g:@escaping EnemyHitHandler,e:@escaping PlayerHitHandler, b:@escaping BonusHitHandler) {
        enemyHitHandler = g
        playerHitHandler = e
        bonusHitHandler = b
    }
    
    /*
     didBegin
     input: contact
     function: initializes the CollisionDetector with the given functions as its parameters
    */
    func didBegin(_ contact: SKPhysicsContact) {
        
        switch(contact.bodyA.categoryBitMask + contact.bodyB.categoryBitMask){
            
        case enemyBitMask + laserShotBitMask: //enemy hit by player's projectile
            let pulsedRed = SKAction.sequence([    //color the ennemy'sprite in red for a short duration
                SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.1),
                SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.1),
                ])
            if let enemy = contact.bodyA.node as? Enemy{    // cast as an Enemy class object
                if let shot = contact.bodyB.node as? Projectile {
                    if (shot.name != "touche"){    //check the projectile's name to be sure that it didn't already hit the enemy
                        contact.bodyB.node?.removeFromParent()
                        enemy.run(pulsedRed)
                        enemy.hitPoint-=1
                        shot.name = "touche"    //modify the projectile's name once it hit the enemy
                        if (enemy.hitPoint == 0){
                            enemyHitHandler?(contact.bodyA.node!, contact.bodyB.node!, enemy.score)
                        }
                    }
                }
            }
            break;
            
        case playerBitMask + enemyShotBitMask:    //player's ship hit by an enemy projectile
            playerHitHandler?(contact.bodyA.node!, contact.bodyB.node!)
            break;
            
        case enemyBitMask + playerBitMask:    //player's ship make contact an enemy ship
            playerHitHandler?(contact.bodyA.node!, contact.bodyB.node!)
            break;
            
        case playerBitMask + bonusBitMask:    //player's ship make contact with a bonus
            if let bonus = contact.bodyB.node as? Bonus{
                if (bonus.name != "touche"){                                            //Condition to make sure the bonus is read only once
                    contact.bodyB.node?.removeFromParent()                              //Removes the bonus in collision with the player
                    bonusHitHandler?(contact.bodyA.node!, contact.bodyB.node!)          //Methode to pass the results to the GameScene
                    bonus.name = "touche"                                               //Changes the name to ensure the node is read only once
                }
            }
            
            break;
            
        default:
            break;
        }
        
    }
    
}
