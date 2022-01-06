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
        let gameScene = SKScene(fileNamed: "GameScene")
        view.presentScene(gameScene)
    }
}

