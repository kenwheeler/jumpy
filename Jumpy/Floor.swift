//
//  Character.swift
//  Jumpy
//
//  Created by Ken Wheeler on 12/30/15.
//  Copyright © 2015 Ken Wheeler. All rights reserved.
//

import SpriteKit

class Floor : SKSpriteNode {
    init(index: Int) {
        let texture = SKTexture(imageNamed: "Ground")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        self.setScale(0.25)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        let left = 32 * index - Int(self.size.width / 2.0)
        self.position = CGPointMake(CGFloat(left), CGFloat(self.size.height / 2.0))
        self.physicsBody!.categoryBitMask = floorCategory
        self.lightingBitMask = 1
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.dynamic = false
        self.physicsBody!.restitution = 0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}