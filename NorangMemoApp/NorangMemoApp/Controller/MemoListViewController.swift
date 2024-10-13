//
//  MemoListViewController.swift
//  NorangMemoApp
//
//  Created by Kyuhee Hong on 9/29/24.
//

import UIKit
import CoreData

class MemoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Core Data Manager 인스턴스
    let coreDataManager = CoreDataManager.shared
        
    // 카테고리별 메모 데이터를 저장 (CoreData에서 가져온 데이터를 사용)
    var categorizedData: [String: [MemoModel]] = [:]
    
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
        loadMemos() // Core Data에서 메모 불러오기

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
                // Core Data에서 메모 삭제
                let memoToDelete = memosInCategory[indexPath.row]
                self.coreDataManager.deleteMemo(memoToDelete)
                
                // UI에서 카테고리 메모 삭제
                self.categorizedData[category]?.remove(at: indexPath.row)
                
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
                
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    // Core Data에서 메모 불러오기
        func loadMemos() {
            let memos = coreDataManager.fetchAllMemos()
            
            // 카테고리별로 메모 데이터를 분류
            categorizedData.removeAll()
            for memo in memos {
                let category = memo.category.rawValue
                if var memosInCategory = categorizedData[category] {
                    memosInCategory.append(memo)
                    categorizedData[category] = memosInCategory
                } else {
                    categorizedData[category] = [memo]
                }
            }
            
            memoListView.tableView.reloadData() // 데이터 갱신
        }
}

// AddMemoViewController에서 데이터를 전달받기 위한 Delegate 프로토콜 정의
extension MemoListViewController: AddMemoViewControllerDelegate {
    func didSaveMemo(_ memo: MemoModel) {
        coreDataManager.createMemo(memo)
        loadMemos() // 저장 후 다시 로드하여 갱신
    }
}
