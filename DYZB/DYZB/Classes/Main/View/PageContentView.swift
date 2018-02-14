




//
//  PageContentView.swift
//  DYZB
//
//  Created by Macbook on 2017/11/23.
//  Copyright © 2017年 何洪涛. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    // MARK: - 定义属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?   // 强引用改成弱引用
    
    // MARK: - 懒加载属性
    private lazy var collectionView : UICollectionView = { [weak self] in    // 防止循环引用
        // 1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!   // 一定有值
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2. 创建UICollectionView
        let collecttionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collecttionView.showsHorizontalScrollIndicator = false
        collecttionView.isPagingEnabled = true  // 分页
        collecttionView.bounces = false  // 不希望超出内容
        collecttionView.dataSource = self
        collecttionView.scrollsToTop = false
//        collecttionView.delegate = self
        collecttionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collecttionView
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
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

// MARK: - 设置UI 界面    options+command+ 左右箭头折叠/展开
extension PageContentView {
    private func setupUI() {
        // 1. 将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        // 2. 添加UICollectionView ,用于在cell 中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK: - 遵守uicellectionviewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("%d", childVcs.count)
        return childVcs.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2. 设置cell 内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        
        let childVC = childVcs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        
        return cell
    }
}

// MARK: - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        let offsetX = CGFloat( currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

























