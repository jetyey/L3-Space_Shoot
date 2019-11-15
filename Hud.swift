//
//  Hud.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class Hud {
    
    var score: Int                                //player's score
    var lives: Int                                //player's lives
    var parentNode:SKNode?                        //scene where the informations will be displayed
    var position:CGPoint = CGPoint(x: 0, y: 0)    //position of the information on the screen
    
    let scoreLabel = SKLabelNode(fontNamed: "moonhouse")
    let livesLabel = SKLabelNode(fontNamed: "moonhouse")
    
    /*
     init
     input: lives1: the player's starting life count
     function: set the starting values for the player's score and life count
     */
    init(lives1: Int) {
        score = 0
        lives = lives1
    }
    
    /*
     showHud
     input: parent: the parent scene where the lives and score will be displayed
     function: creates the appropriates labels for lives and score and add them to the parent scene
     */
    func showHud(parent: SKNode) -> Void{
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 18
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: (parent.frame.width)*0.10, y: (parent.frame.height)*0.9)
        scoreLabel.zPosition = 200
        parent.addChild(scoreLabel)
        
        livesLabel.text = "Lives: \(lives)"
        livesLabel.fontSize = 18
        livesLabel.fontColor = SKColor.white
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        livesLabel.position = CGPoint(x: (parent.frame.width)*0.85, y: (parent.frame.height)*0.9)
        livesLabel.zPosition = 200
        parent.addChild(livesLabel)
    }
    
    /*
     updateScoreLabel
     input: points: the number by which the player's score will increase
     function: update the player's score by adding the given number to it
     */
    func updateScoreLabel(point: Int) ->Void{
        score+=point
        scoreLabel.text = "Score: \(score)"
        /*
         if ((score % 10) == 0){
         let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
         let scaleDown = SKAction.scale(to: 1, duration: 0.2)
         let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
         scoreLabel.run(scaleSequence)
         }
         */
    }
    
    /*
     getScore
     func: When called will get the current score
     */
    func getScore() -> Int{
        return self.score
    }
    
    /*
     updateLivesLabel
     function: decreases the player's number of lives by one
     */
    func updateLivesLabel() ->Void{
        lives-=1
        livesLabel.text = "Lives: \(lives)"
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
    }
    
    /*
     updateLivesBonusLabel
     function: increase the player's number of lives by one
     */
    func updateLivesBonusLabel() ->Void{
        lives+=1
        NSLog("touché!")
        livesLabel.text = "Lives: \(lives)"
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
    }
}
