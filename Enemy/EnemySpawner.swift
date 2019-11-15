//
//  EnemySpawner.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit
import Darwin

class EnemySpawner: NSObject {
    
    var parentNode: SKNode?        //the scene in which the ennemies/the boss will spawn
    var enemyShip: Enemy?        //the enemy to spawn
    var boss: Boss?     //the Boss to spawn
    
    init(parent:SKNode) {
        parentNode = parent
    }
    
    /*
     spawnNewEnemy
     input: startPoint: coordinates where the enemy will spawn
     targetPoint: coordinates where the enemy will end its course
     enemyType: the type of enemy spawned
     function: spawns an enemy of the chosen type at the specified startpoint
     */
    func spawnNewEnemy(startPoint: CGPoint, targetPoint:CGPoint, enemyType: Int) {
        
        if (enemyType == 1){    // basic type of enemy
            enemyShip = Enemy(shipName: "Fodder", image: "alien1", canFire: true, hitPoint: 2, score: 2, shipSpeed: 3, fireRate: 1)
            enemyShip?.setScale(0.7)
        }
        else if (enemyType == 2){   // quick and small enemy that cannot shoot
            enemyShip = Enemy(shipName: "torpedo", image: "alien2", canFire: false, hitPoint: 1, score: 1, shipSpeed: 2, fireRate: 0)
            enemyShip?.setScale(0.5)
        }
        else  if (enemyType == 4){    // basic type of enemy
            enemyShip = Enemy(shipName: "Fodder", image: "alien1", canFire: false, hitPoint: 2, score: 2, shipSpeed: 3, fireRate: 0)
            enemyShip?.setScale(0.7)
        }
        else if (enemyType == 3){   // slow, big and tough enemy
            enemyShip = Enemy(shipName: "Destroyale", image: "alien3", canFire: true, hitPoint: 5, score: 3, shipSpeed: 5, fireRate: 1)
            enemyShip?.setScale(1.5)
            
        }
        
        parentNode?.addChild(enemyShip!)
        
        enemyShip?.position = startPoint
        let speed = enemyShip?.shipSpeed
        let res = GetFinalPosAndAngle(startPoint,targetPoint: targetPoint)
        let moveAction = SKAction.move(to: res.finalPos, duration: TimeInterval(speed!))
        enemyShip?.finalPos = res.finalPos
        enemyShip?.run(moveAction)
    }
    
    
    /*
     spawnBoss
     input: world: Scene where the boss will spawn
     function: spawns the boss in the parentNode scene just out of the upper border of the screen then make it moves into the screen and moves laterally until it is destroyed
     */
    func spawnBoss(world: SKScene){
        
        boss = Boss(shipName: "body", image: "boss", canFire: true, hitPoint: 30, score: 20, shipSpeed: 4, fireRate: 3.5)  //create the body of the boss
        boss?.position = CGPoint(x: (parentNode?.frame.midX)!, y: (parentNode?.frame.height)!+(boss?.frame.height)! )
        boss?.physicsBody?.categoryBitMask = 0
        boss?.physicsBody?.collisionBitMask = 0
        boss?.physicsBody?.contactTestBitMask = 0
        parentNode?.addChild(boss!)
        
        let range = SKRange(constantValue: 60)                         //Limits how far a node can detach from its jointFixed body
        let constraint = SKConstraint.distance(range, to: boss!)       //Constraints it to a node
        
        let turret1 = Boss(shipName: "turret", image: "leftTurret", canFire: true, hitPoint: 10, score: 5, shipSpeed: 0, fireRate: 2)  //create the first turret of the boss
        turret1.zPosition = 3
        boss?.addChild(turret1)                //add the first turret to the left side of the boss' body
        turret1.constraints = [constraint]
        turret1.position = CGPoint(x: -60 , y: 0)
        
        let turret2 = Boss(shipName: "turret", image: "rigthTurret", canFire: true, hitPoint: 10, score: 5, shipSpeed: 0, fireRate: 2)  //create the second turret of the boss
        turret2.zPosition = 3
        boss?.addChild(turret2)                //add the second turret to the right side of the boss' body
        turret2.constraints = [constraint]
        turret2.position = CGPoint(x: 60 , y: 0)
        
        let core = Boss(shipName: "core", image: "core", canFire: false, hitPoint: 20, score: 10, shipSpeed: 0, fireRate: 0)        //create the core of the boss
        core.zPosition = 3
        boss?.addChild(core)        //add the core to the center of the boss' body
        core.position = CGPoint(x: 0, y: 15)
        
        let myJoint = SKPhysicsJointFixed.joint(withBodyA: (boss?.physicsBody!)!, bodyB: turret1.physicsBody!, anchor: (boss?.position)!)
        world.scene?.physicsWorld.add(myJoint)                //fix the first turret to the left side of the boss' body via a joint
        
        let myJoint2 = SKPhysicsJointFixed.joint(withBodyA: (boss?.physicsBody!)!, bodyB: turret2.physicsBody!, anchor: (boss?.position)!)
        world.scene?.physicsWorld.add(myJoint2)                //fix the second turret to the right side of the boss' body via a joint
        
        let myJoint3 = SKPhysicsJointFixed.joint(withBodyA: (boss?.physicsBody!)!, bodyB: core.physicsBody!, anchor: (boss?.position)!)
        world.scene?.physicsWorld.add(myJoint3)                //fix the core to the center of the boss' body via a joint
        
        // the boss moves unto the screen
        let appear = SKAction.move(to: CGPoint(x: (parentNode?.frame.midX)!, y: (parentNode?.frame.height)!-(boss?.size.height)!/2), duration: TimeInterval(3))
        let appearAfter = SKAction.run {
            self.boss?.move()    //the boss moves normally across the X axis of the screen
        }
        let moving = SKAction.repeatForever(SKAction.sequence([appear, appearAfter]))    //the boss only moves normally after appearing on the screen
        boss?.run(moving)
        turret1.rotate()
        turret2.rotate()
    }
    
