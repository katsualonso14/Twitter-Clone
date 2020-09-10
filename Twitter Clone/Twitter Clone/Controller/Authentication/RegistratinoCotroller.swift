//
//  RegistratinoCotroller.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/09/03.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
import Firebase
//アカウント作成ページ
class RegistationController: UIViewController {
    
//    MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
//    フォトロゴのイメージ取得
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
       }()
    
//        メールのイメージ
        private lazy var emailContainrrView: UIView = {
            let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
            let view = Utilities().inputContainerView(withImage: image, textField: emaiTextField)
            
            
            return view
        }()
    //    パスワードのイメージ
        private lazy var passwordContainrrView: UIView = {
             let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
            let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
                   
            return view
        }()
    
//    フルネームのイメージ
          private lazy var fullnameContainrrView: UIView = {
              let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
              let view = Utilities().inputContainerView(withImage: image, textField: fullnameTextField)
              
              
              return view
          }()
      //    ユーザーネームのイメージ
          private lazy var usernameContainrrView: UIView = {
               let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
              let view = Utilities().inputContainerView(withImage: image, textField: usernameTextField)
                     
              return view
          }()
//フルネームのtextfield
              private let fullnameTextField: UITextField = {
                  let tf = Utilities().textField(withPlaceholder: "Full Name")
                  return tf
              }()
       //ユーザーネームのtextfield
          private let usernameTextField: UITextField = {
              let tf = Utilities().textField(withPlaceholder: "UserName")
              //            ・・・表示
              tf.isSecureTextEntry = true
              return tf
              }()

    //        TextFieldは別に作る　非公開のものだから
            private let emaiTextField: UITextField = {
                let tf = Utilities().textField(withPlaceholder: "Email")
                return tf
            }()
        //    パスワード用
        private let passwordTextField: UITextField = {
            let tf = Utilities().textField(withPlaceholder: "Password")
            //            ・・・表示
            tf.isSecureTextEntry = true
            return tf
            }()
    
//    サインインしてのボタン
    private let alreadyAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    private let registrationButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Sing Up", for: .normal)
           button.setTitleColor(.twitterBlue, for: .normal)
           button.backgroundColor = .white
           
           button.heightAnchor.constraint(equalToConstant: 50).isActive = true //高さ・位置
           button.layer.cornerRadius = 5
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
           button.addTarget(self, action: #selector(handelRegstration), for: .touchUpInside) // タッチして反応
           
           return button
       } ()
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
//    MARK: - Selectors
//    フォトボタンを押したときの反応
    @objc func handleAddProfilePhoto() {
//        フォトアプリに移動（present）
        present(imagePicker, animated: true, completion: nil)
    }
    
//    それぞれのアクション
    @objc func handelRegstration() {
        guard let profileImage = profileImage else {
            print("DEBEG: Please select a profileImage")
            return}
        guard let email = emaiTextField.text else {return}
        guard  let password = passwordTextField.text else {return}
         guard let fullname = fullnameTextField.text else {return}
        guard let username = usernameTextField.text else {return}
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
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
                                  "usename": username,
                                  "fullname": fullname,
                                  "profileImageUrl": profileImageUrl]
                    REF_USERS.child(uid).updateChildValues(values) {(error,ref) in
                        print("DEBUG: sucresefully update user infomition")
                    }
                }
            }
        }
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    //    MARK: - Helpers
//    実装する中身
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
                plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        //        ロゴのサイズ調整
                plusPhotoButton.setDimensions(width: 128, height: 128)
                
                
        //        スタックの作成
        let stack = UIStackView(arrangedSubviews: [emailContainrrView,
                                                   passwordContainrrView,fullnameContainrrView,usernameContainrrView,registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
                view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 32
            ,paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(alreadyAccountButton)
            alreadyAccountButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 40,paddingRight: 40)
        
    }
}

// MARK: - RegistationController

//プロフィール画像の調整
extension RegistationController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
//    画像や動画を更新できる関数

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let nil ならその後の処理　nilじゃなきゃ　returnの後の処理をする
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.profileImage = profileImage
        
//        画像に丸みを
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
//        画像のモード切り替え　みやすく　AspectFillに
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
//        レンタルモードのプロパティ オリジナルのもの
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
