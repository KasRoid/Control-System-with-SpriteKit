//
//  GameScene.swift
//  ControlSystem-Simplest
//
//  Created by Doyoung Song on 1/6/22.
//

import SpriteKit

class GameScene: SKScene {
    
    private var theCharacter: SKSpriteNode?
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        theCharacter = SKSpriteNode(imageNamed: "character")
        addChild(theCharacter!)
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            moveCharacter(location: location)
        }
    }
}

// MARK: - UI
extension GameScene {
    private func moveCharacter(location: CGPoint) {
        guard let theCharacter = theCharacter else { return }
        let xDiff = abs(Float(location.x) - Float(theCharacter.position.x))
        let yDiff = abs(Float(location.y) - Float(theCharacter.position.y))
        let isHorizontalMove = xDiff > yDiff
        
        if  isHorizontalMove {
            let xOffset: CGFloat = location.x > theCharacter.position.x ? 30 : -30
            theCharacter.position = CGPoint(x: theCharacter.position.x + xOffset, y: theCharacter.position.y)
        } else {
            let yOffset: CGFloat = location.y > theCharacter.position.y ? 30 : -30
            theCharacter.position = CGPoint(x: theCharacter.position.x, y: theCharacter.position.y + yOffset)
        }
    }
}
