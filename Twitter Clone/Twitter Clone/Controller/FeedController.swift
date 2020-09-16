//
//  FeedController.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/08/28.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
import SDWebImage

class FeedContoller: UIViewController {
    
//    MARK: - Properties
//    ユーザーなら設定した画像を実装させる
    var user: User? {
        didSet{
configureLeflBarButton()
        }
    }
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
         super.viewDidLoad()

        confifureUI()
     }
    
//    MARK: - Helpes
    
    func confifureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
        
       
    }
//    左上の画像の実装
    func configureLeflBarButton() {
        guard let user = user else {return}
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
//imegeの取得
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
}
