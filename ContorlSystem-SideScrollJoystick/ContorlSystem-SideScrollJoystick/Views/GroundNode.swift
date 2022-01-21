//
//  GroundNode.swift
//  ContorlSystem-SideScrollJoystick
//
//  Created by Doyoung Song on 1/21/22.
//

import SpriteKit

class GroundNode: SKNode {
    
    init(imageName: String, location: CGPoint, quantity: Int) {
        super.init()
        position = location
        for index in 0...quantity {
            let node = SKSpriteNode(imageNamed: imageName)
            node.position = CGPoint(x: node.size.width * CGFloat(index), y: 0)
            node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
            node.physicsBody?.isDynamic = false
            node.physicsBody?.categoryBitMask = BodyType.ground.rawValue
            node.name = "ground"
            addChild(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
