//
//  MainTabBarController.swift
//  NorangMemoApp
//
//  Created by Kyuhee Hong on 10/6/24.
//


import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메모 리스트 탭
        let memoListVC = UINavigationController(rootViewController: MemoListViewController())
        memoListVC.tabBarItem = UITabBarItem(title: "메모", image: UIImage(systemName: "note.text"), tag: 0)
        
        // 설정 탭
        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
        settingsVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 1)
        
        // 탭 바에 두 개의 뷰 컨트롤러를 추가
        viewControllers = [memoListVC, settingsVC]
    }
}