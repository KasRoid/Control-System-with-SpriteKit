//
//  ViewController.swift
//  ControlSystem-VirtualJoystick
//
//  Created by Doyoung Song on 1/17/22.
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
        let scene = SKScene(fileNamed: "GameScene")
        view.presentScene(scene)
    }
}
