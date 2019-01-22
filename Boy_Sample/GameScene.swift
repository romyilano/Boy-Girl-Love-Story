import SpriteKit

class GameScene: SKScene {
    
    var boyTorso: SKNode!
    
    var upperTorso: SKNode!
    var upperArmFront: SKNode!
    var lowerArmFront: SKNode!
    var headNode: SKNode!
    
    var targetNode = SKNode()
    
    var fistFront: SKNode!
    
    var firstTouch = false
    
    let headLowerLimit: CGFloat = -20.0
    let headUpperLimit: CGFloat = 50.0
    
    override func didMove(to view: SKView) {

        backgroundColor = UIColor(red: 231/255, green: 227/255, blue: 178/255, alpha: 1.0)
        boyTorso = childNode(withName: Constants.boy_torso)
        boyTorso.position = CGPoint(x: frame.midX, y: frame.midY + 30)
        
        upperArmFront = boyTorso.childNode(withName: Constants.boy_front_arm_upper)
        lowerArmFront = upperArmFront.childNode(withName: Constants.boy_front_arm_lower)
        
        let rotationConstraintLowerArm = SKReachConstraints(lowerAngleLimit: CGFloat(0), upperAngleLimit: CGFloat(160))
        lowerArmFront.reachConstraints = rotationConstraintLowerArm
    
        headNode = boyTorso.childNode(withName: "boy_head")
        
        fistFront = lowerArmFront.childNode(withName: "fist_front")
        
        let orientNodeConstraint = SKConstraint.orient(to: targetNode, offset: SKRange(constantValue: 0.0))
        let range = SKRange(lowerLimit: headLowerLimit.degreesToRadians(),
                            upperLimit: headUpperLimit.degreesToRadians())
        let rotationConstraint = SKConstraint.zRotation(range)
        
        rotationConstraint.enabled = false
        orientNodeConstraint.enabled = false
        
        headNode.constraints = [orientNodeConstraint, rotationConstraint]
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
            boyTorso.xScale = location.x < frame.midX ? abs(boyTorso.xScale) * -1 : abs(boyTorso.xScale)
            punchAt(location)
            targetNode.position = location
            
            if !firstTouch {
                headNode.constraints!.forEach {
                    $0.enabled = true
                    self.firstTouch = true
                }
            }
        }
    }
}
