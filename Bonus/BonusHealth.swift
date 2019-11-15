//
//  BonusHealth.swift
//  Copyright © 2018 L3AA2. All rights reserved.

import Foundation
import SpriteKit

class BonusHealth : Bonus {
    
    /*
     SpriteName
     function: overrides the assigned name of the sprite node
    */
    override class func SpriteName() -> String {
        return "health"
    }
    
    
    override init(imageName:String) {
        super.init(imageName: "health")
        self.name = BonusHealth.SpriteName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
