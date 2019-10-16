//
//  DrawAnimationView.swift
//  SixDayStudy
//
//  Created by le tong on 2019/10/14.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class DrawAnimationView: UIView {
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    let bezierPath = UIBezierPath.init()
    let shapeLayer = CAShapeLayer.init()
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let radius = rect.width / 2.0 - 20        //确定半径
//        绘制圆弧
        bezierPath.addArc(withCenter: CGPoint(x: 100, y: 100), radius: radius, startAngle: CGFloat(0.25 + Double.pi / 2.0), endAngle:CGFloat(2 * Double.pi + Double.pi / 2.0 - 0.25), clockwise: true)
        bezierPath.lineWidth = 5
        UIColor.red.setStroke()      // 设置路径颜色
        bezierPath.stroke()
//        绘制添加动画路径蒙层
        shapeLayer.lineWidth = 5
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.path = bezierPath.cgPath
        layer.addSublayer(shapeLayer)
    }
 

}
