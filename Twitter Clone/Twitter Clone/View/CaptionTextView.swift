//
//  CaptionTextView.swift
//  Twitter Clone
//
//  Created by 玉井　勝也 on 2020/09/15.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
//ニューツイートのテキストビュ
class CaptionTextView: UITextView {
    
//    MARK: - Properties
//    最初に書いてあるテキスト設定
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "what's happening"
        return label
    }()
    
    //    MARK: - Lifecycle
    
//
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor,left: leftAnchor,paddingTop: 8, paddingLeft: 4)
        
        //    初期の文字　what's happeing と打つ字がかぶならないようにする
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputCange), name: UITextView.textDidChangeNotification, object: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Selectores
//    文字が書かれた時の処理
    @objc func handleTextInputCange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
}
