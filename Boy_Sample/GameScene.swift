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
        
    
        fistFront = lowerArmFront.childNode(withName: "fist_front")
    }
    
    func punchAt(_ location: CGPoint) {
        // responsible for performing inverse kinematics actions for a joint heriarcy reaching out to a point in space
        // the root node is highest node in the hierachy you want to rotate
        let punch = SKAction.reach(to: location, rootNode: upperArmFront, duration: 0.1)
        //lowerArmFront.run(punch)
        fistFront.run(punch)
        print("zrotation of the lower arm front is:\(lowerArmFront.zRotation)\nzrotation of upper arm front:\(upperArmFront.zRotation)")
        
    }
    
    //MARK: - Touchies
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            punchAt(location)
        }
    }
}
