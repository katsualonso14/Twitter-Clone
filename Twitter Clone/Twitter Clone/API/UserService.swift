//
//  UserService.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/09/12.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import Firebase

//ユーザに関する情報
//Struct → クラスののプライベート用　汎用されない時

struct UserService {
    static let shared = UserService()

//現在のユーザに関する情報のFirebaseからの所得
    func fetchUser(completion: @escaping(User) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {return}
    
    REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
        guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
      
//        ユーザー情報の取得
        let user = User(uid: uid, dictionary: dictionary)
        
completion(user)
    }
  }

}
