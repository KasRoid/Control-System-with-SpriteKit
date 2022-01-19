//
//  GameScene.swift
//  ControlSystem-VirtualJoystick
//
//  Created by Doyoung Song on 1/17/22.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Properties
    private let baseNode = SKSpriteNode(imageNamed: "Base")
    private let ballNode = SKSpriteNode(imageNamed: "Ball")
    private let shipNode = SKSpriteNode(imageNamed: "Ship")
    
    private var isStickActive = false
    private var shipSpeedX: CGFloat = 0.1
    private var shipSpeedY: CGFloat = 0.1
    private var directionMode = false
    private var currentDirection: Direction = .N
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        setBasics()
        addNodes()
    }
    
    override func update(_ currentTime: TimeInterval) {
        directionMode ? moveByDirection() : moveByPosition()
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            isStickActive = ballNode.frame.contains(location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            guard isStickActive else { return }
            let location = touch.location(in: self)
            let vector = CGVector(dx: location.x - baseNode.position.x, dy: location.y - baseNode.position.y)
            let angle = atan2(vector.dy, vector.dx)
            let degree = angle * CGFloat(180 / Double.pi)
            currentDirection.setDirection(degree: degree + 180)
            
            let length = baseNode.frame.size.height / 2
            let radian90: CGFloat = 1.57079633
            let xDistance = sin(angle - radian90) * length
            let yDistance = cos(angle - radian90) * length
            
            ballNode.position = baseNode.frame.contains(location)
            ? location
            : CGPoint(x: baseNode.position.x - xDistance, y: baseNode.position.y + yDistance)
            shipNode.zRotation = angle - radian90
            
            shipSpeedX = vector.dx * 0.1
            shipSpeedY = vector.dy * 0.1
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isStickActive else { return }
        let moveAction = SKAction.move(to: baseNode.position, duration: 0.2)
        moveAction.timingMode = .easeOut
        ballNode.run(moveAction)
    }
}

// MARK: - Methods
extension GameScene {
    private func moveByPosition() {
        shipNode.position = CGPoint(x: shipNode.position.x + shipSpeedX, y: shipNode.position.y + shipSpeedY)
    }
    
    private func moveByDirection() {
        var xMove: CGFloat = 0
        var yMove: CGFloat = 0
        
        switch currentDirection {
        case .N:
            yMove = 1
        case .S:
            yMove = -1
        case .E:
            xMove = 1
        case .W:
            xMove = -1
        case .NE:
            xMove = 1
            yMove = 1
        case .NW:
            xMove = -1
            yMove = 1
        case .SE:
            xMove = 1
            yMove = -1
        case .SW:
            xMove = -1
            yMove = -1
        }
        shipNode.position = CGPoint(x: shipNode.position.x + xMove, y: shipNode.position.y + yMove)
    }
}

// MARK: - UI
extension GameScene {
    private func setBasics() {
        backgroundColor = .black
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    private func addNodes() {
        baseNode.position = CGPoint(x: 0, y: -200)
        addChild(baseNode)
        ballNode.position = baseNode.position
        addChild(ballNode)
        shipNode.position = CGPoint(x: 0, y: 200)
        shipNode.xScale = 0.6
        shipNode.yScale = 0.6
        addChild(shipNode)
    }
}
