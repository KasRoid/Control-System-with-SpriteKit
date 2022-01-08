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
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1/60
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
                guard let data = data else { return }
                let multiplier = Float(data.acceleration.x) * 10
                let maximumX = (self.view?.bounds.width ?? 0) / 2 - self.spriteNode.size.width / 2
                let x = self.spriteNode.position.x + CGFloat(multiplier)
                guard abs(x) < maximumX else { return }
                self.spriteNode.position = CGPoint(x: x, y: self.spriteNode.position.y)
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
