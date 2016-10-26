//
//  ViewController.swift
//  HSFloatingSegmetMenuView
//
//  Created by Hanson on 2016/10/24.
//  Copyright © 2016年 HansonStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var showingVC: UIViewController?
    var segmentMenu: SegmentMenu?
    var headView: HeaderView?
    var headerView: UIView?
    var inset: CGFloat = 240
    var headerViewHeight: CGFloat = 200
    var segmentMenuHeight: CGFloat = 40
    
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
        segmentMenu?.menuTitleArray = ["热点", "新闻", "科技"]
        segmentMenu?.delegate = self
        
        let firstVC = FirstViewController()
        self.addChildViewController(firstVC)
        
        let secondVC = SecondViewController()
        self.addChildViewController(secondVC)
        
        let thirdVC = ThirdViewController()
        self.addChildViewController(thirdVC)

        segmentMenu?.setSelectButton(index: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        let scrollView = object as? UIScrollView
        if scrollView == nil { return }
        
        let changeValues = change as! [NSKeyValueChangeKey: AnyObject]
        
        if let new = changeValues[NSKeyValueChangeKey.newKey]?.cgPointValue,
            let old = changeValues[NSKeyValueChangeKey.oldKey]?.cgPointValue {
            
            let diff = new.y - old.y
            
            print("new.y" + "\(new.y)")
            print("old.y" + "\(old.y)")
            print(diff)
            
            if new.y >= 200 {
                if headView?.superview != self.view {
                    self.view?.addSubview(headView!)
                    headView?.frame.origin.y = -headerViewHeight
                }
                for (key, _) in offSetDic {
                    if key == scrollView?.tag {
                        offSetDic[key] = new.y
                    } else if offSetDic[key]! <= headerViewHeight {
                        offSetDic[key] = headerViewHeight
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
        showingVC?.view.removeFromSuperview()
        let selectedVC: BasicTableViewController = self.childViewControllers[index] as! BasicTableViewController
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
        if offSet! < headerViewHeight {
            selectedVC.tableView?.addSubview(headView!)
            headView?.frame.origin.y = 0
        } else {
            self.view.addSubview(headView!)
            headView?.frame.origin.y = -headerViewHeight
        }
        showingVC = selectedVC
    }
}

