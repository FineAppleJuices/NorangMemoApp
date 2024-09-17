//
//  View.swift
//  NorangMemoApp
//
//  Created by Kyuhee hong on 9/17/24.
//

import Foundation
import UIKit

class CounterView: UIView {
    let counterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false //오토레이아웃을 사용하여 수동으로 제약걸고 싶을 때
        
        return label
    }()
    
    let counterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Increment", for: .normal)
        //for: .normal은 버튼의 상태를 나타냅니다.
        //.normal은 버튼이 기본 상태(사용자가 아무 동작을 하지 않은 상태)에 있을 때의 텍스트를 설정하는 것을 의미합니다.
        //버튼 상태에는 .highlighted (눌렸을 때), .disabled (비활성화되었을 때) 등 다른 상태들도 있습니다.
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(counterLabel)
        addSubview(counterButton)
        
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            counterLabel.widthAnchor.constraint(equalTo: widthAnchor),
            
            counterButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            counterButton.widthAnchor.constraint(equalToConstant: 200),
            counterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
