//
//  TriggerNode.swift
//  ControlSystem-SlingShot
//
//  Created by Doyoung Song on 1/30/22.
//

import SpriteKit

class TriggerNode: SKShapeNode {
    
    override init() {
        super.init()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TriggerNode {
    private func setUI() {
        drawCircle()
        fillColor = .red
    }
    
    private func drawCircle() {
        let path = CGMutablePath()
        path.addArc(center: CGPoint.zero,
                    radius: 50,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 2,
                    clockwise: true)
        self.path = path
    }
}
