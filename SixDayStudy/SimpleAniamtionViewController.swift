//
//  SimpleAniamtionViewController.swift
//  SixDayStudy
//
//  Created by le tong on 2019/10/14.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class SimpleAniamtionViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var animationView = UIView()
    var animtaionTableView = UITableView()
    let identifier = "identifier"
    var array:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setCurrentArray()
        animationView = UIView.init(frame: CGRect(x: view.frame.width / 2 - 50, y: 100, width: 100, height: 100))
        animationView.backgroundColor = UIColor.red
        view.addSubview(animationView)
        animtaionTableView = UITableView.init(frame: CGRect(x: 0, y: 400, width: view.frame.width, height: view.frame.height - 300), style: UITableView.Style.plain)
        animtaionTableView.delegate = self
        animtaionTableView.dataSource = self
        animtaionTableView.tableFooterView = UIView.init()
        animtaionTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        view.addSubview(animtaionTableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "复原", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightButtonItem))
        
        // Do any additional setup after loading the view.
    }
    @objc func rightButtonItem() -> Void{
        UIView.animate(withDuration: 1.0) {
            self.animationView.frame = CGRect(x: self.view.frame.width / 2 - 50, y: 100, width: 100, height: 100)
            self.animationView.alpha = 1.0
            self.animationView.backgroundColor = UIColor.red
        }
    }
    func setCurrentArray() -> Void {
        array = NSArray.init(objects: "向右移动100","向下移动100","宽度变大100","高度变大100","组合移动+变大","组合移动+变小","变淡消失","背景色修改") as! [String]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
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
    func animationAlpha(alpha: CGFloat) -> Void {
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.alpha = alpha
        }) { (success) in
//            alpha变0 就要去移除view
//            self.animationView.removeFromSuperview()
        }
    }
    func animationBackgroundColor(color: UIColor) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.animationView.backgroundColor = color
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        cell.textLabel?.text = array[indexPath.item]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            animation(x: 100, y: 0, width: 0, height: 0)
            break
        case 1:
            animation(x: 0, y: 100, width: 0, height: 0)
            break
        case 2:
            animation(x: 0, y: 0, width: 100, height: 0)
            break
        case 3:
            animation(x: 0, y: 0, width: 0, height: 100)
            break
        case 4:
            animation(x: 100, y: 100, width: 100, height: 100)
            break
        case 5:
            animation(x: 100, y: 100, width: 0, height: 0)
            break
        case 6:
            animationAlpha(alpha: 0)
        case 7:
            animationBackgroundColor(color: UIColor.green)
        default:
            break
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
