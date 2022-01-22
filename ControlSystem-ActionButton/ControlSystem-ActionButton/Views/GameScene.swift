//
//  GameScene.swift
//  ControlSystem-ActionButton
//
//  Created by Doyoung Song on 1/21/22.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Properties
    private let joystickNode = JoystickNode(isOn: false)
    private let attackButtonNode = SKSpriteNode(imageNamed: "Button")
    private let playerNode = PlayerNode(imageNamed: "Idle0")
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        setBasics()
        addNodes()
    }
    
    override func update(_ currentTime: TimeInterval) {
        playerNode.move()
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            attackButtonNode.contains(location) ? playerNode.attack() : joystickNode.activate(at: location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            guard joystickNode.isActive else { return }
            let location = touch.location(in: self)
            let movement = joystickNode.move(location: location)
            playerNode.setSpeed(x: movement.x, y: movement.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystickNode.deactivate()
        playerNode.setSpeed(x: 0, y: 0)
    }
}

// MARK: - UI
extension GameScene {
    private func setBasics() {
        backgroundColor = .black
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    private func addNodes() {
        // Background
        let backgroundNode = SKSpriteNode(imageNamed: "Background")
        backgroundNode.zPosition = -100
        backgroundNode.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        addChild(backgroundNode)
        
        let groundNode = GroundNode(imageName: "Platform", location: CGPoint(x: -500, y: -80), quantity: 8)
        groundNode.zPosition = -1
        addChild(groundNode)
        
        // Buttons
        addChild(joystickNode)
        attackButtonNode.position = CGPoint(x: frame.width / 2 - 100, y: -100)
        attackButtonNode.alpha = 0.4
        addChild(attackButtonNode)
        
        // Player
        playerNode.position = CGPoint(x: 0, y: 0)
        playerNode.name = "player"
        addChild(playerNode)
    }
}
