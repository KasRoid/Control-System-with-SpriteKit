//
//  GameScene.swift
//  ControlSystem-ActionButton
//
//  Created by Doyoung Song on 1/21/22.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Properties
    private let baseNode = SKSpriteNode(imageNamed: "Base")
    private let ballNode = SKSpriteNode(imageNamed: "Ball")
    private let attackButtonNode = SKSpriteNode(imageNamed: "Button")
    private let playerNode = PlayerNode(imageNamed: "Idle0")
    
    private var isStickActive = false
    private var speedX: CGFloat = 0.1
    private var speedY: CGFloat = 0.1
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        setBasics()
        addNodes()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveByPosition()
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if attackButtonNode.contains(location) {
                playerNode.attack()
            } else if !ballNode.frame.contains(location) {
                playerNode.walk()
                isStickActive = true
                showStick(true)
                baseNode.position = location
                ballNode.position = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            guard isStickActive else { return }
            let location = touch.location(in: self)
            let vector = CGVector(dx: location.x - baseNode.position.x, dy: location.y - baseNode.position.y)
            let angle = atan2(vector.dy, vector.dx)
            
            let length = baseNode.frame.size.height / 2
            let radian90: CGFloat = 1.57079633
            let xDistance = sin(angle - radian90) * length
            let yDistance = cos(angle - radian90) * length
            
            ballNode.position = baseNode.frame.contains(location)
            ? location
            : CGPoint(x: baseNode.position.x - xDistance, y: baseNode.position.y + yDistance)
            
            speedX = round(vector.dx * 0.1)
            speedY = round(vector.dy * 0.1)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        showStick(false)
        if isStickActive {
            playerNode.stop()
            speedX = 0
            speedY = 0
        } else {
            let moveAction = SKAction.move(to: baseNode.position, duration: 0.2)
            moveAction.timingMode = .easeOut
            ballNode.run(moveAction)
        }
    }
}

// MARK: - Logic
extension GameScene {
    private func moveByPosition() {
        playerNode.position = CGPoint(x: playerNode.position.x + speedX, y: playerNode.position.y + speedY)
        if speedX > 0 {
            playerNode.xScale = 1
        } else if speedX < 0 {
            playerNode.xScale = -1
        }
    }
    
    private func showStick(_ isOn: Bool, animated: Bool = true) {
        if isOn {
            baseNode.alpha = 0.6
            ballNode.alpha = 0.6
        } else {
            if animated {
                let fadeAction = SKAction.fadeAlpha(to: 0, duration: 0.3)
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
extension GameScene {
    private func setBasics() {
        backgroundColor = .black
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    private func addNodes() {
        let backgroundNode = SKSpriteNode(imageNamed: "Background")
        backgroundNode.zPosition = -100
        backgroundNode.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        addChild(backgroundNode)
        
        baseNode.position = CGPoint(x: 0, y: -200)
        baseNode.xScale = 0.5
        baseNode.yScale = 0.5
        addChild(baseNode)
        ballNode.position = baseNode.position
        ballNode.xScale = 0.5
        ballNode.yScale = 0.5
        addChild(ballNode)
        showStick(false, animated: false)
        
        attackButtonNode.position = CGPoint(x: frame.width / 2 - 100, y: -100)
        attackButtonNode.alpha = 0.4
        addChild(attackButtonNode)
        
        playerNode.position = CGPoint(x: 0, y: 0)
        playerNode.name = "player"
        addChild(playerNode)
        
        let groundNode = GroundNode(imageName: "Platform", location: CGPoint(x: -500, y: -80), quantity: 8)
        groundNode.zPosition = -1
        addChild(groundNode)
    }
}
