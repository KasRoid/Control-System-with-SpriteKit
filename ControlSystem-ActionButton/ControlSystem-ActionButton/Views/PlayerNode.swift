//
//  PlayerNode.swift
//  ControlSystem-ActionButton
//
//  Created by Doyoung Song on 1/21/22.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    
    // MARK: - Properties
    private var movementSpeed = 0
    private var walkAction: SKAction?
    private var idleAction: SKAction?
    private var attackAction: SKAction?
    
    private(set) var speedX: CGFloat = 0
    private(set) var speedY: CGFloat = 0
    
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
    func walk() {
        guard action(forKey: "walk") == nil else { return }
        guard let walkAction = walkAction else { return }
        if speedX > 0 {
            xScale = 1
        } else if speedX < 0 {
            xScale = -1
        }
        removeAllActions()
        run(walkAction, withKey: "walk")
    }
    
    func stop() {
        guard action(forKey: "idle") == nil else { return }
        guard action(forKey: "attack") == nil else { return }
        guard let idleAction = idleAction else { return }
        removeAllActions()
        run(idleAction, withKey: "idle")
    }
    
    func attack() {
        guard action(forKey: "attack") == nil else { return }
        guard let attackAction = attackAction else { return }
        removeAllActions()
        run(attackAction, withKey: "attack")
    }
    
    func setSpeed(x: CGFloat, y: CGFloat) {
        speedX = x
        speedY = y
        speedX == 0 ? stop() : walk()
    }
    
    func move() {
        position = CGPoint(x: position.x + speedX, y: position.y + speedY)
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
            let completionAction = SKAction.run { self.removeAllActions() }
            return SKAction.sequence([action, completionAction])
        }
    }
}
