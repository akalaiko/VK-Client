//
//  CloudBezierPath.swift
//  MyHomeworkApp
//
//  Created by Tim on 26.01.2022.
//

import Foundation
import UIKit

extension UIBezierPath {
    static func cloud() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 87.75, y: 46.01))
        path.addCurve(to: CGPoint(x: 68.15, y: 30.04), controlPoint1: CGPoint(x: 85.94, y: 36.94), controlPoint2: CGPoint(x: 77.95, y: 30.04))
        path.addCurve(to: CGPoint(x: 59.44, y: 32.22), controlPoint1: CGPoint(x: 64.88, y: 30.04), controlPoint2: CGPoint(x: 61.98, y: 30.77))
        path.addCurve(to: CGPoint(x: 37.3, y: 19.15), controlPoint1: CGPoint(x: 55.08, y: 24.23), controlPoint2: CGPoint(x: 46.74, y: 19.15))
        path.addCurve(to: CGPoint(x: 11.89, y: 44.56), controlPoint1: CGPoint(x: 23.14, y: 19.15), controlPoint2: CGPoint(x: 11.89, y: 30.4))
        path.addCurve(to: CGPoint(x: 11.89, y: 46.01), controlPoint1: CGPoint(x: 11.89, y: 44.92), controlPoint2: CGPoint(x: 11.89, y: 45.65))
        path.addCurve(to: CGPoint(x: 1.0, y: 62.7), controlPoint1: CGPoint(x: 5.36, y: 48.91), controlPoint2: CGPoint(x: 1.0, y: 55.08))
        path.addCurve(to: CGPoint(x: 19.15, y: 80.85), controlPoint1: CGPoint(x: 1.0, y: 72.86), controlPoint2: CGPoint(x: 8.99, y: 80.85))
        path.addLine(to: CGPoint(x: 80.85, y: 80.85))
        path.addCurve(to: CGPoint(x: 99.0, y: 62.7), controlPoint1: CGPoint(x: 91.01, y: 80.85), controlPoint2: CGPoint(x: 99.0, y: 72.87))
        path.addCurve(to: CGPoint(x: 87.75, y: 46.01), controlPoint1: CGPoint(x: 99.0, y: 55.08), controlPoint2: CGPoint(x: 94.28, y: 48.55))
        path.close()
        return path
        
    }
}
