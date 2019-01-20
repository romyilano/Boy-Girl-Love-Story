//
//  GameViewController.swift
//  Boy_Sample
//
//  Created by Romy Ilano on 1/20/19.
//  Copyright © 2019 Romy Ilano. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

struct Constants {
    static let boy_torso = "boy_torso"
    static let boy_head = "boy_head"
    static let boy_upper_front_leg = "boy_upper_front_leg"
    static let boy_front_lower_leg = "boy_front_lower_leg"
    static let boy_front_arm_upper = "boy_front_arm_upper"
    static let boy_front_arm_lower = "boy_front_arm_lower"
}

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
