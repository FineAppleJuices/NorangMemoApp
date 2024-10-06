//
//  MemoListViewController.swift
//  NorangMemoApp
//
//  Created by Kyuhee Hong on 9/29/24.
//

import UIKit

class MemoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: [Memo] = [
        Memo(title: "쇼핑 목록", content: "우유, 빵, 달걀"),
        Memo(title: "할 일", content: "운동가기, 책 반납하기"),
        Memo(title: "회의 안건", content: "프로젝트 진행 상황 공유"),
        Memo(title: "여행 계획", content: "숙소 예약, 관광지 조사"),
        Memo(title: "리스트 항목을 누르면", content: "상세뷰로 넘어감")
    ]
    
    var memoListView = MemoListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(memoListView)
        
        //테이블 뷰 설정
        memoListView.tableView.dataSource = self
        memoListView.tableView.delegate = self
        
        setupLayout()
        setupNavigationBar() // 네비게이션 바에 + 버튼 추가
    }
    
    //레이아웃 설정
    func setupLayout() {
        memoListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memoListView.topAnchor.constraint(equalTo: view.topAnchor),
            memoListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            memoListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            memoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // 네비게이션 바에 + 버튼 추가
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    // + 버튼을 눌렀을 때 호출
    @objc func didTapAdd() {
        let addMemoVC = AddMemoViewController()
        addMemoVC.delegate = self
        let navController = UINavigationController(rootViewController: addMemoVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    //Data source methods
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
        let selectedMemo = data[indexPath.row]  // 선택된 메모
        
        let detailVC = MemoDetailViewController()
        detailVC.memo = selectedMemo  // 선택된 메모를 상세 뷰 컨트롤러에 전달
        
        // 상세 뷰로 화면 전환
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // 스와이프할 때 나타나는 삭제 버튼의 텍스트를 '삭제'로 변경
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    // 셀 스와이프해서 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 삭제 확인 경고창 표시 (preferredStyle 을 통해 하단에서 시트 부르기)
            let alertController = UIAlertController(title: "삭제 확인", message: "이 메모를 삭제하시겠습니까? 정말로?", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                // 데이터를 삭제하고 테이블 뷰를 업데이트
                self.data.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}

// AddMemoViewController에서 데이터를 전달받기 위한 Delegate 프로토콜 정의
extension MemoListViewController: AddMemoViewControllerDelegate {
    func didSaveMemo(_ memo: Memo) {
        data.append(memo)  // 새로운 메모를 데이터에 추가
        memoListView.tableView.reloadData()  // 테이블 뷰 갱신
    }
}
