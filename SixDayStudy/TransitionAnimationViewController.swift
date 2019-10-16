

//
//  AnimationViewController.swift
//  SixDayStudy
//
//  Created by le tong on 2019/10/11.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

// 枚举
enum animationENUM {
    case rotation
    case scale
    case move
    case group
}
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

class TransitionAnimationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var animationView = UIView()
    var animationEnum: animationENUM = animationENUM.rotation
    var animtaionButton = UIButton()
    var animtaionTableView = UITableView()
    let identifier = "identifier"
    var array: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let random = arc4random() % 4
        if random == 0 {
            animationEnum = animationENUM.rotation
        }else if random == 1{
            animationEnum = animationENUM.move
        }else if random == 2{
            animationEnum = animationENUM.scale
        }else if random == 3{
            animationEnum = animationENUM.group
        }
        view.backgroundColor = UIColor.white
        array = NSArray.init(objects: "rotation","scale","move","group") as! [String]
        setCurrentUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeAnimationView()
    }
    func setCurrentUI() -> Void{
        animationView = UIView.init(frame: CGRect(x: view.frame.width / 2 - 100, y: 300, width: 200, height: 100))
        animationView.backgroundColor = UIColor.red
        view.addSubview(animationView)
        animtaionTableView = UITableView.init(frame: CGRect(x: 0, y: 500, width: view.frame.width, height: view.frame.height - 300), style: UITableView.Style.plain)
        animtaionTableView.delegate = self
        animtaionTableView.dataSource = self
        animtaionTableView.tableFooterView = UIView.init()
        animtaionTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        view.addSubview(animtaionTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.rotationAnimation()
            break
        case 1:
            self.scaleAnimation()
            break
        case 2:
            self.translationX()
            break
        case 3:
            self.groupTranslationXRotationAnimation()
            break
        default:
            break
        }
        navigationItem.title = array[indexPath.row]
    }
    
 
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
        
        
    }
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
