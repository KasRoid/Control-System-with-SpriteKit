//
//  JoystickNode.swift
//  ControlSystem-ActionButton
//
//  Created by Doyoung Song on 1/22/22.
//

import SpriteKit

class JoystickNode: SKNode {
    
    private let baseNode = SKSpriteNode(imageNamed: "Base")
    private let ballNode = SKSpriteNode(imageNamed: "Ball")
    private(set) var isActive = false
            
    // MARK: - Lifecycle
    init(isOn: Bool) {
        super.init()
        setUI()
        showStick(isOn, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
extension JoystickNode {
    func activate(at location: CGPoint) {
        isActive = true
        showStick(true)
        baseNode.position = location
        ballNode.position = location
    }
    
    func deactivate() {
        showStick(false)
        let moveAction = SKAction.move(to: baseNode.position, duration: 0.2)
        moveAction.timingMode = .easeOut
        ballNode.run(moveAction)
    }
    
    func move(location: CGPoint) -> CGPoint {
        let vector = CGVector(dx: location.x - baseNode.position.x, dy: location.y - baseNode.position.y)
        let angle = atan2(vector.dy, vector.dx)
        
        let length = baseNode.frame.size.height / 2
        let radian90: CGFloat = 1.57079633
        let xDistance = sin(angle - radian90) * length
        let yDistance = cos(angle - radian90) * length
        
        ballNode.position = baseNode.frame.contains(location)
        ? location
        : CGPoint(x: baseNode.position.x - xDistance, y: baseNode.position.y + yDistance)
        return CGPoint(x: round(vector.dx * 0.1), y: round(vector.dy * 0.1))
    }
}

// MARK: - Animations
extension JoystickNode {
    private func showStick(_ isOn: Bool, animated: Bool = true) {
        if isOn {
            baseNode.alpha = 0.6
            ballNode.alpha = 0.6
        } else {
            if animated {
                let fadeAction = SKAction.fadeAlpha(to: 0, duration: 0.2)
                baseNode.run(fadeAction)
                ballNode.run(fadeAction)
            } else {
                baseNode.alpha = 0
                ballNode.alpha = 0
            }
        }
    }
}

// MARK: - UI
extension JoystickNode {
    private func setUI() {
        baseNode.position = CGPoint(x: 0, y: -200)
        baseNode.xScale = 0.5
        baseNode.yScale = 0.5
        addChild(baseNode)
        ballNode.position = baseNode.position
        ballNode.xScale = 0.5
        ballNode.yScale = 0.5
        addChild(ballNode)
    }
}
