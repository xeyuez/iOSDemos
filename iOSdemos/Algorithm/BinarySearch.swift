//
//  BinarySearch.swift
//  iOSdemos
//
//  Created by yumez on 2019/3/8.
//  Copyright © 2019 yumez. All rights reserved.
//

import Foundation


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
