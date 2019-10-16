//
//  KeyFrameAnimationViewController.swift
//  SixDayStudy
//
//  Created by le tong on 2019/10/14.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class KeyFrameAnimationViewController: UIViewController {
    
    let bezierPath = UIBezierPath.init()
    var animationView = DrawAnimationView()
    var baseAnimation = CABasicAnimation()
    var ellipseView = DrawEllipseAnimationView()
    var circleView = DrawCircleAnimationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        animationView = DrawAnimationView.init(frame: CGRect(x: view.frame.width / 2.0 - 100, y: 200, width: 200, height: 250))
        animationView.backgroundColor = UIColor.white
        view.addSubview(animationView)
        self.animationPosition(value: 0.3)
        
        ellipseView = DrawEllipseAnimationView.init(frame: CGRect(x: view.frame.width / 2.0 - 100, y: 500, width:200, height: 200))
        ellipseView.backgroundColor = UIColor.clear
        
        circleView = DrawCircleAnimationView.init(frame: CGRect(x: view.frame.width / 2.0 - 100, y: 530, width:200, height: 200))
        circleView.backgroundColor = UIColor.clear
        self.view.addSubview(circleView)
        
        self.view.addSubview(ellipseView)
        
        self.drawAnimation()
        
        // Do any additional setup after loading the view.
    }
    
    func drawAnimation() -> Void {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat(Double.pi * 2)
        animation.duration = 3.0
        animation.autoreverses = false;
        animation.fillMode = CAMediaTimingFillMode.forwards;
        animation.repeatCount = MAXFLOAT;
        self.ellipseView.layer.add(animation, forKey: nil)
    }
    
    func animationPosition(value: CGFloat) -> Void {
        //        添加动画
        baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.duration = 2   //持续时间
        baseAnimation.fromValue = 0  //开始值
        baseAnimation.toValue = value   //结束值
        //        保持运动后的位置不变
        baseAnimation.isRemovedOnCompletion = false
        baseAnimation.fillMode = CAMediaTimingFillMode.forwards
        animationView.shapeLayer.add(baseAnimation, forKey: "strokeEndAnimation")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
