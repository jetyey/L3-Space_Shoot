//
//  Background.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class Background: SKSpriteNode{

    var parentNode: SKNode?
    var image: String
    
    
    init(parent: SKNode, image: String){
        parentNode = parent
        self.image = image
        let bgTexture = SKTexture(imageNamed: image)
        super.init(texture: bgTexture, color: UIColor.clear, size: parentNode!.frame.size)
        self.position = CGPoint(x: (parentNode?.frame.midX)!, y: (parentNode?.frame.midY)!)
        self.zPosition = -1
        parentNode?.addChild(self)
        self.name = "background"


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollBackground(speed: CGFloat){
        self.position.y -= speed
        if self.frame.maxY == 0 {
            self.position.y = (parentNode?.frame.maxY)! + (parentNode?.frame.maxY)!/2
        }
        
    }
    
}
