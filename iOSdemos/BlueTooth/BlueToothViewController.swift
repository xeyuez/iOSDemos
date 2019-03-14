//
//  BlueToothViewController.swift
//  iOSdemos
//
//  Created by yumez on 2019/3/12.
//  Copyright © 2019 yumez. All rights reserved.
//

import UIKit
import CoreBluetooth


class BlueToothViewController: UIViewController {
    var models: [CBPeripheral] = [CBPeripheral]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self
        self.view.addSubview(view)
        return view
    }()
    
    var manager: CBCentralManager?
    var btn: UIBarButtonItem = UIBarButtonItem(title: "扫描", style: .plain, target: self, action: #selector(didTapRightBtn123(_ :)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
//        btn.tag = 1
//        btn.isEnabled = true
//        self.navigationItem.rightBarButtonItem = btn
        setupTableView()
    }
    
    func setupTableView() {
        tableView.frame = self.view.frame
    }
    
    @objc func didTapRightBtn123(_ sender: UIBarButtonItem) {
//
//        print("didTapRightBtn123")
//        if sender.tag == 0 {
//            sender.tag = 1
//            sender.title = "停止扫描"
//            if manager?.state == CBManagerState.poweredOn {
//                manager?.scanForPeripherals(withServices: nil, options: nil)
//            }
//        }else {
//            sender.tag = 0
//            sender.title = "扫描"
//            manager?.stopScan()
//        }
    }
}


extension BlueToothViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            manager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false, CBCentralManagerOptionShowPowerAlertKey: true])
            print("central 状态:  poweredOn")
        case .poweredOff:
            print("central 状态:  poweredOff")
        case .resetting:
            print("central 状态:  resetting")
        case .unauthorized:
            print("central 状态:  unauthorized")
        case .unsupported:
            print("central 状态:  unsupported")
        case .unknown:
            print("central 状态:  unknown")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("central: 已经连接设备: \(peripheral)")
//      peripheral.delegate = self
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        print("central: 将要恢复状态: \(dict)")
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("central: 连接设备失败: \(peripheral)  error: \(error.debugDescription)")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("central: 断开设备失败: \(peripheral)  error: \(error.debugDescription)")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("发现设备 \n 详情: \(peripheral) \n数据: \(advertisementData) \n 信号: \(RSSI) \n\n\n ")
       
        if (peripheral.name ?? "").hasPrefix("yu") {
            manager?.connect(peripheral, options: nil)
            print("发现设备: \(peripheral)  Data: \(advertisementData) rssi: \(RSSI) \n")
        }
        
        var set: Set<CBPeripheral> = Set<CBPeripheral>()
        _ = models.map{ set.insert($0) }
        set.insert(peripheral)
        self.models = set.map{ $0 }
    }
}


extension BlueToothViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        let model = models[indexPath.row]
        cell.textLabel?.text = model.name ?? "null"
        cell.detailTextLabel?.text = model.identifier.uuidString
        cell.accessoryType = model.state == .disconnected ? .detailButton : .checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        print(model)
//      manager?.connect(model, options: nil)
    }
}


extension BlueToothViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
    }
    
    
    
}
