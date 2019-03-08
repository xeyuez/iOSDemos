//
//  InsertionSort.swift
//  iOSdemos
//
//  Created by yumez on 2019/3/8.
//  Copyright © 2019 yumez. All rights reserved.
//

import Foundation

// 插入排序
public func insectionSort<T: Comparable>(_ array: [T]) -> [T] {
    var a = array

    for x in 1..<array.count {
        var y = x       // y为当前位置, 会依次往前遍历
        let temp = a[y]
        while y > 0 && temp < a[y - 1] {
            a[y] = a[y - 1]  // 自己等于前面一个数
            y -= 1           // 从自己的位置往前遍历
        }
        a[y] = temp //前面没有数再比自己小了 就放在最前面
    }
    return a
}

public func insectionSort<T: Comparable>(_ array: [T], sortdir: (T, T) -> Bool) -> [T] {
    var a = array
    
    for x in 1..<array.count {
        var y = x       // y为当前位置, 会依次往前遍历
        let temp = a[y]
        while y > 0 && sortdir(temp, a[y - 1]) {
            a[y] = a[y - 1]  // 自己等于前面一个数
            y -= 1           // 从自己的位置往前遍历
        }
        a[y] = temp //前面没有数再比自己小了 就放在最前面
    }
    return a
}


//let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
// [-1, 0, 1, 2, 3, 3, 5, 8, 9, 10, 26, 27]


