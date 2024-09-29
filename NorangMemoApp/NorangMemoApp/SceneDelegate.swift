//
//  SceneDelegate.swift
//  NorangMemoApp
//
//  Created by Kyuhee hong on 9/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow? //윈도우는 Scene이 올라올 장소 아이폰은 윈도우가 하나라서 여기 윈도 하나만 있음

//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        //Session 연결을 하고 싶은데 어떻게 해야 할까? 연결 전에 미리 윈도우 구성을 먼저 해야함!
//        //근데, 시작점이었던 main 스토리보드를 지웠기 때문에 윈도우의 구성상태를 여기서 명시함, 그래야 연결이 될 수 있지.
//        //Window 와 Scene 을 잇기 위한 로직을 여기에 정의해주자. 여기서 시작하세용~!
//        window = UIWindow(windowScene: windowScene)
//        let viewController = ViewController()
//        window?.rootViewController = viewController //윈도우의 컨트롤러는 얘로 임명한다
//        window?.makeKeyAndVisible() //윈도우를 보이는 상태로 만들어줭
//    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let memoListViewController = MemoListViewController()
        
        // 네비게이션 컨트롤러로 감싸기
        let navigationController = UINavigationController(rootViewController: memoListViewController)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let _ = (scene as? UIWindowScene) else { return }
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

