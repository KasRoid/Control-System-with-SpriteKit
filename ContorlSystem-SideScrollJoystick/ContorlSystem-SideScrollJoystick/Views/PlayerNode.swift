//
//  PlayerNode.swift
//  ContorlSystem-SideScrollJoystick
//
//  Created by Doyoung Song on 1/21/22.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    
    // MARK: - Lifecycle
    init(imageNamed imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
        setPhysics(texture: texture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Physics
extension PlayerNode {
    func setPhysics(texture: SKTexture) {
        let body = SKPhysicsBody(texture: texture, size: texture.size())
        body.affectedByGravity = false
        body.allowsRotation = false
        body.categoryBitMask = BodyType.player.rawValue
        body.contactTestBitMask = BodyType.ground.rawValue
        physicsBody = body
    }
}
