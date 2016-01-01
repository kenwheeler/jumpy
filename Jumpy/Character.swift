//
//  Character.swift
//  Jumpy
//
//  Created by Ken Wheeler on 12/30/15.
//  Copyright © 2015 Ken Wheeler. All rights reserved.
//

import SpriteKit

class Character : SKSpriteNode {
    init(view: SKView) {
        let texture = SKTexture(imageNamed: "JohnCharacter")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        self.setScale(0.15)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPointMake(view.frame.size.width / 3, self.size.height)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody!.categoryBitMask = characterCategory
        self.lightingBitMask = 1
        self.physicsBody!.collisionBitMask = floorCategory
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.restitution = 0.0
        
        let atlas = SKTextureAtlas(named:"sprite")
        let f1 = atlas.textureNamed("sprite-walk1.png")
        let f2 = atlas.textureNamed("sprite-walk2.png")
        let f3 = atlas.textureNamed("sprite-walk3.png")
        let f4 = atlas.textureNamed("sprite-walk4.png")
        let spriteWalkTextures : NSArray = [f1,f2,f3,f4]
        
        
        let walkAnimation : SKAction = SKAction.animateWithTextures(spriteWalkTextures as! [SKTexture], timePerFrame: 0.1)
        let walking = SKAction.repeatActionForever(walkAnimation)
        self.runAction(walking)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}