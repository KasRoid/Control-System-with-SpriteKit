//
//  GameScene.swift
//  ControlSystem-SlingShot
//
//  Created by Doyoung Song on 1/29/22.
//

import SpriteKit

class GameScene: SKScene {
    
    private let backgroundNode = SKSpriteNode(imageNamed: "Background")
    private let playerNode = SKSpriteNode(imageNamed: "Ghost")
    private let triggerNode = TriggerNode()
    private lazy var platformNode = createPlatform()
    
    override func didMove(to view: SKView) {
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if triggerNode.contains(location) {
                
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if triggerNode.contains(location) {
                let vector = CGVector(dx: location.x - triggerNode.position.x, dy: location.y - triggerNode.position.y)
                playerNode.position = CGPoint(x: triggerNode.position.x + vector.dx, y: triggerNode.position.y + vector.dy)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        returnPlayerToTheStartingPoint()
        addPhysicsToPlayerNode()
    }
}

extension GameScene {
    private func returnPlayerToTheStartingPoint() {
        let moveAction = SKAction.move(to: triggerNode.position, duration: 0.1)
        playerNode.run(moveAction)
    }
    
    private func addPhysicsToPlayerNode() {
        playerNode.physicsBody = SKPhysicsBody(texture: playerNode.texture!, size: playerNode.size)
        playerNode.physicsBody?.isDynamic = true
        playerNode.physicsBody?.affectedByGravity = true
    }
}

extension GameScene {
    private func setUI() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setBackgroundNode()
        setTriggerNode()
        setPlayerNode()
        platformNode.position = CGPoint(x: -frame.width / 2 + platformNode.nodeSize.width / 2, y: -platformNode.nodeSize.height)
        addChild(platformNode)
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
    
    private func createPlatform() -> PlatformNode {
        let nodeWidth = SKSpriteNode(imageNamed: "Platform").size.width
        let count = Int(ceil(frame.width / nodeWidth))
        return PlatformNode(numberOfNodes: count)
    }
}
