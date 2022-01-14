//
//  GameScene.swift
//  ControlSystem-Gesture
//
//  Created by Doyoung Song on 1/12/22.
//

import SpriteKit

class GameScene: SKScene {
    
    private var ship: SKSpriteNode?
    private var movingAnimation: SKAction?
    private let tapRecognizer = UITapGestureRecognizer()
    private let rotateRecognizer = UIRotationGestureRecognizer()
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addShip()
        setupAnimation()
        addGestures(view: view)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

// MARK: - Gestures
extension GameScene {
    func removeGestures() {
        view?.gestureRecognizers?.removeAll()
    }
}

// MARK: - Selectors
extension GameScene {
    @objc
    func didTap(_ sender: UITapGestureRecognizer) {
        ship?.run(movingAnimation!)
    }
    
    @objc
    func didRotate(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .ended {
            // TODO
        }
    }
}

// MARK: - UI
extension GameScene {
    private func addShip() {
        ship = SKSpriteNode(imageNamed: "Ship")
        addChild(ship!)
    }
    
    private func setupAnimation() {
        let atlas = SKTextureAtlas(named: "Ship")
        var atlasTextures: [SKTexture] = []
        for number in 1...12 {
            let name = "Ship\(number)"
            let texture = atlas.textureNamed(name)
            atlasTextures.append(texture)
        }
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 0.05)
        movingAnimation = SKAction.repeat(atlasAnimation, count: 1)
    }
    
    private func addGestures(view: SKView) {
        tapRecognizer.addTarget(self, action: #selector(didTap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        view.isMultipleTouchEnabled = true
        
        rotateRecognizer.addTarget(self, action: #selector(didRotate(_:)))
        view.addGestureRecognizer(rotateRecognizer)
    }
}
