//
//  MemoListViewController.swift
//  NorangMemoApp
//
//  Created by Kyuhee Hong on 9/29/24.
//

import UIKit

class MemoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 카테고리별 메모 데이터를 저장
    var categorizedData: [String: [Memo]] = [
        "개인": [
            Memo(title: "쇼핑 목록", content: "우유, 빵, 계란", category: .personal)
        ],
        "아이디어": [
            Memo(title: "새로운 앱 아이디어", content: "AR을 활용한 학습 앱", category: .ideas)
        ],
        "업무": [
            Memo(title: "회의 준비", content: "프리젠테이션 자료 준비", category: .work),
            Memo(title: "프로젝트 마감일", content: "다음 주 금요일까지", category: .work)
        ],
        "할 일": [
            Memo(title: "운동 계획", content: "주 3회 러닝", category: .todos)
        ]
    ]
    
    // 카테고리 순서를 보존하기 위해 섹션 리스트 사용
    var categories: [String] {
        return Array(categorizedData.keys).sorted()
    }
    
    var memoListView = MemoListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(memoListView)
        
        //테이블 뷰 설정
        memoListView.tableView.dataSource = self
        memoListView.tableView.delegate = self
        memoListView.tableView.backgroundColor = UIColor.systemGray6
        
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
    
    // 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    // 각 섹션의 행 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]
        return categorizedData[category]?.count ?? 0
    }
    
    // 셀 데이터 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let category = categories[indexPath.section]
        if let memo = categorizedData[category]?[indexPath.row] {
            cell.title.text = memo.title
            cell.content.text = memo.content
        }
        
        return cell
    }
    
    // 섹션 헤더 타이틀 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    //셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // 셀 선택 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.section]
        if let selectedMemo = categorizedData[category]?[indexPath.row] {
            let detailVC = MemoDetailViewController()
            detailVC.memo = selectedMemo
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // 스와이프할 때 나타나는 삭제와 편집 버튼 추가
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // 삭제 액션
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { _, _, completionHandler in
            let category = self.categories[indexPath.section]  // 해당 섹션의 카테고리 가져오기
            guard var memosInCategory = self.categorizedData[category] else {
                completionHandler(false)
                return
            }
            
            let actionSheet = UIAlertController(title: "삭제 확인", message: "정말 삭제하시겠습니까?", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                // 카테고리에서 메모 삭제
                memosInCategory.remove(at: indexPath.row)
                self.categorizedData[category] = memosInCategory
                
                // 테이블 뷰에서 해당 행 삭제
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            actionSheet.addAction(deleteAction)
            actionSheet.addAction(cancelAction)
            
            self.present(actionSheet, animated: true, completion: nil)
            
            completionHandler(true)
        }

        // 편집 액션
        let editAction = UIContextualAction(style: .normal, title: "편집") { _, _, completionHandler in
            let category = self.categories[indexPath.section]  // 해당 섹션의 카테고리 가져오기
            guard let memosInCategory = self.categorizedData[category] else {
                completionHandler(false)
                return
            }
            
            let selectedMemo = memosInCategory[indexPath.row]  // 선택된 메모
            
            let editMemoVC = AddMemoViewController()
            editMemoVC.memoToEdit = selectedMemo  // 기존 데이터를 전달하여 편집
            editMemoVC.delegate = self  // 메모 저장 시 처리하기 위한 delegate 설정
            
            let navController = UINavigationController(rootViewController: editMemoVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
}

// AddMemoViewController에서 데이터를 전달받기 위한 Delegate 프로토콜 정의
extension MemoListViewController: AddMemoViewControllerDelegate {
    func didSaveMemo(_ memo: Memo) {
        let category = memo.category  // 메모의 카테고리
        
        // 해당 카테고리의 메모 배열을 가져옴
        if var memosInCategory = categorizedData[category.rawValue] {
            // 기존 메모 수정
            if let index = memosInCategory.firstIndex(where: { $0.title == memo.title }) {
                // 기존 메모 업데이트
                memosInCategory[index] = memo
                categorizedData[category.rawValue] = memosInCategory
            } else {
                // 새 메모 추가
                memosInCategory.append(memo)
                categorizedData[category.rawValue] = memosInCategory
            }
        } else {
            // 카테고리에 해당하는 배열이 없으면 새로 추가
            categorizedData[category.rawValue] = [memo]
        }
        
        memoListView.tableView.reloadData()  // 테이블 뷰 갱신
    }
}
