//
//  Direction.swift
//  ContorlSystem-SideScrollJoystick
//
//  Created by Doyoung Song on 1/21/22.
//

import UIKit

enum Direction: Int {
    
    case N, S, E, W, NE, NW, SE, SW
    
    mutating func setDirection(degree: CGFloat) {
        if degree >= 335 {
            self = .W
        } else if degree >= 290 {
            self = .NW
        } else if degree >= 245 {
            self = .N
        } else if degree >= 200 {
            self = .NE
        } else if degree >= 155 {
            self = .E
        } else if degree >= 110 {
            self = .SE
        } else if degree >= 65 {
            self = .S
        } else if degree >= 20 {
            self = .SW
        } else if degree >= 0 {
            self = .W
        }
    }
}
