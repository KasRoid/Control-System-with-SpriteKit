//
//  PlatformNode.swift
//  ControlSystem-SlingShot
//
//  Created by Doyoung Song on 2/2/22.
//

import SpriteKit

class PlatformNode: SKNode {
    
    private var nodes: [SKSpriteNode] = []
    
    var totalSize: CGSize {
        var width: CGFloat = 0
        nodes.forEach { width += $0.size.width }
        return CGSize(width: width, height: nodes.first?.frame.size.height ?? 0)
    }
    
    var nodeSize: CGSize {
        return CGSize(width: nodes.first?.frame.size.width ?? 0,
                      height: nodes.first?.frame.size.height ?? 0)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(numberOfNodes: Int) {
        self.init()
        createNodes(numberOfNodes)
        locateNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlatformNode {
    private func createNodes(_ numberOfNodes: Int) {
        for _ in 1...numberOfNodes {
            let node = SKSpriteNode(imageNamed: "Platform")
            nodes.append(node)
        }
    }
    
    private func locateNodes() {
        var xPosition: CGFloat = 0
        nodes.forEach {
            $0.position = CGPoint(x: xPosition, y: 0)
            addChild($0)
            xPosition += $0.frame.width
        }
    }
}
