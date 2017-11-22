
//
//  PageTitleView.swift
//  DYZB
//
//  Created by Macbook on 2017/11/23.
//  Copyright © 2017年 何洪涛. All rights reserved.
//

import UIKit

class PageTitleView: UIView {

    // MARK: - 定义属性
    private var titles : [String]
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
    }
    
    // 重写 或者 自定义 构造函数   required  coder 必须 有
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
