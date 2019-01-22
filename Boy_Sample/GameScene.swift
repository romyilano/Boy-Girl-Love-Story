import SpriteKit

class GameScene: SKScene {
    
    var boyTorso: SKNode!
    
    var upperTorso: SKNode!
    var upperArmFront: SKNode!
    var lowerArmFront: SKNode!
    
    var fistFront: SKNode!
    
    override func didMove(to view: SKView) {

        boyTorso = childNode(withName: Constants.boy_torso)
        boyTorso.position = CGPoint(x: frame.midX, y: frame.midY - 30)
        
        upperArmFront = boyTorso.childNode(withName: Constants.boy_front_arm_upper)
        lowerArmFront = upperArmFront.childNode(withName: Constants.boy_front_arm_lower)
        
        let rotationConstraintLowerArm = SKReachConstraints(lowerAngleLimit: CGFloat(0), upperAngleLimit: CGFloat(160))
        lowerArmFront.reachConstraints = rotationConstraintLowerArm
    
        fistFront = lowerArmFront.childNode(withName: "fist_front")
    }
    
    let upperArmAngleDeg: CGFloat = -10
    let lowerArmAngleDeg: CGFloat = 85
    
    func punchAt(_ location: CGPoint) {
        // responsible for performing inverse kinematics actions for a joint heriarcy reaching out to a point in space
        // the root node is highest node in the hierachy you want to rotate
        let punch = SKAction.reach(to: location, rootNode: upperArmFront, duration: 0.1)
        
        let restore = SKAction.run {
            self.upperArmFront.run(SKAction.rotate(toAngle: self.upperArmAngleDeg.degreesToRadians(), duration: 0.6))
            self.lowerArmFront.run(SKAction.rotate(toAngle: self.lowerArmAngleDeg.degreesToRadians(), duration: 0.6))
        }
        
        // here the first is the end effector
        fistFront.run(SKAction.sequence([punch, restore]))
        
    }
    
    //MARK: - Touchies
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            punchAt(location)
        }
    }
}
