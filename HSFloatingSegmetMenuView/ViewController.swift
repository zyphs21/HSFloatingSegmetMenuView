//
//  ViewController.swift
//  HSFloatingSegmetMenuView
//
//  Created by Hanson on 2016/10/24.
//  Copyright © 2016年 HansonStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var segmentMenu: SegmentMenu?
    var headView: HeaderView?
    var headerView: UIView?
    var inset: CGFloat = 240
    var tableViewOffSet: CGFloat = 0
    var observing = true
    lazy var offSetDic: [Int: CGFloat] = {
        var dic: [Int: CGFloat] = [:]
        for index in 0 ..< self.childViewControllers.count {
            dic[index] = CGFloat.leastNormalMagnitude
        }
        return dic
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        headView = HeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: inset))
        segmentMenu = headView?.segmentMenu
        segmentMenu?.menuTitleArray = ["动态", "新闻", "公告"]
        segmentMenu?.delegate = self
        
        let firstVC = FirstViewController()
        firstVC.title = "动态"
        self.addChildViewController(firstVC)
        
        let secondVC = SecondViewController()
        secondVC.title = "新闻"
        self.addChildViewController(secondVC)

        
        let thirdVC = ThirdViewController()
        thirdVC.title = "公告"

        self.addChildViewController(thirdVC)

        segmentMenu?.setSelectButton(index: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if !observing { return }
        
        let scrollView = object as? UIScrollView
        if scrollView == nil { return }
        if scrollView == self.view {
            return
        }
        
        let changeValues = change as! [NSKeyValueChangeKey: AnyObject]
        
        if let new = changeValues[NSKeyValueChangeKey.newKey]?.cgPointValue,
            let old = changeValues[NSKeyValueChangeKey.oldKey]?.cgPointValue {
            
            let diff = new.y - old.y
            
            print("new.y" + "\(new.y)")
            print("old.y" + "\(old.y)")
            print(diff)
            
            if new.y > 200 {
                if headView?.superview != self.view {
                    self.view?.addSubview(headView!)
                    headView?.frame.origin.y = -200
                }
                for (key, _) in offSetDic {
                    if key == scrollView?.tag {
                        offSetDic[key] = new.y
                    } else if offSetDic[key]! <= CGFloat(200) {
                        offSetDic[key] = 200
                    }
                }
            } else {
                for (key, _) in offSetDic {
                    offSetDic[key] = new.y
                }
                if headView?.superview != scrollView {
                    scrollView?.addSubview(headView!)
                    headView?.frame.origin.y = 0
                }
            }
            
        }
    }
    
}


extension ViewController: SegmentMenuDelegate {
    func menuButtonDidClick(index: Int) {
        switch index {
        case 0:
            let selectedVC: FirstViewController = self.childViewControllers[index] as! FirstViewController
            selectedVC.view.frame = self.view.bounds
            selectedVC.tableView?.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: inset))
            selectedVC.tableView?.tag = index
            selectedVC.tableView?.addObserver(self, forKeyPath: "contentOffset",
                                              options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old],
                                              context: nil)
            if (selectedVC.view.superview == nil){
                self.view.addSubview(selectedVC.view)
            }
            
            let offSet = offSetDic[(selectedVC.tableView?.tag)!]
            selectedVC.tableView?.contentOffset = CGPoint(x: 0, y: offSet!)
            if tableViewOffSet <= 200 {
                selectedVC.tableView?.addSubview(headView!)
                headView?.frame.origin.y = 0
            } else {
                self.view.addSubview(headView!)
                headView?.frame.origin.y = -200
            }
            self.view.bringSubview(toFront: selectedVC.view)
        case 1:
            let selectedVC: SecondViewController = self.childViewControllers[index] as! SecondViewController
            selectedVC.view.frame = self.view.bounds
            selectedVC.tableView?.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: inset))
            selectedVC.tableView?.tag = index
            selectedVC.tableView?.addObserver(self, forKeyPath: "contentOffset",
                                              options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old],
                                              context: nil)
            if (selectedVC.view.superview == nil){
                self.view.addSubview(selectedVC.view)
            }
            let offSet = offSetDic[(selectedVC.tableView?.tag)!]
            selectedVC.tableView?.contentOffset = CGPoint(x: 0, y: offSet!)
            if tableViewOffSet <= 200 {
                selectedVC.tableView?.addSubview(headView!)
                headView?.frame.origin.y = 0
            } else {
                self.view.addSubview(headView!)
                headView?.frame.origin.y = -200
            }
            self.view.bringSubview(toFront: selectedVC.view)
        case 2:
            let selectedVC: ThirdViewController = self.childViewControllers[index] as! ThirdViewController
            selectedVC.view.frame = self.view.bounds
            selectedVC.tableView?.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: inset))
            selectedVC.tableView?.tag = index
            selectedVC.tableView?.addObserver(self, forKeyPath: "contentOffset",
                                              options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old],
                                              context: nil)
            if (selectedVC.view.superview == nil){
                self.view.addSubview(selectedVC.view)
            }
            let offSet = offSetDic[(selectedVC.tableView?.tag)!]
            selectedVC.tableView?.contentOffset = CGPoint(x: 0, y: offSet!)
            if tableViewOffSet <= 200 {
                selectedVC.tableView?.addSubview(headView!)
                headView?.frame.origin.y = 0
            } else {
                self.view.addSubview(headView!)
                headView?.frame.origin.y = -200
            }
            self.view.bringSubview(toFront: selectedVC.view)
        default: break
            
        }
        
    }
}

