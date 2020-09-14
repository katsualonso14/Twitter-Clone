//
//  File.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/09/03.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
//ログインページ
class LoginController: UIViewController {
//    ロゴのイメージ取得
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
//    メールの関数
    private lazy var emailContainrrView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emaiTextField)
        
        
        return view
    }()
//    password
    private lazy var passwordContainrrView: UIView = {
         let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
               
        return view
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
//        ログインボタン
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true //高さ・位置
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handelLogin), for: .touchUpInside) // タッチして反応
        
        return button
    } ()
    
//    アカウントない表示をするボタン
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSingUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @objc func handleShowSingUp() {
       let controller = RegistationController()
        navigationController?.pushViewController(controller, animated: true)
    }
//    ログインボタン押した時の関数
    @objc func handelLogin() {
        guard let email = emaiTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.shared.logUserIn(withEmail: email, password: password) {(retuls,error) in
            if let error = error {
                print("DEBUG: Error loging in \(error.localizedDescription)")
                return
            }
            
//            メインタブの実装
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            
            guard let tab = window.rootViewController as? MainTableController else {return}
            
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//    MARK: - Helpers
//    ログインページを動かす関数
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
//        ロゴの実装
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
//        ロゴのサイズ調整
        logoImageView.setDimensions(width: 150, height: 150)
        
        
//        スタックの作成
        let stack = UIStackView(arrangedSubviews: [emailContainrrView,passwordContainrrView,loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 40,paddingRight: 40)
    }
    
    
}
