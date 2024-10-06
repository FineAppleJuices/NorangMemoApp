//
//  AddMemoViewController.swift
//  NorangMemoApp
//
//  Created by Kyuhee Hong on 9/29/24.
//

import UIKit

protocol AddMemoViewControllerDelegate: AnyObject {
    func didSaveMemo(_ memo: Memo)
}

class AddMemoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    weak var delegate: AddMemoViewControllerDelegate?
    var memoToEdit: Memo?  // 편집할 메모를 전달받기 위한 속성

    // 카테고리 선택을 위한 Picker View
    let categoryPicker = UIPickerView()
    // 사용 가능한 카테고리
    let categories: [Category] = [.personal, .ideas, .work, .todos]
    
    // 메모 제목
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // 메모 내용
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // 메모 카테고리
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        
        // 편집 모드라면 기존 메모 데이터를 UI에 반영
        if let memoToEdit = memoToEdit {
            titleTextField.text = memoToEdit.title
            contentTextView.text = memoToEdit.content
            if let index = categories.firstIndex(of: memoToEdit.category) {
                categoryPicker.selectRow(index, inComponent: 0, animated: false)
            }
            selectedCategory = memoToEdit.category
            navigationItem.title = "메모 편집"
        } else {
            selectedCategory = categories[0]  // 기본 선택값
            navigationItem.title = "새 메모 추가"
        }
        
        setupNavigationBar() // 취소 및 저장 버튼 설정
    }
    
    func setupLayout() {
        // 텍스트 필드와 Picker View를 설정
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
        view.addSubview(categoryPicker)
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        
        // UIPickerView 델리게이트와 데이터소스 설정
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        // Auto Layout 설정
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTextView.heightAnchor.constraint(equalToConstant: 200),  // 텍스트 뷰의 높이 설정 안해주면 안나타남
            
            categoryPicker.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 20),
            categoryPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryPicker.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    // 네비게이션 바에 취소 및 저장 버튼 추가
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapSave() {
        // 새로운 메모 또는 편집된 메모를 저장
          guard let title = titleTextField.text, !title.isEmpty,
                let content = contentTextView.text, !content.isEmpty else {
              // 제목과 내용을 모두 입력하지 않았을 경우 알림 표시
              let alert = UIAlertController(title: "입력 오류", message: "제목과 내용을 모두 입력해주세요.", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
              return
          }
          
          // 선택된 카테고리 확인
          let category = selectedCategory ?? categories[0]
          
          // 메모를 저장
        let memo = Memo(title: title, content: content, category: category)
          
          // delegate를 통해 메모 전달
          delegate?.didSaveMemo(memo)
          
          // 화면 닫기
          dismiss(animated: true, completion: nil)
    }
    
    // UIPickerViewDataSource 메서드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1  // 카테고리는 하나의 컴포넌트로 구성
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count  // 카테고리 수만큼 행 반환
    }
    
    // UIPickerViewDelegate 메서드
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].rawValue  // 카테고리 이름 반환
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]  // 선택한 카테고리 저장
    }
}
