//
//  GameScene.swift
//  ControlSystem-Gesture
//
//  Created by Doyoung Song on 1/12/22.
//

import SpriteKit

class GameScene: SKScene {
    
    var ship: SKSpriteNode?
    var movingAnimation: SKAction?
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ship = SKSpriteNode(imageNamed: "Ship")
        addChild(ship!)
        setupAnimation()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

// MARK: - UI
extension GameScene {
    private func setupAnimation() {
        let atlas = SKTextureAtlas(named: "Ship")
        var atlasTextures: [SKTexture] = []
        for number in 1...12 {
            let name = "Ship\(number)"
            let texture = atlas.textureNamed(name)
            atlasTextures.append(texture)
        }
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 0.05)
        movingAnimation = SKAction.repeat(atlasAnimation, count: 20)
        ship?.run(movingAnimation!)
    }
}
