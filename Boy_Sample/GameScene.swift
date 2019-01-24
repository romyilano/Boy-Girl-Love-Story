import SpriteKit
import CoreGraphics



class GameScene: SKScene {
    
    //MARK: - Boy
    var boyTorso: SKNode!
    
    var upperTorso: SKNode!
    var upperArmFront: SKNode!
    var lowerArmFront: SKNode!
    var headNode: SKNode!
    
    
    //MARK: - Girl
    var girlFist: SKNode!
    var girlTorso: SKNode!
    var girlArmUpper: SKNode!
    var girlArmLower: SKNode!
    
    var girlLegLower: SKNode!
    var girlLegUpper: SKNode!
    
    var orangeNodes = [SKNode]()
    
    // MARK: - Objects
    var backgroundNode: SKNode!
    var oranges: SKNode!
    
    // MARK: Properties
    var targetNode = SKNode()
    
    var fistFront: SKNode!
    
    var firstTouch = false
    
    //MARK: - Head positions
    let headLowerLimit: CGFloat = -10.0
    let headUpperLimit: CGFloat = 50.0
    
    //MARK: Reach Constraints
    let upperArmAngleDeg: CGFloat = -10
    let lowerArmAngleDeg: CGFloat = 85
    
    let lowerArmAngleLimit: CGFloat = 0
    let lowerArmUppleAngleLimit: CGFloat = 160.0
    
    let upperArmLowerLimit: CGFloat = 0
    let upperArmUpperLimit: CGFloat = 0
    
    //MARK: - Movement
    var lastTouchLocation: CGPoint?
    let runningMovePtsPerSecond: CGFloat = 360.0
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    var velocity = CGPoint.zero
    
    //MARK: - Initializers
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //MARK: Lifecycle
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(red: 231/255, green: 227/255, blue: 178/255, alpha: 1.0)
        setupGirl()
        
        //MARK: Setup - boy
        setupBoy()
        
        
        
        backgroundNode = childNode(withName: "background")
        oranges = backgroundNode.childNode(withName: "oranges")
        
