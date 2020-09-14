//
//  AuthService.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/09/10.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
import Firebase

//emailなどの関数

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String,completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials,completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
         let password = credentials.password
         let username = credentials.username
         let fullname = credentials.fullname
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
             let filename = NSUUID().uuidString
             let srorageRef = STORAGE_PROFILE_IMAGES.child(filename)
             
  //        画像のURL
      srorageRef.putData(imageData, metadata: nil) { (meta,error) in
          srorageRef.downloadURL { (url, error) in
              guard let profileImageUrl = url?.absoluteString else {return}
              
              //        ユーザーの確認メソッド
              Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
                  //            エラーの時にprint
                  if let error = error {
                      print("DEBUG: Error is \(error.localizedDescription)")
                      return
                  }
                  //                Firebaseのid
                        guard let uid = result?.user.uid else {return}
                        
                  let values = ["email": email,
                                "username": username,
                                "fullname": fullname,
                                "profileImageUrl": profileImageUrl]
                
                REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                
                
              }
          }
      }
  }

}

    
