//
//  GameScene.swift
//  Jumpy
//
//  Created by Ken Wheeler on 12/27/15.
//  Copyright (c) 2015 Ken Wheeler. All rights reserved.
//

import SpriteKit
import AudioToolbox

let characterCategory : UInt32 = 1;
let stageCategory : UInt32 = 2;
let floorCategory : UInt32 = 3;

class GameScene: SKScene {
    
    var character =  SKSpriteNode()
    var floor = SKNode()
    var background = SKSpriteNode()
    var backgroundMusic: SKAudioNode!
    var lightSprite: SKSpriteNode?
    var ambientColor: UIColor?
    
    func speed(v: CGVector) -> Float {
        return sqrtf(Float(v.dx)*Float(v.dx)+Float(v.dy)*Float(v.dy))
    }
    
    func createCharacter() {
        character = Character(view: self.view!)
        self.addChild(character)
    }
    
    func createFloor() {
        let spaces = [
            (20, 42),
            (46, 48),
            (50, 52),
            (54, 56),
            (58, 60)
        ];
        for i in 0...100 {
            let filtered = spaces.filter({i >= $0.0 && i < $0.1})
            if filtered.count == 0 {
                let tile = Floor(index: i)
                floor.addChild(tile)
            }
        }
        floor.position = CGPointMake(0,0)
        self.addChild(floor)
    }
    
    func createPlatforms() {
        let regions = [
            (24, 250),
            (28, 250),
            (34, 200),
            (36, 200)
        ];
        for i in 0...100 {
            let filtered = regions.filter({$0.0 == i});
            if filtered.count > 0 {
                let region = Platform(index: i, yOffset: filtered[0].1, view: self.view!)
                floor.addChild(region)
            }
        }
    }
    
    func createSkyline() {
        background = SKSpriteNode(imageNamed: "Background");
        background.setScale(0.9)
        background.zPosition = -1.0
        background.anchorPoint = CGPointMake(0, 0.0)
        background.position = CGPointMake(0,0)
        background.lightingBitMask = 1
        background.blendMode = SKBlendMode.Alpha
        self.addChild(background);
    }
    
    func createLighting() {
        let light = SKLightNode();
        light.position = CGPointMake(0,600)
        light.falloff = 1
        light.ambientColor = ambientColor!
        light.lightColor = UIColor.whiteColor()
        
        //character.addChild(light)
    }
    
    func setupGame() {
        createCharacter()
        createFloor()
        createPlatforms()
        createSkyline()
        createLighting()
    }
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 0.55, green: 0.49, blue: 0.45, alpha: 1.0)
        backgroundMusic = SKAudioNode(fileNamed: "background.wav")
        addChild(backgroundMusic)
        ambientColor = UIColor.darkGrayColor()
        setupGame()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ( speed(character.physicsBody!.velocity ) < 0.5) {
            if let soundURL = NSBundle.mainBundle().URLForResource("jump", withExtension: "wav") {
                var mySound: SystemSoundID = 0
                AudioServicesCreateSystemSoundID(soundURL, &mySound)
                AudioServicesPlaySystemSound(mySound);
            }
            character.physicsBody!.applyImpulse(CGVectorMake(0, 45))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (CGRectContainsPoint(self.frame, character.position) == false) {
            let scene = GameScene()
            scene.scaleMode = .AspectFill
            scene.size = self.view!.bounds.size
            self.view!.presentScene(scene);
        }
        floor.position.x-=3
        background.position.x-=0.1
    }
}
