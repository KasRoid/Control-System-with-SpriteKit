//
//  ViewController.swift
//  ControlSystem-Accelerometer
//
//  Created by Doyoung Song on 1/7/22.
//

import SpriteKit
import UIKit

class ViewController: UIViewController {

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = SKView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = view as? SKView else { fatalError() }
        view.showsFPS = true
        view.showsNodeCount = true
        view.ignoresSiblingOrder = true
        let scene = SKScene(fileNamed: "GameScene")
        view.presentScene(scene)
    }


}

