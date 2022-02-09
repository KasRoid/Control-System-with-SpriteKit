//
//  PlayerNode.swift
//  ControlSystem-SlingShot
//
//  Created by Doyoung Song on 2/9/22.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
        
    init(imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayerNode {
    func move(to point: CGPoint) {
        let moveAction = SKAction.move(to: point, duration: 0.1)
        run(moveAction)
    }
    
    func applyImpulse(impulse: CGVector) {
        physicsBody?.applyImpulse(impulse)
    }
    
    func applyPhysics() {
        guard let texture = texture else { return }
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = true
        physicsBody?.categoryBitMask = BitMask.playerCategory
        physicsBody?.contactTestBitMask = BitMask.platformCategory
    }
    
    func removePhysics() {
        physicsBody = nil
    }
}
