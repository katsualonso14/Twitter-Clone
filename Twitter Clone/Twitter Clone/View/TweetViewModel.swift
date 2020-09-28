//
//  TweetViewModel.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/09/27.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit

//model と　view　をつなげるもの viewの負担の軽減
struct TWeetViewModel {
    
    let tweet: Tweet
    let user: User
    
    var profileImageUrl: URL? {
        return tweet.user.profileImageUrl
    }
    
    //時間
    var timestamp: String {
        let fomatter = DateComponentsFormatter()
        fomatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        fomatter.maximumUnitCount = 1
        fomatter.unitsStyle = .abbreviated
        let now = Date()
        return fomatter.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    
    var userInfoText: NSAttributedString {
        //fullname の太字
        let title = NSMutableAttributedString(string: user.fullname, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        //usernameのグレー字
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        title.append(NSAttributedString(string: " ・\(timestamp)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
