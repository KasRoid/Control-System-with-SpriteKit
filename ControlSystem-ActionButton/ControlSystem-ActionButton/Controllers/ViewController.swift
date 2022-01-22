//
//  ViewController.swift
//  ControlSystem-ActionButton
//
//  Created by Doyoung Song on 1/21/22.
//

import SpriteKit
import UIKit

class ViewController: UIViewController {

    // MARK: - Lifecycle
    override func loadView() {
        view = SKView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = view as? SKView else { return }
        view.showsNodeCount = true
        view.showsPhysics = true
        let scene = SKScene(fileNamed: "GameScene")
        view.presentScene(scene)
    }
}
