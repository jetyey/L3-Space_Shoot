//
//  GameViewController.swift
// Copyright © 2018 L3AA2. All rights reserved.

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MenuScene(size: CGSize(width: 400, height: 720))
            if let skView = self.view as! SKView? {
                scene.scaleMode = .aspectFill
                //skView.showsFPS = true
                //skView.showsNodeCount = true
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                skView.presentScene(scene)
                scene.scaleMode = SKSceneScaleMode.aspectFit
                scene.backgroundColor = UIColor.black
                //skView.showsPhysics = true
        }
    
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}











