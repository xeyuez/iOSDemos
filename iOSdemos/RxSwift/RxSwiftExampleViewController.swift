//
//  RxSwiftExampleViewController.swift
//  iOSdemos
//
//  Created by yumez on 2019/2/27.
//  Copyright © 2019 yumez. All rights reserved.
//

import UIKit
import RxSwift

class RxSwiftExampleViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        let obserble = Observable.of("a", "b", "c")
//        obserble.subscribe(onNext: { (elment) in
//            print("elment -> \(elment)")
//        }, onError: { (error) in
//            print("error -> \(error)")
//        }, onCompleted: {
//            print("onCompleted")
//        }) {
//            print("disposed")
//        }

//        //Observable序列（每隔1秒钟发出一个索引数）
//        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        observable
//            .map { "当前索引数：\($0 )"}
//            .bind { [weak self](text) in
//                //收到发出的索引数后显示到label上
//                self?.title = text
//            }
//            .disposed(by: disposeBag)
        
//        //创建一个初始值为111的Variable
//        let variable = Variable("111")
//
//        //修改value值
//        variable.value = "222"
//
//        //第1次订阅
//        variable.asObservable().subscribe {
//            print("第1次订阅：", $0)
//            }.disposed(by: disposeBag)
//
//        //修改value值
//        variable.value = "333"
//
//        //第2次订阅
//        variable.asObservable().subscribe {
//            print("第2次订阅：", $0)
//            }.disposed(by: disposeBag)
//
//        //修改value值
//        variable.value = "444"
//        /**
//         第1次订阅： next(222)
//         第1次订阅： next(333)
//         第2次订阅： next(333)
//         第1次订阅： next(444)
//         第2次订阅： next(444)
//         第1次订阅： completed
//         第2次订阅： completed
//         */
        
        
        
    }
}
