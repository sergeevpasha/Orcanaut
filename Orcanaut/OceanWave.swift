//
//  OceanWaves.swift
//  Orcanaut
//
//  Created by Pavel Sergeev on 10.10.2022.
//

import SwiftUI

struct OceanWave {
    let universalSize = UIScreen.main.bounds
    
    var interval: CGFloat
    var amplitude: CGFloat = 100
    var baseline: CGFloat
    
    func path() -> Path {
        Path{path in
            path.move(to: CGPoint(x: 0, y: baseline))
            path.addCurve(
                to: CGPoint(x: 1*interval,y: baseline),
                control1: CGPoint(x: interval * (0.35),y: amplitude + baseline),
                control2: CGPoint(x: interval * (0.65),y: -amplitude + baseline)
            )
            path.addCurve(
                to: CGPoint(x: 2*interval,y: baseline),
                control1: CGPoint(x: interval * (1.35),y: amplitude + baseline),
                control2: CGPoint(x: interval * (1.65),y: -amplitude + baseline)
            )
            path.addLine(to: CGPoint(x: 2*interval, y: universalSize.height))
            path.addLine(to: CGPoint(x: 0, y: universalSize.height))
        }
    }
}
