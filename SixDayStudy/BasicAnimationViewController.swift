//
//  BasicAnimationViewController.swift
//  SixDayStudy
//
//  Created by le tong on 2019/10/12.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class BasicAnimationViewController: UIViewController ,CAAnimationDelegate,UITableViewDelegate,UITableViewDataSource{
    
    

    var animationView = UIView()
    var animtaionTableView = UITableView()
    let identifier = "identifier"
    var array:[String] = []
    var animation = CABasicAnimation()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setCurrentArray()
        animationView = UIView.init(frame: CGRect(x: view.frame.width / 2 - 100, y: 100, width: 200, height: 100))
        animationView.backgroundColor = UIColor.red
        view.addSubview(animationView)
        animtaionTableView = UITableView.init(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: view.frame.height - 300), style: UITableView.Style.plain)
        animtaionTableView.delegate = self
        animtaionTableView.dataSource = self
        animtaionTableView.tableFooterView = UIView.init()
        animtaionTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        view.addSubview(animtaionTableView)
        // Do any additional setup after loading the view.
    }
    
    func setCurrentArray() -> Void {
        array = NSArray.init(objects: "rotation.x","rotation.y","rotation.z","position","opacity","backgroundColor","scale","scale.x","scale.y","bound") as! [String]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        cell.textLabel?.text = array[indexPath.item]
        return cell
    }
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
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationView.layer.removeAllAnimations()
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
