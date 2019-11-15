//
//  BonusSpawner.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class BonusSpawner: NSObject {
    
    var parentNode:SKNode?
    let images = ["health","laserBonus","shotgunBonus"]     //Table of bonuses that can be spawned

    /*
     init
     input: parent: It's parent (Here GameScene)
     Func: Initializes when BonusSpawner is called
     */
     init(parent:SKNode) {
        parentNode = parent
    }
    
    /*
     spawnNewBonus
     input: targetPoint: CGPoint location of the player ship
     function: Spawns a bonus and moves it towards the player ship's location
    */
    func spawnNewBonus(_ targetPoint: CGPoint) {
        let imgIdx = Int(arc4random_uniform(UInt32(images.count)))  //Picks out the random bonus to spawn
        let imageName = images[imgIdx]
        var bonus: Bonus?
        
        if (imageName == "health"){             //If the imageName corresponds to health it spawsns it.
            bonus = BonusHealth(imageName: imageName)
        }
        else if(imageName == "laserBonus"){     //If the imageName corresponds to laserBonus it spawsns it.
            bonus = BonusLaser(imageName: "laserBonus")
        }
        else if(imageName == "shotgunBonus"){   //If the imageName corresponds to shotgunBonus it spawsns it.
            bonus = BonusShotgun(imageName: "shotgunBonus")
        }
    
        parentNode?.addChild(bonus!)
        let startPos = CGPoint(x: CGFloat(50)+(bonus?.size.width)!/2, y: (bonus?.parent!.frame.height)!+(bonus?.size.height)!)
        bonus?.position = startPos
        let res = GetFinalPosAndAngle(startPos, targetPoint: targetPoint)
        let moveAction = SKAction.move(to: res.finalPos, duration: 4)
        let delete = SKAction.removeFromParent()
        bonus?.finalPos = res.finalPos
        bonus?.run(SKAction.sequence([moveAction, delete]))
    }
    
    /*
     GetFinalPosAndAngle
     input: startPos: where the bonus is spawn
            targetPoint: where the bonus should go (Player ship's position
     returns: Direction to where the bonus will go in a certain angle (towards the player's ship)
     function: Adjust the direction of where the spawned bonus will go.
    */
    func GetFinalPosAndAngle(_ startPos: CGPoint, targetPoint: CGPoint) -> (finalPos: CGPoint, arc: CGFloat) {
        let dx = targetPoint.x-startPos.x
        let dy = startPos.y-targetPoint.y
        let ratio = (dx)/(dy)
        let x = startPos.x + ratio*(startPos.y)
        let angle = atan2(dx,dy)
        
        return (CGPoint(x: x, y: -100), angle)
    }
}
