//
//  MainTableController.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/08/28.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit

class MainTableController: UITabBarController {
//ボタンの作成
    let  actionButton: UIButton = {
    let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
//        指でタッチしたときのアクション
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        configureUI()
    }
    
//    タッチしたときの関数
    @objc func actionButtonTapped() {
        print(123)
    }
    
//    ボタンの設定に関する関数
    func configureUI() {
        view.addSubview(actionButton)
//        actionButton.translatesAutoresizingMaskIntoConstraints = false
//        actionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
//        actionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
//        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -64).isActive = true
//        actionButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16).isActive = true
//        actionButton.layer.cornerRadius = 56 / 2
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
        
    }
    
    
    func configureViewControllers() {
//        それぞれ関数（navigationBarの）に当てはめていく
        let feed = FeedContoller()
        let nav1 = tamplateNavigationController(image: UIImage(named: "home_unselected"), rootViewConroller: feed)

        let explore = ExploreContoller()
  let nav2 = tamplateNavigationController(image: UIImage(named: "search_unselected"), rootViewConroller: explore)
        
        let notifications = NotificationsContoller()
          let nav3 = tamplateNavigationController(image: UIImage(named: "like_unselected"), rootViewConroller: notifications)
        
        let conversations = ConvesationsContoller()
          let nav4 = tamplateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewConroller: conversations)
        
        viewControllers = [nav1,nav2,nav3,nav4]
    }
    
    //　navigationBarの設定をする関数
    func tamplateNavigationController(image: UIImage?, rootViewConroller: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewConroller)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
}
