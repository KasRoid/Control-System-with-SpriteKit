//
//  GameScene.swift
//  ControlSystem-SlingShot
//
//  Created by Doyoung Song on 1/29/22.
//

import SpriteKit

class GameScene: SKScene {
    
    private let backgroundNode = SKSpriteNode(imageNamed: "Background")
    private let playerNode = PlayerNode(imageName: "Ghost")
    private let triggerNode = TriggerNode()
    private lazy var platformNode = createPlatform()
    private var impulse: CGVector = .zero
    private lazy var positionX = playerNode.position.x
    
    override func didMove(to view: SKView) {
        setUI()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackground()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if triggerNode.contains(location) {
                resetBackground()
                triggerNode.setStatus(isActive: true)
                let vector = CGVector(dx: location.x - triggerNode.position.x, dy: location.y - triggerNode.position.y)
                playerNode.position = CGPoint(x: triggerNode.position.x + vector.dx, y: triggerNode.position.y + vector.dy)
                playerNode.reset()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if triggerNode.contains(location) {
                let vector = CGVector(dx: location.x - triggerNode.position.x, dy: location.y - triggerNode.position.y)
                playerNode.position = CGPoint(x: triggerNode.position.x + vector.dx, y: triggerNode.position.y + vector.dy)
                setImpulse(location: location) 
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            guard triggerNode.isActive else { return }
            if triggerNode.contains(location) {
                setImpulse(location: location)
            }
            playerNode.applyPhysics()
            playerNode.applyImpulse(impulse: impulse)
            triggerNode.setStatus(isActive: false)
        }
    }
}

extension GameScene {
    private func setImpulse(location: CGPoint) {
        impulse = CGVector(dx: -(location.x - triggerNode.position.x) * 0.7, dy: -(location.y - triggerNode.position.y) * 0.7)
    }
    
    private func moveBackground() {
        let triggerNodeEndPositionX = triggerNode.position.x + triggerNode.frame.width / 2
        if triggerNodeEndPositionX < playerNode.position.x {
            let move = SKAction.move(to: CGPoint(x: -playerNode.position.x + positionX, y: 0), duration: 0)
            backgroundNode.run(move)
        }
    }
    
    private func resetBackground() {
        let move = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0)
        backgroundNode.run(move)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print(#function)
    }
}

extension GameScene {
    private func setUI() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
        setBackgroundNode()
        setTriggerNode()
        setPlayerNode()
        setPlatformNode()
    }
    
    private func setBackgroundNode() {
        backgroundNode.size = frame.size
        addChild(backgroundNode)
    }
    
    private func setPlayerNode() {
        playerNode.position = triggerNode.position
        playerNode.zPosition = 2
        addChild(playerNode)
    }
    
    private func setTriggerNode() {
        let viewWidth = frame.width
        let nodeRadius = triggerNode.frame.size.width / 2
        let offset: CGFloat = 20
        triggerNode.position = CGPoint(x: -viewWidth / 2 + nodeRadius + offset, y: 0)
        triggerNode.zPosition = 1
        triggerNode.alpha = 0.3
        addChild(triggerNode)
    }
    
    private func setPlatformNode() {
        platformNode.position = CGPoint(x: -frame.width / 2 + platformNode.nodeSize.width / 2, y: -platformNode.nodeSize.height * 1.4)
        backgroundNode.addChild(platformNode)
    }
    
    private func createPlatform() -> PlatformNode {
        let nodeWidth = SKSpriteNode(imageNamed: "Platform").size.width
        let count = Int(ceil(frame.width / nodeWidth))
        return PlatformNode(numberOfNodes: count)
    }
}
