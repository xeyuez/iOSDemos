import UIKit

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



struct Student {
    var name: String
    var age: Int
}

let st1 = Student(name: "张三", age: 18)
let st2 = Student(name: "李四", age: 19)
let st3 = Student(name: "王二麻子", age: 20)
var a = Stack<Student>()
a.push(st1)
a.push(st2)
a.push(st3)
print(a)

for item in a {
    print(item)
}

var b = Stack(array: ["1", "2", "3"])

for item in b {
    print(item)
}


