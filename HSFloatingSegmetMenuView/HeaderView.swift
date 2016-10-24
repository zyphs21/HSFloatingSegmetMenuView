//
//  HeaderView.swift
//  HSFloatingSegmetMenuView
//
//  Created by Hanson on 2016/10/24.
//  Copyright © 2016年 HansonStudio. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    var view: UIView!
    var segmentMenu: SegmentMenu!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        view.backgroundColor = UIColor.cyan
        segmentMenu = SegmentMenu(frame: CGRect(x: 0, y: view.frame.maxY, width: UIScreen.main.bounds.width, height: 40))
        
        self.addSubview(view)
        self.addSubview(segmentMenu)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

