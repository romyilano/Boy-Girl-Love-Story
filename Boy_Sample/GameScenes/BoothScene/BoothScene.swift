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
    
    //MARK: - Initializers
    override init(size: CGSize) {
        super.init(size: size)
        setupPlayableRect()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlayableRect()
    }
    
    //MARK: - Setup
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        girlNode = childNode(withName: "girl_node")
        
        
    }
    
    func setupPlayableRect() {
        
    }
}
