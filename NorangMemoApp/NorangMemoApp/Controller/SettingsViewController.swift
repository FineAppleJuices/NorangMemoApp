//
//  SettingsViewController.swift
//  NorangMemoApp
//
//  Created by Kyuhee Hong on 10/6/24.
//


import UIKit

class SettingsViewController: UITableViewController {
    
    let settings = ["알림 설정", "테마 설정", "앱 정보"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "설정"

        view.backgroundColor = UIColor.systemGray6
        // 테이블 뷰 등록
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingCell")
    }
    
    // 섹션 당 행 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    // 각 행에 대한 셀 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        cell.textLabel?.text = settings[indexPath.row]
        cell.accessoryType = .disclosureIndicator // 화살표 추가
        return cell
    }
    
    // 셀이 선택되었을 때 처리
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            // 알림 설정 화면으로 이동
            let notificationSettingsVC = NotificationSettingsViewController()
            navigationController?.pushViewController(notificationSettingsVC, animated: true)
        case 1:
            // 테마 설정 화면으로 이동
            let themeSettingsVC = ThemeSettingsViewController()
            navigationController?.pushViewController(themeSettingsVC, animated: true)
        case 2:
            // 앱 정보 화면으로 이동
            let appInfoVC = AppInfoViewController()
            navigationController?.pushViewController(appInfoVC, animated: true)
        default:
            break
        }
    }
}

// 각종 세팅들

class NotificationSettingsViewController: UIViewController {
    
    let notificationSwitch = UISwitch()
    let notificationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "알림 설정"
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        notificationLabel.text = "알림 켜기"
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        notificationSwitch.isOn = true // 기본값 (켜기)
        
        view.addSubview(notificationLabel)
        view.addSubview(notificationSwitch)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            notificationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notificationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            
//            notificationSwitch.leadingAnchor.constraint(equalTo: notificationLabel.trailingAnchor, constant: 20),
            notificationSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notificationSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Switch 상태 변경에 대한 처리
        notificationSwitch.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
    }
    
    @objc func didChangeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("알림 켜짐")
        } else {
            print("알림 꺼짐")
        }
    }
}

class ThemeSettingsViewController: UIViewController {
    
    let themeSegmentedControl = UISegmentedControl(items: ["라이트", "다크", "시스템"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        themeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        themeSegmentedControl.selectedSegmentIndex = 2 // 기본값은 시스템
        
        view.addSubview(themeSegmentedControl)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            themeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            themeSegmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            themeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // SegmentedControl 값 변경에 대한 처리
        themeSegmentedControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
    }
    
    @objc func didChangeSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("라이트 테마 선택")
        case 1:
            print("다크 테마 선택")
        case 2:
            print("시스템 테마 선택")
        default:
            break
        }
    }
}

class AppInfoViewController: UIViewController {
    
    let appInfoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "앱 정보"
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        appInfoLabel.text = "NorangMemoApp v1.0\nⒸ Norang Company"
        appInfoLabel.textAlignment = .center
        appInfoLabel.numberOfLines = 0
        appInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appInfoLabel)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            appInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appInfoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
