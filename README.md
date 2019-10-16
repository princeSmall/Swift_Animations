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