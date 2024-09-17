//
//  ViewController.swift
//  NorangMemoApp
//
//  Created by Kyuhee hong on 9/18/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let data: [Memo] = [
        Memo(title: "쇼핑 목록", content: "우유, 빵, 달걀"),
        Memo(title: "할 일", content: "운동가기, 책 반납하기"),
        Memo(title: "회의 안건", content: "프로젝트 진행 상황 공유"),
        Memo(title: "여행 계획", content: "숙소 예약, 관광지 조사")
    ]

    var titleLabel = UILabel()
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //타이틀 라벨 설정
        titleLabel.text = "Norang 메모장"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //타이틀 라벨 추가
        view.addSubview(titleLabel)
        
        //테이블 뷰 설정
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        //커스텀 셀 등록
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")

        //테이블 뷰 추가
        view.addSubview(tableView)
        
        setupLayout()
    }
    
    //레이아웃 설정
    func setupLayout() {
        //제목 레이아웃
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        //테이블 레이아웃
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    //섹션 당 행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //각 행에 대한 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        //셀에 데이터 설정하기
        let item = data[indexPath.row]
        cell.title.text = item.title
        cell.content.text = item.content

        return cell
    }
    
    //셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //셀이 선택되었을 때 알려주기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(data[indexPath.row])")
    }

}

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
