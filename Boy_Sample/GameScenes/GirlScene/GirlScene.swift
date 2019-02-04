//
//  GirlScene.swift
//  Boy_Sample
//
//  Created by Romy Ilano on 1/24/19.
//  Copyright © 2019 Romy Ilano. All rights reserved.
//

import SpriteKit

class GirlScene: SKScene {
    //MARK: - Girl
    
    var girlHead: SKNode!// girl_head
    
    var girlFist: SKNode!
    var girlTorso: PersonNode!
    var girlArmUpper: SKNode!
    var girlArmLower: SKNode!
    
    var girlLegLower: SKNode!
    var girlLegUpper: SKNode!
    
    let lowerArmAngleLimit: CGFloat = 0
    let lowerArmUppleAngleLimit: CGFloat = 160.0
    
    let upperArmLowerLimit: CGFloat = 0
    let upperArmUpperLimit: CGFloat = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        girlHead = childNode(withName: "girl_head")
        
        girlTorso = childNode(withName: "girl_torso") as! PersonNode
        girlArmUpper = girlTorso.childNode(withName: "girl_front_arm_upper")
        girlArmLower = girlArmUpper.childNode(withName: "girl_front_arm_lower")
        girlFist = girlArmLower.childNode(withName: "girl_fist")
        
        girlLegUpper = girlTorso.childNode(withName: "girl_front_leg_upper")
        girlLegLower = girlLegUpper.childNode(withName: "girl_front_leg_lower")
        girlArmLower.reachConstraints = SKReachConstraints(lowerAngleLimit: CGFloat(0), upperAngleLimit: CGFloat(150.0))
        
        let rotConstraintUpperArm = SKReachConstraints(lowerAngleLimit: upperArmLowerLimit, upperAngleLimit: upperArmUpperLimit)
        girlArmUpper.reachConstraints = rotConstraintUpperArm

    }

    
    func setupHeadOrientation(toTargetNode targetNode: SKSpriteNode, withRange headOrientationRange: SKRange) {
        let orientNodeConstraint = SKConstraint.orient(to: targetNode, offset: SKRange(constantValue: 0.0))
        let rotationConstraint = SKConstraint.zRotation(headOrientationRange)
        
        rotationConstraint.enabled = false
        orientNodeConstraint.enabled = false
        // we wait until the 1st time to enable
        girlHead.constraints = [orientNodeConstraint, rotationConstraint]
    }
}
