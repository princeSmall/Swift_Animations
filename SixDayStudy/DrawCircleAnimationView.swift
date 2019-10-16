

//
//  DrawCircleAnimationView.swift
//  SixDayStudy
//
//  Created by le tong on 2019/10/14.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class DrawCircleAnimationView: UIView {

   
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let circleBezier = UIBezierPath.init()
        circleBezier.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 100, startAngle: CGFloat(Double.pi / 2.0 - 0.1), endAngle: CGFloat(Double.pi / 2.0 + 0.1), clockwise: true)
        UIColor.green.setStroke()
        circleBezier.addLine(to: CGPoint(x: 100, y: 100))
        circleBezier.close()
        circleBezier.lineWidth = 1
        circleBezier.stroke()

    }


}
