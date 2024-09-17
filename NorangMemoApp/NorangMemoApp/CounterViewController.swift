//
//  ViewController.swift
//  NorangMemoApp
//
//  Created by Kyuhee hong on 9/9/24.
//

import UIKit

class CounterViewController: UIViewController {
    let counter = Counter()
    var counterView: CounterView!
    
    override func loadView() {
        counterView = CounterView()
        view = counterView
    }
    // loadView()는 UIViewController가 뷰를 로드하는 시점에 호출됨.
    // 여기서 counterView를 인스턴스화한 후, view 속성에 할당하여 이 컨트롤러의 기본 뷰로 설정함. 즉, CounterView가 화면에 표시됨.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        counterView.counterButton.addTarget(self, action: #selector(incrementCounter), for: .touchUpInside)
    }
    // viewDidLoad()는 뷰가 메모리에 로드된 직후에 호출됨.
    // updateView() 함수는 처음에 호출되어 초기 UI를 설정합니다.
    // counterView.counterButton.addTarget는 버튼에 액션을 연결하는 코드.
    // 여기서는 counterButton이라는 버튼에 incrementCounter 함수를 연결하여 버튼을 누르면 해당 함수가 호출됨
    
    @objc func incrementCounter() {
        counter.increment()
        updateView()
    }
    // 버튼이 눌렸을 때 호출되는 함수
    // counter.increment()는 Counter 클래스의 increment 메서드를 호출하여 카운터 값을 증가시킴
    // 이후 updateView()를 호출하여 카운터 값이 증가한 후의 UI를 업데이트합니다.
    
    func updateView() {
        counterView.counterLabel.text = "Norang Count: \(counter.count)"
    }
    // UI의 레이블을 업데이트하는 역할
    // counterView.counterLabel.text는 레이블의 텍스트를 카운터 값에 따라 업데이트한다.
}
