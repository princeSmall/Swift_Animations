//
//  DrawEllipseAnimationView.swift
//  SixDayStudy
//
//  Created by le tong on 2019/10/14.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class DrawEllipseAnimationView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
//        绘制中心原点
        let circleBezier = UIBezierPath.init()
        circleBezier.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 5, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        UIColor.green.setFill()
        circleBezier.close()
        circleBezier.lineWidth = 1
        circleBezier.fill()
        

        // 绘制扇叶
        let ellipseView = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 5))
        ellipseView.center = CGPoint(x: 100, y: 40)
        ellipseView.backgroundColor = UIColor.white
        self.addSubview(ellipseView)
        
        let ellipseView2 = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 5))
        ellipseView2.center = CGPoint(x: 50, y: (50 + sqrt(7500)))
        ellipseView2.backgroundColor = UIColor.white
        self.addSubview(ellipseView2)
        
        let ellipseView3 = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 5))
        ellipseView3.center = CGPoint(x: 150, y: (50 + sqrt(7500)))
        ellipseView3.backgroundColor = UIColor.white
        self.addSubview(ellipseView3)
        
        let path = UIBezierPath.init(ovalIn:ellipseView.bounds)
        let pathLayer = CAShapeLayer.init()
        pathLayer.lineWidth = 1
        pathLayer.strokeColor = UIColor.green.cgColor
        pathLayer.path = path.cgPath
        pathLayer.fillColor = nil
        ellipseView.layer.addSublayer(pathLayer)
        
        let path2 = UIBezierPath.init(ovalIn:ellipseView2.bounds)
        let pathLayer2 = CAShapeLayer.init()
        pathLayer2.lineWidth = 1
        pathLayer2.strokeColor = UIColor.green.cgColor
        pathLayer2.path = path2.cgPath
        pathLayer2.fillColor = nil
        ellipseView2.layer.addSublayer(pathLayer2)
        
        let path3 = UIBezierPath.init(ovalIn:ellipseView3.bounds)
        let pathLayer3 = CAShapeLayer.init()
        pathLayer3.lineWidth = 1
        pathLayer3.strokeColor = UIColor.green.cgColor
        pathLayer3.path = path3.cgPath
        pathLayer3.fillColor = nil
        ellipseView3.layer.addSublayer(pathLayer3)
        
        UIView.animate(withDuration: 0) {
            ellipseView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2.0))
            ellipseView2.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 4.0 + (1 / 12)))
            ellipseView3.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 4.0 * 3 - (1 / 12)))
        }
        
        
        
    }
    

}
