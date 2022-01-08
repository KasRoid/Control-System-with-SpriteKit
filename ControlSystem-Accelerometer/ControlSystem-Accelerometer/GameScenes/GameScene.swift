//
//  GameScene.swift
//  ControlSystem-Accelerometer
//
//  Created by Doyoung Song on 1/7/22.
//

import CoreMotion
import SpriteKit

class GameScene: SKScene {
    
    private let motionManager = CMMotionManager()
    
    private var spriteNode: SKSpriteNode!
    private var yOffset: Float = 0
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        backgroundColor = .black
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addShipNode()
        setAccelerometer()
    }
}

// MARK: - Accelerometer
extension GameScene {
    private func setAccelerometer() {
        guard motionManager.isAccelerometerAvailable else { return }
        motionManager.accelerometerUpdateInterval = 1/60
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
            guard let data = data else { return }
            let additionValueForX = Float(data.acceleration.x) * 10
            let maximumX = (self.view?.bounds.width ?? 0) / 2 - self.spriteNode.size.width / 2
            let newX = self.spriteNode.position.x + CGFloat(additionValueForX)
            
            if abs(newX) < maximumX {
                self.spriteNode.position = CGPoint(x: newX, y: self.spriteNode.position.y)
            }
            
            let additionValueForY = Float(data.acceleration.y) * 10
            if self.yOffset == 0 {
                self.yOffset = additionValueForY
            }
            let maximumY = (self.view?.bounds.height ?? 0) / 2 - self.spriteNode.size.height / 2
            let newY = self.spriteNode.position.y + CGFloat(additionValueForY) - CGFloat(self.yOffset)
            print(additionValueForY, CGFloat(additionValueForY) - CGFloat(self.yOffset))
            
            if abs(newY) < maximumY {
                self.spriteNode.position = CGPoint(x: self.spriteNode.position.x, y: newY)
            }
        }
    }
}

// MARK: - UI
extension GameScene {
    private func addShipNode() {
        spriteNode = SKSpriteNode(imageNamed: "ship")
        spriteNode.xScale = 0.3
        spriteNode.yScale = 0.3
        addChild(spriteNode!)
    }
}
