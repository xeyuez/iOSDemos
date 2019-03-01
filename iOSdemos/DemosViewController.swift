//
//  ViewController.swift
//  iOSdemos
//
//  Created by yumez on 2019/2/26.
//  Copyright © 2019 yumez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//model 结构体
struct Example {
    let name: String    // 名称
    let detail: String  // 详情
    
    init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Example: CustomStringConvertible {
    var description: String {
        return "name：\(name) detail：\(detail)"
    }
}

//列表数据源viewmodel
struct ExampleListViewModel {
    let data = Observable.just( [
        Example(name: "RxSwift deme", detail: "RxSwift 使用demo"),
        ])
}


class DemosViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero)
        view.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        view.frame = self.view.frame
        self.view.addSubview(view)
        return view
    }()
    
    //列表数据源
    let exampleListViewModel = ExampleListViewModel()
    
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //将数据绑定到tableViewcell上
        exampleListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, example, cell in
                cell.textLabel?.text = example.name
                cell.detailTextLabel?.text = example.detail
            }.disposed(by: disposeBag)
        
        // tableView点击响应
        tableView.rx
            .modelSelected(Example.self)
            .subscribe(onNext: { [weak self] example in //.subscribe 订阅
                guard let sSelf = self else { return }
                print("你选中的信息【\(example)】")
                let vc = RxSwiftExampleViewController()
                sSelf.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
      
        tableView.rx
            .itemSelected
            .subscribe(onNext: {[weak self] indexPath in
            guard let sSelf = self else { return }
            print("选中项的indexPath为：\(indexPath)")
            
            sSelf.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
        
    }
    
}

