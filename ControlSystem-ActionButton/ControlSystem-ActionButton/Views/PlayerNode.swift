//
//  PlayerNode.swift
//  ControlSystem-ActionButton
//
//  Created by Doyoung Song on 1/21/22.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    
    private var movementSpeed = 0
    private var walkAction: SKAction?
    private var idleAction: SKAction?
    private var attackAction: SKAction?
    private var isBusy = false
    
    // MARK: - Lifecycle
    init(imageNamed imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
        setPhysics(texture: texture)
        walkAction = setupAction(for: "Walk", numberOfTextures: 23)
        idleAction = setupAction(for: "Idle", numberOfTextures: 23)
        attackAction = setupAction(for: "Attack", numberOfTextures: 15, shouldRepeat: false)
        guard let idleAction = idleAction else { return }
        run(idleAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
extension PlayerNode {    
    func attack() {
        guard let attackAction = attackAction else { return }
        isBusy = true
        run(attackAction)
    }
    
    func walk() {
        guard !isBusy else { return }
        guard let walkAction = walkAction else { return }
        run(walkAction)
    }
    
    func stop() {
        guard !isBusy else { return }
        guard let idleAction = idleAction else { return }
        run(idleAction)
    }
}

// MARK: - Physics
extension PlayerNode {
    private func setPhysics(texture: SKTexture) {
        let body = SKPhysicsBody(texture: texture, size: texture.size())
        body.affectedByGravity = true
        body.allowsRotation = false
        body.categoryBitMask = BodyType.player.rawValue
        body.contactTestBitMask = BodyType.ground.rawValue
        physicsBody = body
    }
}

// MARK: - Animations
extension PlayerNode {
    private func setupAction(for name: String, numberOfTextures: Int, shouldRepeat: Bool = true) -> SKAction {
        let atlas = SKTextureAtlas(named: name)
        var textures: [SKTexture] = []
        for number in 0...numberOfTextures {
            let texture = atlas.textureNamed("\(name)\(number)")
            textures.append(texture)
        }
        
        let action = SKAction.animate(with: textures, timePerFrame: 1/30, resize: true, restore: false)
        if shouldRepeat {
            return SKAction.repeatForever(action)
        } else {
            let completionAction = SKAction.run { self.walkOrStop() }
            return SKAction.sequence([action, completionAction])
        }
    }
    
    private func walkOrStop() {
        isBusy = false
    }
}
