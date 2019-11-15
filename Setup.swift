//
//  Setup.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class Setup{
    
    var scene: GameScene!                           //class GameScene
    static var gameState: Bool = true               //State of the game (paused or not paused)
    static var shipName: String?                    //Player ship's choice in the selection
    static var score: Int?                          //Determines the score to reach to win
    static var image: String?                       //Background image to use
    static var lives: Int?                          //How many lives to play in the level
    static var spawnBonusDelay: Int?                //How much time it takes to spawn another bonus in sec
    
    //Planet unlocker
    var planet2State = UserDefaults.standard.bool(forKey: "planet2State")           //Variable to stock wether the 2nd planet is locked or unlocked
    var planet3State = UserDefaults.standard.bool(forKey: "planet3State")           //Variable to stock wether the 3rd planet is locked or unlocked
    var planet4State = UserDefaults.standard.bool(forKey: "planet4State")           //Variable to stock wether the 4th planet is locked or unlocked
    var planet5State = UserDefaults.standard.bool(forKey: "planet5State")           //Variable to stock wether the 5th planet is locked or unlocked
    var planet6State = UserDefaults.standard.bool(forKey: "planet6State")           //Variable to stock wether the thd planet is locked or unlocked
    static var planetNumber: Int?                   //The planet number being played in the gamescene
    static var planet1Unlocked: Bool = true
    static var planet2Unlocked: Bool = false        //True if planet 2 is unlocked
    static var planet3Unlocked: Bool = false        //True if planet 3 is unlocked
    static var planet4Unlocked: Bool = false        //True if planet 4 is unlocked
    static var planet5Unlocked: Bool = false        //True if planet 5 is unlocked
    static var planet6Unlocked: Bool = false        //True if planet 6 is unlocked
    
    //Adjusting Difficulty
    static var difficultyLevel: Int?                //Determines how hard the difficulty level is in mission mode
    static var arcadeDifficuty: String?             //Determines how hard the difficulty level is in arcade mode
    
    //Call Boss
    static var callBoss: Bool?                      //True if boss is called on scene
    static var spawnBoss: Bool?                     //True if boss will show up in that planet
    var numberOfBossKilled: Int?                    //counts how many parts of the boss is killed
    
    //Initializer
    init(scene: GameScene) {
        self.scene = scene
    }
    
    /*
     setupShip
     func: setup PlayerShip in GameScene
    */
    func setupShip() -> PlayerShip{
        return PlayerShip(initialYPos: 25, image: Setup.shipName!, parent: self.scene, pos: CGPoint(x: self.scene.frame.midX, y: 25))
    }
    
    /*
     setupbackground
     func: setup Background in GameScene
    */
    func setupbackground() -> Background{
        return Background(parent: self.scene, image: Setup.image!)
    }
    
    /*
     setupHud
     func: setup hud in GameScene
    */
    func setupHud(){
        self.scene.hud = Hud(lives1: Setup.lives!)
        self.scene.hud?.showHud(parent: self.scene)
    }
    
    /*
     setupPauseButton
     func: Setup pause button
    */
    func setupPauseButton(){
        let pauseButtonTexture = SKTexture(imageNamed: "pauseButton")
        scene.pauseButton = SKSpriteNode(texture: pauseButtonTexture)
        scene.pauseButton.position = CGPoint(x: scene.frame.width*0.95, y: scene.frame.height*0.97)
        scene.pauseButton.zPosition = 100
        scene.pauseButton.size = CGSize(width: 25, height: 25)
        scene.addChild(scene.pauseButton)
    }
    
    /*
     difficultySpeed
     func: setup how fast the difficulty in a level increase
    */
    func difficultySpeed() -> Int {
        if Setup.difficultyLevel == 1 {
            Setup.arcadeDifficuty = "Lvl.1"         //Stores the difficulty level of the game. To be used in highscoreScene
            return 1
        }
        else if Setup.difficultyLevel == 2 {
            Setup.arcadeDifficuty = "Lvl.2"         //Stores the difficulty level of the game. To be used in highscoreScene
            return 5
        }
        else if Setup.difficultyLevel == 3 {
            Setup.arcadeDifficuty = "Lvl.3"         //Stores the difficulty level of the game. To be used in highscoreScene
            return 7
        }
        else if Setup.difficultyLevel == 4 {
            Setup.arcadeDifficuty = "Lvl.4"         //Stores the difficulty level of the game. To be used in highscoreScene
            return 10
        }
        else if Setup.difficultyLevel == 5 {
            Setup.arcadeDifficuty = "Lvl.5"         //Stores the difficulty level of the game. To be used in highscoreScene
            return 15
        }
        else {
            return 0
        }
    }
    
    /*
     setupbackground
     func: spawns the boss in GameScene
    */
    func callBossToScene() {
        if Setup.spawnBoss! && Setup.callBoss!{
            scene.enemySpawner?.spawnBoss(world: scene)
        }
    }
    
}
