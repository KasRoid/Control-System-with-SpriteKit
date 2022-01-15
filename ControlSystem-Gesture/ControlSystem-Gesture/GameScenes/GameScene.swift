//
//  GameScene.swift
//  ControlSystem-Gesture
//
//  Created by Doyoung Song on 1/12/22.
//

import SpriteKit

class GameScene: SKScene {
    
    private var ship: SKSpriteNode?
    private var target: SKSpriteNode?
    private var movingAnimation: SKAction?
    private let tapRecognizer = UITapGestureRecognizer()
    private let rotateRecognizer = UIRotationGestureRecognizer()
    private var offset: CGFloat = 0
    private let length: CGFloat = 200
    private var theRotation: CGFloat = 0
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addNodes()
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
        let fadeAction = SKAction.fadeAlpha(to: 0, duration: 0.5)
        target?.run(fadeAction)
        
        let moveAction = SKAction.move(to: target!.position, duration: 0.6)
        moveAction.timingMode = .easeOut
        ship?.run(moveAction)
        ship?.run(movingAnimation!)
    }
    
    @objc
    func didRotate(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began:
            let fadeAction = SKAction.fadeAlpha(to: 1, duration: 0.5)
            target?.run(fadeAction)
        case .changed:
            theRotation = CGFloat(sender.rotation) + offset
            theRotation = theRotation * -1
            ship?.zRotation = theRotation
            target?.zRotation = theRotation
            
            let xDistance: CGFloat = sin(theRotation) * length
            let yDistance: CGFloat = cos(theRotation) * length
            target?.position = CGPoint(x: ship!.position.x - xDistance, y: ship!.position.y + yDistance)
        case .ended:
            offset = theRotation * -1
        default:
            break
        }
    }
}

// MARK: - UI
extension GameScene {
    private func addNodes() {
        ship = SKSpriteNode(imageNamed: "Ship")
        addChild(ship!)
        
        target = SKSpriteNode(imageNamed: "target")
        guard let x = ship?.position.x, let y = ship?.position.y else { return }
        target?.position = CGPoint(x: x, y: y + length)
        target?.alpha = 0
        addChild(target!)
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
