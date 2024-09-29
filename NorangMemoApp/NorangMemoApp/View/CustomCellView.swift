//
//  CustomCellView.swift
//  NorangMemoApp
//
//  Created by Kyuhee Hong on 9/29/24.
//
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //제목 레이블
    let title: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    //컨텐츠 레이블
    let content: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = .gray
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        return contentLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //레이블들을 셀 자체의 contentView 에 추가함
        contentView.addSubview(title)
        contentView.addSubview(content)
        
        //레이아웃 설정
        NSLayoutConstraint.activate([
            //제목 레이아웃
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            //컨텐츠 레이아웃
            content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
