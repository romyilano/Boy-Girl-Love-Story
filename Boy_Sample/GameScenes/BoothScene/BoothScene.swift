//
//  BoothScene.swift
//  ARKitFromScratch
//
//  Created by Romy Ilano on 1/30/19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import SpriteKit

class BoothScene: SKScene {

    var girlNode: SKNode!
    
    //MARK: - Setup
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        girlNode = childNode(withName: "girl_node")
        
        
    }
    
    func setupPlayableRect() {
        
    }
}
