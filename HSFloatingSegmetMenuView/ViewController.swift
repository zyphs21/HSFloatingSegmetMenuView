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
            
//            let diff = new.y - old.y
            
            print("new.y" + "\(new.y)")
            print("old.y" + "\(old.y)")
            //            dPrint(diff)
            
            if new.y <= 200 {
                tableViewOffSet = new.y
                if headView?.superview != scrollView {
                    scrollView?.addSubview(headView!)
                    headView?.frame.origin.y = 0
                }
            } else {
                tableViewOffSet = new.y
                if headView?.superview != self.view {
                    self.view?.addSubview(headView!)
                    headView?.frame.origin.y = -200
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
            selectedVC.tableView?.addObserver(self, forKeyPath: "contentOffset",
                                              options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old],
                                              context: nil)
            if (selectedVC.view.superview == nil){
                self.view.addSubview(selectedVC.view)
            }
            if tableViewOffSet <= 200 {
                selectedVC.tableView?.addSubview(headView!)
                headView?.frame.origin.y = 0
            } else {
                self.view.addSubview(headView!)
                headView?.frame.origin.y = -200
            }
            selectedVC.tableView?.setContentOffset(CGPoint(x: 0, y: tableViewOffSet), animated: false)
            self.view.bringSubview(toFront: selectedVC.view)
        case 1:
            let selectedVC: SecondViewController = self.childViewControllers[index] as! SecondViewController
            selectedVC.view.frame = self.view.bounds
            selectedVC.tableView?.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: inset))
            selectedVC.tableView?.addObserver(self, forKeyPath: "contentOffset",
                                              options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old],
                                              context: nil)
            if (selectedVC.view.superview == nil){
                selectedVC.view.frame = self.view.bounds
                self.view.addSubview(selectedVC.view)
            }
            if tableViewOffSet <= 200 {
                selectedVC.tableView?.addSubview(headView!)
                headView?.frame.origin.y = 0
            } else {
                self.view.addSubview(headView!)
                headView?.frame.origin.y = -200
            }
            selectedVC.tableView?.setContentOffset(CGPoint(x: 0, y: tableViewOffSet), animated: false)
            self.view.bringSubview(toFront: selectedVC.view)
        case 2:
            let selectedVC: ThirdViewController = self.childViewControllers[index] as! ThirdViewController
            selectedVC.view.frame = self.view.bounds
            selectedVC.tableView?.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: inset))
            selectedVC.tableView?.addObserver(self, forKeyPath: "contentOffset",
                                              options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old],
                                              context: nil)
            if (selectedVC.view.superview == nil){
                selectedVC.view.frame = self.view.bounds
                self.view.addSubview(selectedVC.view)
            }
            if tableViewOffSet <= 200 {
                selectedVC.tableView?.addSubview(headView!)
                headView?.frame.origin.y = 0
            } else {
                self.view.addSubview(headView!)
                headView?.frame.origin.y = -200
            }
            selectedVC.tableView?.setContentOffset(CGPoint(x: 0, y: tableViewOffSet), animated: false)
            self.view.bringSubview(toFront: selectedVC.view)
        default: break
            
        }
        
    }
}

