//
//  Stack.swift
//  iOSdemos
//
//  Created by yumez on 2019/3/8.
//  Copyright © 2019 yumez. All rights reserved.
//

import Foundation

public struct Stack<T> {
    fileprivate var array: [T] = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}

extension Stack: Sequence { //遍历迭代器
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator {
            return curr.pop()
        }
    }
}
