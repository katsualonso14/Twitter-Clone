//
//  Constants.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/09/10.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import Firebase
//設定

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

//データベースのレファレンスの定数　次から使い勝手がいい
let DB_REF = Database.database().reference()
//データベースのusersの定数
let REF_USERS = DB_REF.child("users")
let RER_TWEETS = DB_REF.child("tweets")
