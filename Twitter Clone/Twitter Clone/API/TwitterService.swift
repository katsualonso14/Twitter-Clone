//
//  TwitterService.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/09/15.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import Foundation
import Firebase
//実際にデータベースにツイートを反映させる
struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, competion: @escaping( Error?, DatabaseReference) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let value = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970),
                     "likes": 0,
                     "retweet": 0,
                     "caotion": caption] as [String: Any]
        
        RER_TWEETS.childByAutoId().updateChildValues(value,withCompletionBlock: competion)
        
    }
    
}