        orangeNodes = Array(children.filter { $0.name == "orange" })
        print("there are \(orangeNodes.count) oranges")
        
   
    }
    
    //MARK: - Setup drudge work
    private func setupBoy() {
        boyTorso = childNode(withName: Constants.boy_torso)
        boyTorso.position = CGPoint(x: frame.midX, y: frame.midY + 30)
        
        upperArmFront = boyTorso.childNode(withName: Constants.boy_front_arm_upper)
        lowerArmFront = upperArmFront.childNode(withName: Constants.boy_front_arm_lower)
        
        let rotationConstraintLowerArm = SKReachConstraints(lowerAngleLimit:lowerArmAngleLimit, upperAngleLimit: lowerArmUppleAngleLimit)
        lowerArmFront.reachConstraints = rotationConstraintLowerArm
        
        headNode = boyTorso.childNode(withName: "boy_head")
        
        fistFront = lowerArmFront.childNode(withName: "fist_front")
        
        //MARK: Setup - headrientation(s)
        let orientNodeConstraint = SKConstraint.orient(to: targetNode, offset: SKRange(constantValue: 0.0))
        let range = SKRange(lowerLimit: headLowerLimit.degreesToRadians(),
                            upperLimit: headUpperLimit.degreesToRadians())
        let rotationConstraint = SKConstraint.zRotation(range)
        
        rotationConstraint.enabled = false
        orientNodeConstraint.enabled = false
             headNode.constraints = [orientNodeConstraint, rotationConstraint]
    }
    
    private func setupGirl() {
        girlTorso = childNode(withName: "girl_torso")
        girlArmUpper = girlTorso.childNode(withName: "girl_front_arm_upper")
        girlArmLower = girlArmUpper.childNode(withName: "girl_front_arm_lower")
        girlFist = girlArmLower.childNode(withName: "girl_fist")
        
        girlLegUpper = girlTorso.childNode(withName: "girl_front_leg_upper")
        girlLegLower = girlLegUpper.childNode(withName: "girl_front_leg_lower")
        girlArmLower.reachConstraints = SKReachConstraints(lowerAngleLimit: CGFloat(0), upperAngleLimit: CGFloat(150.0))
        
        let rotConstraintUpperArm = SKReachConstraints(lowerAngleLimit: upperArmLowerLimit, upperAngleLimit: upperArmUpperLimit)
        girlArmUpper.reachConstraints = rotConstraintUpperArm
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateTimeVariables(current: currentTime)
        updateGirlLocation()
    }
    
    private func updateTimeVariables(current currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        print("time update is:\(dt)")
        lastUpdateTime = currentTime
    }
    
    //MARK: - Touchies
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            sceneTouched(inLocation: location)
            punchAt(location)
            targetNode.position = location
            
            //MARK: head following touch
            if !firstTouch {
                headNode.constraints!.forEach {
                    $0.enabled = true
                    self.firstTouch = true
                }
                
            }
        }
    }
    
    //MARK: - Movement
    private func sceneTouched(inLocation location: CGPoint) {
        
        lastTouchLocation = location
        
        //MARK: handle turning
        boyTorso.xScale = location.x < frame.midX ? abs(boyTorso.xScale) * -1 : abs(boyTorso.xScale)
       // girlTorso.xScale = location.x < frame.midX ? abs(girlTorso.xScale) * -1 : abs(girlTorso.xScale)
       
        moveGirlToward(location: location)
      
        
    }
    
    func punchAt(_ location: CGPoint) {
        // responsible for performing inverse kinematics actions for a joint heriarcy reaching out to a point in space
        // the root node is highest node in the hierachy you want to rotate
        //MARK: Boy Actions
        let punchBoy = SKAction.reach(to: location, rootNode: upperArmFront, duration: 0.1)
        
        let restoreBoy = SKAction.run {
            self.upperArmFront.run(SKAction.rotate(toAngle: self.upperArmAngleDeg.degreesToRadians(), duration: 0.6))
            self.lowerArmFront.run(SKAction.rotate(toAngle: self.lowerArmAngleDeg.degreesToRadians(), duration: 0.6))
        }
        
        // here the first is the end effector
        fistFront.run(SKAction.sequence([punchBoy, restoreBoy]))
        
        // MARK: Girl Actions
        let reachGirl = SKAction.reach(to: location, rootNode: girlArmUpper, duration: 0.1)
        let restoreGirl = SKAction.run {
            self.girlArmUpper.run(SKAction.rotate(toAngle: self.upperArmAngleDeg.degreesToRadians(), duration: 0.6))
            self.lowerArmFront.run(SKAction.rotate(byAngle: self.lowerArmAngleDeg.degreesToRadians(), duration: 0.6))
        }
        girlFist.run(SKAction.sequence([reachGirl, restoreGirl]))
        
    }
    
      let runningGirlScale: CGFloat = 1.0
    

}

//MARK: - Sprite movement
extension GameScene {
    func move(sprite: SKNode, velocity: CGPoint, spriteXScale: CGFloat = 1.0) {
        let amountToMove = velocity * CGFloat(dt)
        sprite.xScale = (velocity.x < 0) ? -spriteXScale : spriteXScale // flip
        sprite.position += amountToMove
    }
    
    func moveGirlToward(location: CGPoint) {
        // start animation
        let offset = location - girlTorso.position
        let direction = offset.normalized()
        velocity = direction * runningMovePtsPerSecond
    }
    
    private func updateGirlLocation() {
        guard let lastTouchLocation = lastTouchLocation else { return }
        
        //TODO:
        let difference = lastTouchLocation - girlTorso.position //
        
        if difference.length() <= runningMovePtsPerSecond * CGFloat(dt) {
            // stop girl from moving
            girlTorso.position = lastTouchLocation
            velocity = CGPoint.zero
            // stop walking animation
            move(sprite: girlTorso, velocity: velocity, spriteXScale: runningGirlScale)
        } else {
            move(sprite: girlTorso, velocity: velocity, spriteXScale: runningGirlScale)
        }
    }
}


