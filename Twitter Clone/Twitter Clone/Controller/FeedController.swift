//
//  FeedController.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/08/28.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit

class FeedContoller: UIViewController {
    
    override func viewDidLoad() {
         super.viewDidLoad()

        confifureUI()
     }
    
    func confifureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
}
