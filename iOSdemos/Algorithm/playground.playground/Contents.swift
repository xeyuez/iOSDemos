import UIKit


// 栈
//public struct Stack<T> {
//   fileprivate var array: [T] = [T]()
//
//    public var isEmpty: Bool {
//        return array.isEmpty
//    }
//
//    public var count: Int {
//        return array.count
//    }
//
//    public mutating func push(_ element: T) {
//        array.append(element)
//    }
//
//    public mutating func pop() -> T? {
//        return array.popLast()
//    }
//
//    public var top: T? {
//        return array.last
//    }
//}
//
//extension Stack: Sequence { //遍历迭代器
//    public func makeIterator() -> AnyIterator<T> {
//        var curr = self
//        return AnyIterator {
//            return curr.pop()
//        }
//    }
//}
//
//
//
//struct Student {
//    var name: String
//    var age: Int
//}
//
//let st1 = Student(name: "张三", age: 18)
//let st2 = Student(name: "李四", age: 19)
//let st3 = Student(name: "王二麻子", age: 20)
//var a = Stack<Student>()
//a.push(st1)
//a.push(st2)
//a.push(st3)
//print(a)
//
//for item in a {
//    print(item)
//}
//
//var b = Stack(array: ["1", "2", "3"])
//
//for item in b {
//    print(item)
//}



//  队列
//struct Queue<T> {
//    fileprivate var array = [T]()
//
//    public var count: Int {
//        return array.count
//    }
//
//    public var isEmpty: Bool {
//        return array.isEmpty
//    }
//
//    public mutating func enqueue(_ element: T) {  // 放入队列
//        array.append(element)
//    }
//
//    public mutating func dequeue() -> T? {   // 出队列
//        if isEmpty  {
//            return nil
//        }else {
//            return array.removeFirst()
//        }
//    }
//
//    public var front: T? {
//        return array.first
//    }
//}
//
//var c = Queue(array: ["1", "2", "3dddd" ])
//let value = c.dequeue()
//print(value)
//print(c)
//c.enqueue("sss")
//print(c)


//// 插入排序
//public func insectionSort<T: Comparable>(_ array: [T], _ sortdir: (T, T) -> Bool) -> [T] {
//    guard array.count > 1 else { return array }
//
//    var a = array
//    for x in 1..<array.count {
//        var y = x       // y为当前位置, 会依次往前遍历
//        let temp = a[y]
//        while y > 0 && sortdir(temp, a[y - 1]) { // 判断前面有没有数比自己小
//            a[y] = a[y - 1]  //前面数比自己小 自己被赋值为前面一个数
//            y -= 1           //再往前遍历一个位置
//        }
//        a[y] = temp //前面没有数再比自己小了 就放在最前面
//    }
//    return a
//}
////
////
//let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
////// [-1, 0, 1, 2, 3, 3, 5, 8, 9, 10, 26, 27]
//let a = insectionSort(list, <)
////print(a)
//
//
//// 二分查找  查找有序数组对象位置
//public func binarySearch<T: Comparable>(_ a: [T], key: T) -> Int? {
//    var min = 0
//    var max = a.count
//    while min < max {
//        let mid = min + (max - min) / 2
//        if a[mid] == key {
//            return mid
//        }else if a[mid] < key {
//            min = mid + 1
//        }else {
//            max = mid
//        }
//    }
//   return nil
//}
//
//let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
//binarySearch(list.sorted(), key: 26)



// 合并排序
func mergeSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }    // 1
    
    let middleIndex = array.count / 2              // 2
    print("arr: \(array)")

    let leftArray = mergeSort(Array(array[0..<middleIndex]))             // 3
//    print("left: \(leftArray)")
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))  // 4
//    print("rightArray: \(rightArray)")
    let value = merge(leftPile: leftArray, rightPile: rightArray)             // 5
    print("结果g返回: \(value)")
    return value
}

func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
    // 1
    var leftIndex = 0
    var rightIndex = 0
    
    // 2
    var orderedPile = [Int]()
    orderedPile.reserveCapacity(leftPile.count + rightPile.count)
    
    // 3
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    
    // 4
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderedPile
}



let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
let a = mergeSort(numbers)
print(a)
