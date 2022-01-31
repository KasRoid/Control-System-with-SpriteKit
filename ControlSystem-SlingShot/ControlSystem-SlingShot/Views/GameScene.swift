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
    
    override func didMove(to view: SKView) {
        setUI()
    }
}

extension GameScene {
    private func setUI() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundNode.size = frame.size
        addChild(backgroundNode)
        
        playerNode.position = CGPoint(x: 0, y: 0)
        addChild(playerNode)
        
        addChild(triggerNode)
    }
}
