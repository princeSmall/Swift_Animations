# Swift_Animations

#### 首页TableViewCellAnimation
```
//    cell动画
    func SetAnimateTableViewCell() -> Void {
        animationTableView.reloadData()
        let cells = animationTableView.visibleCells
        let tableHeight = animationTableView.bounds.size.height
        // 把cell移到最底部，
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        // 从底部动画上来
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: duration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }

```

#### TransformAnimation

##### 放射变换

```
/*****
                      1(a)   0(b)   0
 
 仿射变换  transform:  0(c)   1(d)   0
 
                      0(tx)  0(ty)  1
 
 CGAffineTransformMake(a, b, c, d, tx, ty)
 默认值   CGAffineTransformMake(1, 0, 0, 1,  0,  0);
 
 1. a 对应width变化
 2. d 对应height变化
 3. b 对应向上变形旋转
 4. c 对应向下变形旋转
 5. x x方向移动，左-右+
 6. y y方向移动，上-下+
 ******/
```
##### 使用枚举写了一个进入的随机动画

```

func makeAnimationView() -> Void {
        switch animationEnum {
        case .rotation:
            self.rotationAnimation()
            break
        case .scale:
            self.scaleAnimation()
            break
        case .move:
            self.translationX()
            break
        case .group:
            self.groupTranslationXRotationAnimation()
            break
            
        }
               
```

##### 动画类型

```
       //    移动动画
    func translationX() -> Void {
        UIView.animate(withDuration: 2.0, animations: {
            self.animationView.transform = CGAffineTransform(translationX: 100, y: -200)
            //            同理可以写成
            //            self.animationView.transform = CGAffineTransform.init(a: 1, b: 0, c: 0, d: 1, tx: 100, ty: -200)
        }) { (success) in
            self.animationView.transform = CGAffineTransform.identity
        }
    }
    //    伸缩动画
    func scaleAnimation() -> Void {
        UIView.animate(withDuration: 2, animations: {
            self.animationView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            //            同理可以写成
            //            self.animationView.transform = CGAffineTransform.init(a: 0.0001, b: 0, c: 0, d: 0.0001, tx: 0, ty: 0)
        }) { (success) in
            self.animationView.transform = CGAffineTransform.identity
        }
    }
    //    旋转动画
    func rotationAnimation() -> Void {
        //        1. 在block里。实例话对象要加self
        //        2. initialSpringVelocity则表示初始的速度，数值越大一开始移动越快。
        //        3. usingSpringWithDamping的范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显。
        //        4. CGAffineTransform.identity恢复初始状态
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            /* Return a transform which rotates by `angle' radians:
             t' = [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] */
            //            同理可以写成
            self.animationView.transform = CGAffineTransform.init(a: CGFloat(cos(Double.pi)), b: CGFloat(sin(Double.pi)), c: -CGFloat(sin(Double.pi)), d: CGFloat(cos(Double.pi)), tx: 0, ty: 0)
//            self.animationView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }) { (success) in
            self.animationView.transform = CGAffineTransform.identity
        }
    }
    //    移动 + 旋转
    func groupTranslationXRotationAnimation() -> Void {
        
        UIView.animate(withDuration: 2, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.animationView.transform = CGAffineTransform.init(a: 0.0001, b: 0, c: 0, d: 0.0001, tx: 100, ty: -200)
        }) { (success) in
            self.animationView.transform = CGAffineTransform.identity
        }
    }

```
#### BasicAnimation

```
/** 
  相对比较简单，设置keypath就行了
**/
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            animation = CABasicAnimation.init(keyPath: "transform.rotation.x")
            animation.toValue = 2 * Double.pi
            break
        case 1:
            animation = CABasicAnimation.init(keyPath: "transform.rotation.y")
            animation.toValue = 2 * Double.pi
            break
        case 2:
            animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
            animation.toValue = 2 * Double.pi
            break
        case 3:
            animation = CABasicAnimation.init(keyPath: "position")
            animation.toValue = NSValue.init(cgPoint: CGPoint.init(x: animationView.center.x + 100, y: animationView.center.y - 200))
            break
        case 4:
            animation = CABasicAnimation.init(keyPath: "opacity")
            animation.toValue = 0.1
            break
        case 5:
            animation = CABasicAnimation.init(keyPath: "backgroundColor")
            animation.toValue = UIColor.green.cgColor;
            break
        case 6:
            animation = CABasicAnimation.init(keyPath: "transform.scale")
            animation.toValue = 0.1
            break
        case 7:
            animation = CABasicAnimation.init(keyPath: "transform.scale.x")
            animation.toValue = 0.1
            break
        case 8:
            animation = CABasicAnimation.init(keyPath: "transform.scale.y")
            animation.toValue = 0.1
            break
        case 9:
            animation = CABasicAnimation.init(keyPath: "bounds")
            animation.toValue = NSValue.init(cgRect: CGRect(x: animationView.frame.origin.x, y: animationView.frame.origin.y, width: 0.001, height: 0.001))
            break
            
        default:
            break
        }
        animation.delegate = self
        animation.duration = 1.0
        animation.autoreverses = true
        animationView.layer.add(animation, forKey: "basicAnimation")
```

#### SimpleAnimation

```
@objc func rightButtonItem() -> Void{
        UIView.animate(withDuration: 1.0) {
            self.animationView.frame = CGRect(x: self.view.frame.width / 2 - 50, y: 100, width: 100, height: 100)
            self.animationView.alpha = 1.0
            self.animationView.backgroundColor = UIColor.red
        }
    }
 
 <!--动画改变视图的x,y,width,height-->   
    func animation(x: CGFloat,y: CGFloat, width: CGFloat, height: CGFloat) -> Void {
        UIView.animate(withDuration: 1.0) {
            var rect = self.animationView.frame
            rect.origin.x += x
            rect.origin.y += y
            rect.size.width += width
            rect.size.height += height
            self.animationView.frame = rect
        };
    }
    <!--动画改变视图的alpha-->
    func animationAlpha(alpha: CGFloat) -> Void {
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.alpha = alpha
        }) { (success) in
//            alpha变0 就要去移除view
//            self.animationView.removeFromSuperview()
        }
    }
    <!--动画改变视图的color-->
    func animationBackgroundColor(color: UIColor) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.animationView.backgroundColor = color
        }
    }
```

#### keyFrameAnimation

```
   <!--扇页旋转-->
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
    
 <!--弧形动效-->
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
```


##### 圆弧动效

```
 let bezierPath = UIBezierPath.init()
    let shapeLayer = CAShapeLayer.init()
    
    <!--有些属性必须要在draw 方法里才能生效-->
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
```

##### 扇页动效

```
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
    
```

##### 扇形

```
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
```