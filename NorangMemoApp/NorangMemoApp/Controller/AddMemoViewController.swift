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

class AddMemoViewController: UIViewController {
    weak var delegate: AddMemoViewControllerDelegate?
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupNavigationBar() // 취소 및 저장 버튼 설정
        navigationItem.title = "새 메모"
    }
    
    func setupLayout() {
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTextView.heightAnchor.constraint(equalToConstant: 200)  // 원하는 높이 설정
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
        guard let title = titleTextField.text, !title.isEmpty,
              let content = contentTextView.text, !content.isEmpty else {
            // 입력값이 없을 때 처리할 수 있는 로직 추가
            return
        }
        
        let newMemo = Memo(title: title, content: content)  // 새로운 메모 생성
        delegate?.didSaveMemo(newMemo)  // 첫 화면에 메모 전달
        dismiss(animated: true, completion: nil)  // 모달 닫기
    }
}
