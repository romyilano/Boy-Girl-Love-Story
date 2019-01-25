//
//  GirlNode.swift
//  Boy_Sample
//
//  Created by Romy Ilano on 1/24/19.
//  Copyright © 2019 Romy Ilano. All rights reserved.
//

import SpriteKit

enum NodeType: Int {
    case person
    case object
}

enum PersonNodes {
    case head
    case torso
    case frontLeg
    enum Arm {
        case upperFront
        case lowerFront
        case upperBack
        case lowerBack
    }
}

// The torso or uper torso is the main node for the peson
class PersonNode: SKSpriteNode {
    var nodeType = NodeType.person
    var headNode: SKSpriteNode?
    var torsoNode: SKSpriteNode?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
