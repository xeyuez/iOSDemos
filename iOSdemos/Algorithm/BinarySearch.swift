//
//  BinarySearch.swift
//  iOSdemos
//
//  Created by yumez on 2019/3/8.
//  Copyright © 2019 yumez. All rights reserved.
//

import Foundation


/**
 二分查找原理
 取数组最小与最大索引拿到索引中间值对比,
 等于则返回位置
 因为二分查找需要已排序数组
 数据小于查找值则最小索引右移;
 数据大于查找值则最大索引左移;
 */

public func binarySearch<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2 //中间值
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}