    /*
     GetFinalPosAndAngle
     input: startPos: starting position of the ship
     targetPoint: position where the ship will end its course on the screen
     output: finalPos: position where the ship will end its course
     arc: angle to give to the ship for it to go from the startPos to the targetPoint
     function: calculates the ship's arc given his starting and ending position
     */
    func GetFinalPosAndAngle(_ startPos:CGPoint, targetPoint:CGPoint) -> (finalPos:CGPoint, arc:CGFloat) {
        let dx = targetPoint.x-startPos.x
        let dy = startPos.y-targetPoint.y
        let ratio = (dx)/(dy)
        let x = startPos.x + ratio*(startPos.y)
        let angle = atan2(dx,dy)
        
        return (CGPoint(x: x, y: -100), angle)
    }
    
    
    /*
     spawnV
     input: x: the difficulty of the wave, changes the number of enemies spawned
     enemy: type of enemy spawned by the wave
     function: spawns a V shape wave of the chosen enemy type
     */
    func spawnV(x: Int, enemy: Int){
        if (x > 10 && x <= 30) {    // player's score is larger than 10 but smaller than 30, the wave spawns 3 enemies
            spawnNewEnemy(startPoint: CGPoint(x: parentNode!.frame.width/2, y:parentNode!.frame.height),
                          targetPoint: CGPoint(x: parentNode!.frame.width/2, y:0), enemyType: enemy)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.spawnNewEnemy(startPoint: CGPoint(x: self.parentNode!.frame.width/3, y:self.parentNode!.frame.height),
                                   targetPoint: CGPoint(x: self.parentNode!.frame.width/3, y:0), enemyType: enemy)
                self.spawnNewEnemy(startPoint: CGPoint(x: self.parentNode!.frame.width*2/3, y:self.parentNode!.frame.height),
                                   targetPoint: CGPoint(x: self.parentNode!.frame.width*2/3, y:0), enemyType: enemy)
            }
        }
        else if (x > 30) {  // player's score is larger than 30, the wave spawns 5 enemies
            spawnNewEnemy(startPoint: CGPoint(x: parentNode!.frame.width/2, y:parentNode!.frame.height),
                          targetPoint: CGPoint(x: parentNode!.frame.width/2, y:0), enemyType: enemy)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.spawnNewEnemy(startPoint: CGPoint(x: self.parentNode!.frame.width*2/6, y:self.parentNode!.frame.height),
                                   targetPoint: CGPoint(x: self.parentNode!.frame.width*2/6, y:0), enemyType: enemy)
                self.spawnNewEnemy(startPoint: CGPoint(x: self.parentNode!.frame.width*4/6, y:self.parentNode!.frame.height),
                                   targetPoint: CGPoint(x: self.parentNode!.frame.width*4/6, y:0), enemyType: enemy)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.spawnNewEnemy(startPoint: CGPoint(x: self.parentNode!.frame.width*1/6, y:self.parentNode!.frame.height),
                                       targetPoint: CGPoint(x: self.parentNode!.frame.width*1/6, y:0), enemyType: enemy)
                    self.spawnNewEnemy(startPoint: CGPoint(x: self.parentNode!.frame.width*5/6, y:self.parentNode!.frame.height),
                                       targetPoint: CGPoint(x: self.parentNode!.frame.width*5/6, y:0), enemyType: enemy)
                }
            }
        }
        else { // player's score is smaller than 11, the wave spawns 1 enemy
            spawnNewEnemy(startPoint: CGPoint(x: parentNode!.frame.width/2, y:parentNode!.frame.height),
                          targetPoint: CGPoint(x: parentNode!.frame.width/2, y:0), enemyType: 1)
        }
        
    }
    
    /*
     spawnLine
     input: x: the difficulty of the wave, changes the number of enemies spawned
     function: spawns a line of type 1 enemies at a random x coordinates
     */
    func spawnLine(x: Int){
        //determines the random coordinate
        let y = CGFloat(arc4random_uniform((UInt32((parentNode?.frame.width)!))))
        if (x > 10 && x <= 30) {    // player's score is larger than 10 but smaller than 30, the wave spawns 3 enemies
            spawnNewEnemy(startPoint: CGPoint(x: y, y:parentNode!.frame.height),
                          targetPoint: CGPoint(x: y, y:0), enemyType: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.spawnNewEnemy(startPoint: CGPoint(x: y, y:self.parentNode!.frame.height),
                                   targetPoint: CGPoint(x: y, y:0), enemyType: 1)
                self.spawnNewEnemy(startPoint: CGPoint(x: y, y:self.parentNode!.frame.height),
                                   targetPoint: CGPoint(x: y, y:0), enemyType: 1)
            }
        }
        else if (x > 30) {    // player's score is larger than 30, the wave spawns 5 enemies
            spawnNewEnemy(startPoint: CGPoint(x: y, y:parentNode!.frame.height),
                          targetPoint: CGPoint(x: y, y:0), enemyType: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.spawnNewEnemy(startPoint: CGPoint(x: y, y:self.parentNode!.frame.height),
                                   targetPoint: CGPoint(x: y, y:0), enemyType: 1)
                self.spawnNewEnemy(startPoint: CGPoint(x: y, y:self.parentNode!.frame.height),
                                   targetPoint: CGPoint(x: y, y:0), enemyType: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.spawnNewEnemy(startPoint: CGPoint(x: y, y:self.parentNode!.frame.height),
                                       targetPoint: CGPoint(x: y, y:0), enemyType: 1)
                    self.spawnNewEnemy(startPoint: CGPoint(x: y, y:self.parentNode!.frame.height),
                                       targetPoint: CGPoint(x: y, y:0), enemyType: 1)
                }
            }
        }
        else {    // player's score is smaller than 11, the wave spawns 1 enemy
            spawnNewEnemy(startPoint: CGPoint(x: y, y:parentNode!.frame.height),
                          targetPoint: CGPoint(x: y, y:0), enemyType: 1)
        }
    }
    
    /*
     spawnToPlayer
     input: x: the difficulty of the wave, changes the number of enemies spawned
     playerPos: coordinates where the enemies will move to
     enemy: type of enemy spawned by the wave
     function: spawn a wave of the chosen enemy type, the enemies will move toward the position of the player (at the moment of the spawning)
     */
    func spawnToPlayer(x: Int, playerPos: CGPoint, enemy: Int){
        if (x > 10 && x <= 30) {    // player's score is larger than 10 but smaller than 30, the wave spawns 2 enemies
            spawnNewEnemy(startPoint: CGPoint(x: parentNode!.frame.width/3, y:parentNode!.frame.height),
                          targetPoint: playerPos, enemyType: enemy)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.spawnNewEnemy(startPoint: CGPoint(x: self.parentNode!.frame.width*2/3, y:self.parentNode!.frame.height),
                                   targetPoint: playerPos, enemyType: enemy)
            }
        }
        else if (x > 30){    // player's score is larger than 30, the wave spawns 3 enemy
            spawnNewEnemy(startPoint: CGPoint(x: parentNode!.frame.width/3, y:parentNode!.frame.height),
                          targetPoint: playerPos, enemyType: enemy)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.spawnNewEnemy(startPoint: CGPoint(x: self.parentNode!.frame.width*2/3, y:self.parentNode!.frame.height),
                                   targetPoint: playerPos, enemyType: enemy)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.spawnNewEnemy(startPoint: CGPoint(x: self.parentNode!.frame.width/3, y:self.parentNode!.frame.height),
                                       targetPoint: playerPos, enemyType: enemy)
                }
            }
        }
        else {    // player's score is smaller than 11, the wave spawns 1 enemy
            spawnNewEnemy(startPoint: CGPoint(x: parentNode!.frame.width/2, y:parentNode!.frame.height),
                          targetPoint: playerPos, enemyType: enemy)
        }
    }
    
    /*
     spawnDiago
     input: x: the difficulty of the wave, changes the number of enemies spawned
     function: Spawns a wave of enemies traversing the screen diagonally
     */
    func spawnDiago(x: Int){
        //determines a random position on the X axis of the screen for the to spawn on
        let y = CGFloat(arc4random_uniform((UInt32((parentNode?.frame.width)!))))
        var z = CGPoint()
        if (y > parentNode!.frame.width/2){ // if the spawning position is on the right side of the screen then the ennemy will move toward the middle of the left border of the screen
            z = CGPoint(x: 0, y: parentNode!.frame.height/2)
        }
        else{    // if the spawning position is on the left side of the screen then the ennemy will move toward the middle of the right border of the screen
            z = CGPoint(x: parentNode!.frame.width, y: parentNode!.frame.height/2)
        }
        if (x > 10 && x <= 30) {    // player's score is larger than 10 but smaller than 30, the wave spawns 2 enemies
            spawnNewEnemy(startPoint: CGPoint(x: y, y:parentNode!.frame.height),
                          targetPoint: z , enemyType: 4)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.spawnNewEnemy(startPoint: CGPoint(x: y, y:self.parentNode!.frame.height),
                                   targetPoint: z , enemyType: 1)
            }
        }
        else if (x > 30){    // player's score is larger than 30, the wave spawns 3 enemy
            spawnNewEnemy(startPoint: CGPoint(x: y, y:parentNode!.frame.height),
                          targetPoint: z , enemyType: 4)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.spawnNewEnemy(startPoint: CGPoint(x: y, y:self.parentNode!.frame.height),
                                   targetPoint: z , enemyType: 4)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.spawnNewEnemy(startPoint: CGPoint(x: y, y:self.parentNode!.frame.height),
                                       targetPoint: z , enemyType: 4)
                }
            }
        }
        else {    // player's score is smaller than 11, the wave spawns 1 enemy
            spawnNewEnemy(startPoint: CGPoint(x: y, y:parentNode!.frame.height),
                          targetPoint: z , enemyType: 4)
        }
    }
    
    /*
     spawnWave
     input: playerPos: the position of the player's ship
     playerScore: the player's score
     function: Determines randomly the pattern of the next wave of enemies and then calls the appropriate function to spawn them on the screen
     */
    func spawnWave(playerPos: CGPoint, playerScore: Int){
        let random = Int(arc4random_uniform(5))    //determines a random number between 0, 1, 2, 3, 4
        switch(random){
        case 4:    //calls a wave in a V pattern consisting of type 1 enemies
            spawnV(x: playerScore, enemy: 1)
        case 2:    //calls a wave of type 2 enemies aiming for the player's position
            spawnToPlayer(x: playerScore, playerPos: playerPos, enemy: 2)
        case 3:    //calls a wave of type1 enemies moving diagonally across the screen
            spawnDiago(x: playerScore)
        case 1:    //calls a wave consisting of 1 type3 enemy (regardless of the player's score) aiming for the player's position
            spawnToPlayer(x: 1, playerPos: playerPos, enemy: 3)
        default:    //calls a wave consisting of a column of type1 enemies
            spawnLine(x: playerScore)
            
        }
    }
    
    /*
     removeEnemiesOutsideScreen
     function: removes the enemy once it moved off the screen if it wasn't destroyed by the player
     */
    func removeEnemiesOutsideScreen() {
        parentNode?.enumerateChildNodes(withName: "enemy") {    //calls all the enemy currently existing
            node,stop in
            let finalPosy1 = -40 //-2*(self.parentNode?.frame.height)!    //defines the coordinates after which the enemy's node is removed from the game
            let finalPosx1 = 350.0
            let finalPosx2 = -10
            
            //Erase nodes exiting to the left screen
            if (node.position.y <= CGFloat(finalPosy1)) {
                node.removeFromParent()
            }
                //Erase nodes exiting to the top screen
            else if (node.position.x >= CGFloat(finalPosx1)) {
                node.removeFromParent()
            }
                //Erase nodes exiting to the bottom screen
            else if (node.position.x <= CGFloat(finalPosx2)) {
                node.removeFromParent()
            }
        }
    }
    
}
