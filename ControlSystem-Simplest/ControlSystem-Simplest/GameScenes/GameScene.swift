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
        let xDiff = Float(location.x) - Float(theCharacter.position.x)
        let yDiff = Float(location.y) - Float(theCharacter.position.y)
        let totalDiff = abs(xDiff) + abs(yDiff)
        let xRatio = abs(xDiff) / totalDiff
        let yRatio = abs(yDiff) / totalDiff
        
        let totalDuration: Float = 1
        let firstActionDuration = TimeInterval(totalDuration * xRatio)
        let secondActionDuration = TimeInterval(totalDuration * yRatio)
        
        theCharacter.removeAllActions()
        let firstAction = SKAction.moveBy(x: CGFloat(xDiff), y: 0, duration: firstActionDuration)
        let secondAction = SKAction.moveBy(x: 0, y: CGFloat(yDiff), duration: secondActionDuration)
        let seqeunce = SKAction.sequence([firstAction, secondAction])
        theCharacter.run(seqeunce)
    }
}
