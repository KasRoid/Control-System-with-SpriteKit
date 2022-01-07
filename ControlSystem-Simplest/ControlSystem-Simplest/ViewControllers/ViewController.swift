//
//  ViewController.swift
//  ControlSystem-Simplest
//
//  Created by Doyoung Song on 1/6/22.
//

import SpriteKit
import UIKit

class ViewController: UIViewController {

    // MARK: - Lifecycle
    override func loadView() {
        view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = view as? SKView else { fatalError() }
        view.showsFPS = true
        view.showsNodeCount = true
        view.ignoresSiblingOrder = true
        let gameScene = SKScene(fileNamed: "GameScene")
        gameScene?.size = view.bounds.size
        view.presentScene(gameScene)
    }
}

