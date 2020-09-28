//
//  FeedController.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/08/28.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifirer = "TweetCell"

class FeedContoller: UICollectionViewController {
    
//    MARK: - Properties
//    ユーザーなら設定した画像を実装させる
    var user: User? {
        didSet{
configureLeflBarButton()
        }
    }
    
    private var tweets = [Tweet]() {
        didSet { collectionView.reloadData()}
        //データを読み取る　このコードでデータが反映
    }
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
         super.viewDidLoad()

        confifureUI()
        fetchTweet()
     }
    
    //MARK: - API
    
    func fetchTweet() {
        TweetService.shared.fetchTweets{ tweets in
            self.tweets = tweets  //ツイートカウントのための宣言
        }
    }
    
//    MARK: - Helpes
    
    func confifureUI() {
        view.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifirer)//ツイートセルを受け継ぐ
        collectionView.backgroundColor = .white
        
        
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

//MARK: UICollectionViewDdelegate/DataSource

//　FeedControllerの拡張子

extension FeedContoller {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count //　データベースにあるだけ
    }
    
    //cellの内容
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifirer, for: indexPath) as! TweetCell//再利用識別子
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
}

//MARK: UICollectionViewDdelegateFlowLayout


extension FeedContoller: UICollectionViewDelegateFlowLayout {
    
    //サイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
