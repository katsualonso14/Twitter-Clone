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
                     "caption": caption] as [String: Any]
        
        RER_TWEETS.childByAutoId().updateChildValues(value,withCompletionBlock: competion)
        
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
    var tweets = [Tweet]()
        
        RER_TWEETS.observe(.childAdded) { snapshot in
            
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            
            let tweetID = snapshot.key
           
            //各ユーザーのための設定
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID,dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
}
