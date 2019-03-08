//
//  Queue.swift
//  iOSdemos
//
//  Created by yumez on 2019/3/8.
//  Copyright © 2019 yumez. All rights reserved.
//

import Foundation

struct Queue<T> {
    fileprivate var array = [T]()
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {  // 放入队列
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {   // 出队列
        if isEmpty  {
            return nil
        }else {
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
}
