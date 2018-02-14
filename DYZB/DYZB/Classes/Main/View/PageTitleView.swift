
//
//  PageTitleView.swift
//  DYZB
//
//  Created by Macbook on 2017/11/23.
//  Copyright © 2017年 何洪涛. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {  // class 只能被类遵守
    func pageTitleView(titleView : PageTitleView , selectdInedx index : Int) // 定义协议
}

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    // MARK: - 定义属性
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    // MARK: - 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
//        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    // MARK : - 懒加载scrollView 底线
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置UI  界面
        setupUI()
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


// MARK: - 设置UI界面
extension PageTitleView {
    
    private func setupUI() {
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2. 添加title 对应的Label
        setupTitleLabel()
        
        // 3. 设置底线和滚动的滑块
        setupButtomMenuAndScrollLine()
    }
    
    private func setupTitleLabel() {
        
        // 0. 确定label的一些frame 的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 1.创建 UILabel
            let label = UILabel()
            
            // 2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            
            // 3. 设置label 的 frame
     
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4. 将 label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5. 给Label 添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupButtomMenuAndScrollLine() {
        // 1. 创建底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2. 添加scrollLine
        // 2.1 获取第一个Label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        
        // 2.2 设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}

// MARK: - 监听Label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        
        // 1. 获取当前Label的下标值
        guard let currentLabel = tapGes.view as?  UILabel else {
            return
        }
        
        // 2. 获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        // 3. 切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        // 4. 保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 5. 滚动条位置发生改变
        let scrollLinePositionX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePositionX
        }
        
        // 6. 通知代理
        delegate?.pageTitleView(titleView: self, selectdInedx: currentIndex)
        
        print("titleLabelClick")
    }
}
























































