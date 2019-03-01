//
//  RxSwiftExampleViewController.swift
//  iOSdemos
//
//  Created by yumez on 2019/2/27.
//  Copyright © 2019 yumez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftExampleViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero)
        view.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        view.frame = self.view.frame
        self.view.addSubview(view)
        return view
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        planTableView()
    }
    
    // TableView基本用法
    func planTableView() {
        //初始化数据
        let items = Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
            ])
        
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
                cell.textLabel?.text = "\(row)：\(element)"
                return cell
            }
            .disposed(by: disposeBag)
        
        
        
        //获取选中项的索引
        tableView.rx.itemSelected.subscribe(onNext: {[weak self] indexPath in
            guard let sSelf = self else { return }
            print("选中项的indexPath为：\(indexPath)")
            
            sSelf.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
        
        //获取选中项的内容
        tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("选中项的标题为：\(item)")
        }).disposed(by: disposeBag)
        
        //获取被取消选中项的索引
        tableView.rx.itemDeselected.subscribe(onNext: { indexPath in
            print("被取消选中项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        //获取被取消选中项的内容
        tableView.rx.modelDeselected(String.self).subscribe(onNext: { item in
            print("被取消选中项的的标题为：\(item)")
        }).disposed(by: disposeBag)
        
        
        //单元格删除事件的响应
        //获取删除项的索引
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            print("删除项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        //获取删除项的内容
        tableView.rx.modelDeleted(String.self).subscribe(onNext: { item in
            print("删除项的的标题为：\(item)")
        }).disposed(by: disposeBag)
        
        
        //单元格移动事件响应
        //获取移动项的索引
        tableView.rx.itemMoved.subscribe(onNext: { sourceIndexPath, destinationIndexPath in
            print("移动项原来的indexPath为：\(sourceIndexPath)")
            print("移动项现在的indexPath为：\(destinationIndexPath)")
        }).disposed(by: disposeBag)
        
        //单元格插入事件响应
        //获取插入项的索引
        tableView.rx.itemInserted.subscribe(onNext: { indexPath in
            print("插入项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
       
        //单元格尾部附件（图标）点击事件响应
        //获取点击的尾部图标的索引
        tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { indexPath in
            print("尾部项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        //获取选中项的索引
        tableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            print("将要显示单元格indexPath为：\(indexPath)")
            print("将要显示单元格cell为：\(cell)\n")
        }).disposed(by: disposeBag)
        
        
        
        
    }
    
    
    // Observable 几种事件
    func event() {
        let obserble = Observable.of("a", "b", "c")
        let _ = obserble.subscribe(onNext: { (elment) in
            print("elment -> \(elment)")
        }, onError: { (error) in
            print("error -> \(error)")
        }, onCompleted: {
            print("onCompleted")
        }) {
            print("disposed")
        }
        /** log
         elment -> a
         elment -> b
         elment -> c
         onCompleted
         disposed
         */
    }
    
    //创建一个初始值为111的Variable
    func variable() {
        let variable = Variable("111")
        
        //修改value值
        variable.value = "222"
        
        //第1次订阅
        variable.asObservable().subscribe {
            print("第1次订阅：", $0)
            }.disposed(by: disposeBag)
        
        //修改value值
        variable.value = "333"
        
        //第2次订阅
        variable.asObservable().subscribe {
            print("第2次订阅：", $0)
            }.disposed(by: disposeBag)
        
        //修改value值
        variable.value = "444"
        /** log
         第1次订阅： next(222)
         第1次订阅： next(333)
         第2次订阅： next(333)
         第1次订阅： next(444)
         第2次订阅： next(444)
         第1次订阅： completed
         第2次订阅： completed
         */
    }
    
    //Observable序列（每隔1秒钟发出一个索引数）
    func timer() {
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0 )"}
            .bind { [weak self](text) in
                //收到发出的索引数后显示到label上
                self?.title = text
            }
            .disposed(by: disposeBag)
    }
    
    
    // 计时器 当程序启动时就开始计时，同时将已过去的时间格式化后显示在 label 标签上。
    func label1() {
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:60, width:300, height:20))
        self.view.addSubview(label)
        //创建一个计时器（每0.1秒发送一个索引数）
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        //将已过去的时间格式化成想要的字符串，并绑定到label上
        timer.map{ String(format: "%0.2d:%0.2d.%0.1d",
                          arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10]) }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
   // 将数据绑定到 attributedText 属性上（富文本）修改了分和秒这部分的文字样式，以及背景色。
    func label2() {
        //将数字转成对应的富文本
        func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
            let string = String(format: "%0.2d:%0.2d.%0.1d",
                                arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
            //富文本设置
            let attributeString = NSMutableAttributedString(string: string)
            //从文本0开始6个字符字体HelveticaNeue-Bold,16号
            attributeString.addAttribute(NSAttributedString.Key.font,
                                         value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                         range: NSMakeRange(0, 5))
            //设置字体颜色
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                                         value: UIColor.white, range: NSMakeRange(0, 5))
            //设置文字背景颜色
            attributeString.addAttribute(NSAttributedString.Key.backgroundColor,
                                         value: UIColor.orange, range: NSMakeRange(0, 5))
            return attributeString
        }
        
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:80, width:300, height:20))
        self.view.addSubview(label)
        
        //创建一个计时器（每0.1秒发送一个索引数）
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        //将已过去的时间格式化成想要的字符串，并绑定到label上
        timer.map(formatTimeInterval)
            .bind(to: label.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    
//    func action() { RxSwift控件如何响应手势
//
//        @IBOutlet weak var debugLabel: UILabel!
//
//        @IBOutlet weak var openActionSheet: UIButton!
//
//        @IBOutlet weak var openAlertView: UIButton!
//
//        @IBOutlet weak var bbitem: UIBarButtonItem!
//
//        @IBOutlet weak var segmentedControl: UISegmentedControl!
//
//        @IBOutlet weak var switcher: UISwitch!
//
//        @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//
//        @IBOutlet weak var button: UIButton!
//
//        @IBOutlet weak var slider: UISlider!
//
//        @IBOutlet weak var textField: UITextField!
//        @IBOutlet weak var textField2: UITextField!
//
//        @IBOutlet weak var datePicker: UIDatePicker!
//
//        @IBOutlet weak var mypan: UIPanGestureRecognizer!
//
//        @IBOutlet weak var textView: UITextView!
//        @IBOutlet weak var textView2: UITextView!
//
//        let manager = CLLocationManager()
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//            datePicker.date = Date(timeIntervalSince1970: 0)
//
//            // MARK: UIBarButtonItem
//
//            bbitem.rx.tap
//                .subscribe(onNext: { [weak self] x in
//                    self?.debug("UIBarButtonItem Tapped")
//                })
//                .disposed(by: disposeBag)
//
//            // MARK: UISegmentedControl
//
//            // also test two way binding
//            let segmentedValue = BehaviorRelay(value: 0)
//            _ = segmentedControl.rx.value <-> segmentedValue
//
//            segmentedValue.asObservable()
//                .subscribe(onNext: { [weak self] x in
//                    self?.debug("UISegmentedControl value \(x)")
//                })
//                .disposed(by: disposeBag)
//
//
//            // MARK: UISwitch
//
//            // also test two way binding
//            let switchValue = BehaviorRelay(value: true)
//            _ = switcher.rx.value <-> switchValue
//
//            switchValue.asObservable()
//                .subscribe(onNext: { [weak self] x in
//                    self?.debug("UISwitch value \(x)")
//                })
//                .disposed(by: disposeBag)
//
//            // MARK: UIActivityIndicatorView
//
//            switcher.rx.value
//                .bind(to: activityIndicator.rx.isAnimating)
//                .disposed(by: disposeBag)
//
//            // MARK: UIButton
//
//            button.rx.tap
//                .subscribe(onNext: { [weak self] x in
//                    self?.debug("UIButton Tapped")
//                })
//                .disposed(by: disposeBag)
//
//
//            // MARK: UISlider
//
//            // also test two way binding
//            let sliderValue = BehaviorRelay<Float>(value: 1.0)
//            _ = slider.rx.value <-> sliderValue
//
//            sliderValue.asObservable()
//                .subscribe(onNext: { [weak self] x in
//                    self?.debug("UISlider value \(x)")
//                })
//                .disposed(by: disposeBag)
//
//
//            // MARK: UIDatePicker
//
//            // also test two way binding
//            let dateValue = BehaviorRelay(value: Date(timeIntervalSince1970: 0))
//            _ = datePicker.rx.date <-> dateValue
//
//
//            dateValue.asObservable()
//                .subscribe(onNext: { [weak self] x in
//                    self?.debug("UIDatePicker date \(x)")
//                })
//                .disposed(by: disposeBag)
//
//
//            // MARK: UITextField
//
//            // because of leak in ios 11.2
//            //
//            // final class UITextFieldSubclass: UITextField { deinit { print("never called")  } }
//            // let textField = UITextFieldSubclass(frame: .zero)
//            if #available(iOS 11.2, *) {
//                // also test two way binding
//                let textValue = BehaviorRelay(value: "")
//                _ = textField.rx.textInput <-> textValue
//
//                textValue.asObservable()
//                    .subscribe(onNext: { [weak self] x in
//                        self?.debug("UITextField text \(x)")
//                    })
//                    .disposed(by: disposeBag)
//
//                textValue.asObservable()
//                    .subscribe(onNext: { [weak self] x in
//                        self?.debug("UITextField text \(x)")
//                    })
//                    .disposed(by: disposeBag)
//
//                let attributedTextValue = BehaviorRelay<NSAttributedString?>(value: NSAttributedString(string: ""))
//                _ = textField2.rx.attributedText <-> attributedTextValue
//
//                attributedTextValue.asObservable()
//                    .subscribe(onNext: { [weak self] x in
//                        self?.debug("UITextField attributedText \(x?.description ?? "")")
//                    })
//                    .disposed(by: disposeBag)
//            }
//
//            // MARK: UIGestureRecognizer
//
//            mypan.rx.event
//                .subscribe(onNext: { [weak self] x in
//                    self?.debug("UIGestureRecognizer event \(x.state.rawValue)")
//                })
//                .disposed(by: disposeBag)
//
//
//            // MARK: UITextView
//
//            // also test two way binding
//            let textViewValue = BehaviorRelay(value: "")
//            _ = textView.rx.textInput <-> textViewValue
//
//            textViewValue.asObservable()
//                .subscribe(onNext: { [weak self] x in
//                    self?.debug("UITextView text \(x)")
//                })
//                .disposed(by: disposeBag)
//
//            let attributedTextViewValue = BehaviorRelay<NSAttributedString?>(value: NSAttributedString(string: ""))
//            _ = textView2.rx.attributedText <-> attributedTextViewValue
//
//            attributedTextViewValue.asObservable()
//                .subscribe(onNext: { [weak self] x in
//                    self?.debug("UITextView attributedText \(x?.description ?? "")")
//                })
//                .disposed(by: disposeBag)
//
//            // MARK: CLLocationManager
//            manager.requestWhenInUseAuthorization()
//
//            manager.rx.didUpdateLocations
//                .subscribe(onNext: { x in
//                    print("rx.didUpdateLocations \(x)")
//                })
//                .disposed(by: disposeBag)
//
//            _ = manager.rx.didFailWithError
//                .subscribe(onNext: { x in
//                    print("rx.didFailWithError \(x)")
//                })
//
//            manager.rx.didChangeAuthorizationStatus
//                .subscribe(onNext: { status in
//                    print("Authorization status \(status)")
//                })
//                .disposed(by: disposeBag)
//
//            manager.startUpdatingLocation()
//
//
//
//        }
//
//        func debug(_ string: String) {
//            print(string)
//            debugLabel.text = string
//        }
//
//    }
}
