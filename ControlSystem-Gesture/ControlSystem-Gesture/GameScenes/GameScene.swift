//
//  GameScene.swift
//  ControlSystem-Gesture
//
//  Created by Doyoung Song on 1/12/22.
//

import SpriteKit

class GameScene: SKScene {
    
    var ship: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ship = SKSpriteNode(imageNamed: "Ship")
        addChild(ship!)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
