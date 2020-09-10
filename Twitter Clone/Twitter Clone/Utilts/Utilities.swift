//
//  Utilities.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/09/03.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
//メール・パスワードの関数化
class Utilities {
    
//    画像(image)の高さ、位置の関数
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
//        高さ調整
             view.heightAnchor.constraint(equalToConstant: 50).isActive = true
             
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
//        TextFieldの高さ
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
//        高さ
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,height: 0.75)
        
        return view
    }
    
//    ログイン画面のtextFieldの関数化
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
         tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
//        パスワードを打った時に・・・の白字を表示する
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        return tf
    }
    
    func attributedButton(_ firestPart: String,_ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firestPart, attributes: [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append( NSMutableAttributedString(string: secondPart, attributes: [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
               
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
    
}
