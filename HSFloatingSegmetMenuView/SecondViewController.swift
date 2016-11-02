//
//  SecondViewController.swift
//  HSFloatingSegmetMenuView
//
//  Created by Hanson on 2016/10/24.
//  Copyright © 2016年 HansonStudio. All rights reserved.
//

import UIKit

class SecondViewController: BasicTableViewController {

//    var tableView: UITableView?
    let cellIdentifier = "UITableViewCell"
    lazy var testArray: [String] = {
        var array: [String] = []
        for i in 1...35 {
            array.append("2-" + "\(i)")
        }
        return array
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableView?.backgroundColor = UIColor.white
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 30
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.tableFooterView = UIView()
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.view.addSubview(tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = testArray[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
