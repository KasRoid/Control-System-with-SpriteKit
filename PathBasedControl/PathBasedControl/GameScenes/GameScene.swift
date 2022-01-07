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
        addSkulls(view: view)
        createLine()
    }
}

// MARK: - UI
extension GameScene {
    private func drawSnakeShapePath() -> CGMutablePath {
        let path = CGMutablePath()
        let xOffset: CGFloat = 40
        let widthEndPoint = (view?.bounds.width ?? 0) - xOffset
        let height = view?.bounds.height ?? 0
        var yOffset: CGFloat = -20
        
        path.move(to: CGPoint(x: xOffset, y: height + yOffset))
        let numberOfLines = 4
        let finalStep = 4
        
        for _ in 1...numberOfLines {
            for currentStep in 1...finalStep {
                let x = currentStep == 1 || currentStep == 2 ? widthEndPoint : xOffset
                path.addLine(to: CGPoint(x: x, y: height + yOffset))
                if currentStep % 2 != 0 {
                    yOffset -= 30
                }
            }
        }
        return path
    }
    
    private func addSkulls(view: SKView) {
        let addSkullAction = SKAction.run { self.addNode(view: view, imageName: "skull", action: self.addFollowAction) }
        let waitAction = SKAction.wait(forDuration: 0.2)
        let sequenceAction = SKAction.sequence([addSkullAction, waitAction])
        let repeatAction = SKAction.repeat(sequenceAction, count: 20)
        run(repeatAction)
    }
    
    private func addNode(view: SKView, imageName: String, action: ((SKSpriteNode) -> Void)?) {
        let spriteNode = SKSpriteNode(imageNamed: imageName)
        spriteNode.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        action?(spriteNode)
        addChild(spriteNode)
    }
    
    private func createLine() {
        let line = SKShapeNode()
        line.path = drawSnakeShapePath()
        line.lineWidth = 1
        line.strokeColor = .red
        addChild(line)
    }
}

// MARK: - Actions
extension GameScene {
    private func addFollowAction(_ node: SKSpriteNode) {
        let followAction = SKAction.follow(drawSnakeShapePath(), asOffset: false, orientToPath: false, duration: 20)
        node.run(followAction)
    }
}
