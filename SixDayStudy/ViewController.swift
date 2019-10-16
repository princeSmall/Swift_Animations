//
//  ViewController.swift
//  SixDayStudy
//
//  Created by le tong on 2019/10/11.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var animationTableView = UITableView()
    let identifier = "identifier"
    let headerHeight: CGFloat = 50
    let duration = 1.5
    var modelArray: [String] = NSArray.init(objects: "transformAnimation","BasicAnimation","SimpleAnimation","KeyFrameAnimation","5","6","7","8") as! [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Animation"
        setCurrentAnimationTableView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetAnimateTableViewCell()
    }
    
    func setCurrentAnimationTableView() -> Void {
        animationTableView = UITableView.init(frame: view.bounds, style: UITableView.Style.plain)
        animationTableView.delegate = self
        animationTableView.dataSource = self
        animationTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        animationTableView.tableFooterView = UIView()
        view.addSubview(animationTableView)
    }
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView.init()
        let headLabel = UILabel.init(frame: CGRect(x: 20, y: 0, width: view.frame.width, height: headerHeight))
        headLabel.text = "AnimationsShow"
        headView.addSubview(headLabel)
        return headView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell.init()
        cell.textLabel?.text = modelArray[indexPath.item]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(TransitionAnimationViewController.init(), animated: true)
        }else if indexPath.row == 1 {
            self.navigationController?.pushViewController(BasicAnimationViewController.init(), animated: true)
        }else if indexPath.row == 2 {
            self.navigationController?.pushViewController(SimpleAniamtionViewController.init(), animated: true)
        }else if indexPath.row == 3 {
            self.navigationController?.pushViewController(KeyFrameAnimationViewController.init(), animated: true)
        }
        
        
    }

}

