//
//  GameViewController.swift
//  Jumpy
//
//  Created by Ken Wheeler on 12/27/15.
//  Copyright (c) 2015 Ken Wheeler. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        if(skView.scene == nil) {
            let scene = GameScene()
            scene.scaleMode = .AspectFill
            scene.size = skView.bounds.size
            
            skView.presentScene(scene)
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
