//
//  GameScene.swift
//  ControlSystem-SlingShot
//
//  Created by Doyoung Song on 1/29/22.
//

import SpriteKit

class GameScene: SKScene {
    
    private let backgroundNode = SKSpriteNode(imageNamed: "Background")
    
    override func didMove(to view: SKView) {
        setUI()
    }
}

extension GameScene {
    private func setUI() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundNode.size = frame.size
        addChild(backgroundNode)
    }
}
