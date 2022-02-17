//
//  WorldNode.swift
//  ControlSystem-SlingShot
//
//  Created by Doyoung Song on 2/16/22.
//

import SpriteKit

class WorldNode: SKNode {
    
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
    
    init(numberOfNodes: Int) {
        super.init()
        createNodes(numberOfNodes)
        locateNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WorldNode {
    private func createNodes(_ numberOfNodes: Int) {
        for _ in 1...numberOfNodes {
            let node = SKSpriteNode(imageNamed: "Background")
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
