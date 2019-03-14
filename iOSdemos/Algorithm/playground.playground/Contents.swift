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


//
//// 合并排序
//func mergeSort(_ array: [Int]) -> [Int] {
//    guard array.count > 1 else { return array }    // 1
//
//    let middleIndex = array.count / 2              // 2
//    print("arr: \(array)")
//
//    let leftArray = mergeSort(Array(array[0..<middleIndex]))             // 3
////    print("left: \(leftArray)")
//    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))  // 4
////    print("rightArray: \(rightArray)")
//    let value = merge(leftPile: leftArray, rightPile: rightArray)             // 5
//    print("结果g返回: \(value)")
//    return value
//}
//
//func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
//    // 1
//    var leftIndex = 0
//    var rightIndex = 0
//
//    // 2
//    var orderedPile = [Int]()
//    orderedPile.reserveCapacity(leftPile.count + rightPile.count)
//
//    // 3
//    while leftIndex < leftPile.count && rightIndex < rightPile.count {
//        if leftPile[leftIndex] < rightPile[rightIndex] {
//            orderedPile.append(leftPile[leftIndex])
//            leftIndex += 1
//        } else if leftPile[leftIndex] > rightPile[rightIndex] {
//            orderedPile.append(rightPile[rightIndex])
//            rightIndex += 1
//        } else {
//            orderedPile.append(leftPile[leftIndex])
//            leftIndex += 1
//            orderedPile.append(rightPile[rightIndex])
//            rightIndex += 1
//        }
//    }
//
//    // 4
//    while leftIndex < leftPile.count {
//        orderedPile.append(leftPile[leftIndex])
//        leftIndex += 1
//    }
//
//    while rightIndex < rightPile.count {
//        orderedPile.append(rightPile[rightIndex])
//        rightIndex += 1
//    }
//
//    return orderedPile
//}
//
//
//
//let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
//let a = mergeSort(numbers)
//print(a)



//// 快速 排序  调用原生过滤函数  并不高效
//var level: Int = 0
//func quicksort<T: Comparable>(_ a: [T]) -> [T] {
//    guard a.count > 1 else { return a }
//    level = level + 1
//
//    let pivot = a[a.count/2]
//
//    let less = a.filter { $0 < pivot }
//    let equal = a.filter { $0 == pivot }
//    let greater = a.filter { $0 > pivot }
//    let value = quicksort(less) + equal + quicksort(greater)
//    return value
//}
//
//let list = [10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26] //[-1, 0, 1, 2, 3, 5, 8, 8, 9, 10, 14, 26, 27]
//let a = quicksort(list)
//print(list)
//print(a)


//二分查找树
public class BinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
}


extension BinarySearchTree {
    /*
     Inserts a new element into the tree. You should only insert elements
     at the root, to make to sure this remains a valid binary tree!
     Performance: runs in O(h) time, where h is the height of the tree.
     */
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
}

// MARK: - Deleting items

extension BinarySearchTree {
    /*
     Deletes a node from the tree.
     
     Returns the node that has replaced this removed one (or nil if this was a
     leaf node). That is primarily useful for when you delete the root node, in
     which case the tree gets a new root.
     
     Performance: runs in O(h) time, where h is the height of the tree.
     */
    @discardableResult public func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?
        
        // Replacement for current node can be either biggest one on the left or
        // smallest one on the right, whichever is not nil
        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        
        replacement?.remove()
        
        // Place the replacement on current node's position
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node:replacement)
        
        // The current node is no longer part of the tree, so clean it up.
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
    private func reconnectParentTo(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
}

// MARK: - Searching

extension BinarySearchTree {
    /*
     Finds the "highest" node with the specified value.
     Performance: runs in O(h) time, where h is the height of the tree.
     */
    public func search(value: T) -> BinarySearchTree? {
        var node: BinarySearchTree? = self
        while let n = node {
            if value < n.value {
                node = n.left
            } else if value > n.value {
                node = n.right
            } else {
                return node
            }
        }
        return nil
    }
    
    /*
     // Recursive version of search
     public func search(value: T) -> BinarySearchTree? {
     if value < self.value {
     return left?.search(value)
     } else if value > self.value {
     return right?.search(value)
     } else {
     return self  // found it!
     }
     }
     */
    
    public func contains(value: T) -> Bool {
        return search(value: value) != nil
    }
    
    /*
     Returns the leftmost descendent. O(h) time.
     */
    public func minimum() -> BinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    
    /*
     Returns the rightmost descendent. O(h) time.
     */
    public func maximum() -> BinarySearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
    
    /*
     Calculates the depth of this node, i.e. the distance to the root.
     Takes O(h) time.
     */
    public func depth() -> Int {
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    /*
     Calculates the height of this node, i.e. the distance to the lowest leaf.
     Since this looks at all children of this node, performance is O(n).
     */
    public func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    /*
     Finds the node whose value precedes our value in sorted order.
     */
    public func predecessor() -> BinarySearchTree<T>? {
        if let left = left {
            return left.maximum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.value < value { return parent }
                node = parent
            }
            return nil
        }
    }
    
    /*
     Finds the node whose value succeeds our value in sorted order.
     */
    public func successor() -> BinarySearchTree<T>? {
        if let right = right {
            return right.minimum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.value > value { return parent }
                node = parent
            }
            return nil
        }
    }
}

// MARK: - Traversal

extension BinarySearchTree {
    public func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }
    
    public func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    
    public func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }
    
    /*
     Performs an in-order traversal and collects the results in an array.
     */
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left { a += left.map(formula: formula) }
        a.append(formula(value))
        if let right = right { a += right.map(formula: formula) }
        return a
    }
}

/*
 Is this binary tree a valid binary search tree?
 */
extension BinarySearchTree {
    public func isBST(minValue: T, maxValue: T) -> Bool {
        if value < minValue || value > maxValue { return false }
        let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
        let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
        return leftBST && rightBST
    }
}


let tree = BinarySearchTree<Int>(value: 7)
tree.insert(value: 2)
tree.insert(value: 5)
tree.insert(value: 10)
tree.insert(value: 9)
tree.insert(value: 1)

let toDelete = tree.search(value: 1)
toDelete?.remove()
tree
print(tree)


