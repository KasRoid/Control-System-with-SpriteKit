//
//  ViewController.swift
//  ControlSystem-Gesture
//
//  Created by Doyoung Song on 1/12/22.
//

import SpriteKit
import UIKit

class ViewController: UIViewController {

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
