//
//  GameScene.swift
//  PathBasedControl
//
//  Created by Doyoung Song on 1/7/22.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0, y: 0)
        backgroundColor = .black
        let spriteNode = SKSpriteNode(imageNamed: "skull")
        spriteNode.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        addChild(spriteNode)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 40))
        path.addLine(to: CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2))
        path.addLine(to: CGPoint(x: view.bounds.width, y: 40))
        path.closeSubpath()
        
        let followAction = SKAction.follow(path, asOffset: false, orientToPath: true, duration: 3)
        let reverseAction = followAction.reversed()
        let sequenceAction = SKAction.sequence([followAction, reverseAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        spriteNode.run(repeatAction)
        
        let line = SKShapeNode()
        line.path = path
        line.lineWidth = 1
        line.strokeColor = .red
        addChild(line)
    }
}
