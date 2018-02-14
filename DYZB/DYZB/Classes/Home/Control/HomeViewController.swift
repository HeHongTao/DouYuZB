//
//  HomeViewController.swift
//  DYZB
//
//  Created by Macbook on 2017/11/12.
//  Copyright © 2017年 何洪涛. All rights reserved.
//

import UIKit
import Foundation


private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK: - 懒加载属性
    private lazy var pageTitleView : PageTitleView = { [weak self] in
    

        let titleFrame = CGRect(x: 0, y:kStatusBarH + kNavigationBarH , width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "去玩"];
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.purple
        titleView.delegate = self
        return titleView
    }()  // 闭包创建
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        // 1. 确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2. 确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
            print("1")
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        return contentView
    }()

    // MARK: - 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 设置UI 界面
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK:- 设置UI界面
extension HomeViewController {
    
    private func setupUI() {
        // 0. 不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1. 设置导航栏
        setupNavigationBar()
        
        // 2. 设置 TitleView
        view.addSubview(pageTitleView)
        
        // 3. 添加ContentView
        view.addSubview(pageContentView)
        
//        view.backgroundColor = .red
    }
    
    private func setupNavigationBar(){
        
        // 1. 设置导航栏
        /*
        let btn = UIButton()

        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()  // 根据尺寸
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        */
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")

        // 2. 设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        
        /*
        
        let histaryBtn = UIButton()
        histaryBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
        histaryBtn.setImage(UIImage(named: "Image_my_history_click"), for: .highlighted)
//        histaryBtn.sizeToFit()
        histaryBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let histaryItem = UIBarButtonItem(customView: histaryBtn)
        
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
        searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
        searchBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let searchItem = UIBarButtonItem(customView: searchBtn)
        
        let qrcodeBtn = UIButton()
        qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
        qrcodeBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        */
        
        // 类方法
//        let histaryItem = UIBarButtonItem.CreateItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.CreateItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
//        let qrcodeItem = UIBarButtonItem.CreateItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        // 构造函数
        let histaryItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [histaryItem, searchItem, qrcodeItem]
    }
}

// MARK: - 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    
    func pageTitleView(titleView: PageTitleView, selectdInedx index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
//    func pageTitleView(titleView: PageTitleView, selectedIndex index : Int)  {
//        print(index)
//    }
}













