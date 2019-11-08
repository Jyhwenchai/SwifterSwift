//: [Previous](@previous)

import UIKit

/*:
 swift 中的循环语句
 
 - for-in
 - while
 - repeat-while
 */


//: for-in 可操作集合相关的数据类型或者是区间运算符 Range 类型
// Range 类型的示例
for i in 0...6 {
    print(i)
}

// 集合类型的示例
let array = [0, 1, 2, 3, 4, 5, 6]
for (index, value) in array.enumerated() {
    print("index \(index) : value \(value)")
}

let dict = [1: "a", 2: "b", 3: "c"]
for (key, value) in dict {
    print("key \(key) : value \(value)")
}

let set: Set = [0, 1, 2, 3, 4, 5, 6]
for value in set {
    print(value)
}


//: while
var i = 0
while i < 6 {
    print(i * 10)
    i += 1
}


//: repeat-while
var ran: Int
repeat {
    ran = Int.random(in: 1..<20)
    print(ran)
} while ran < 4



//: [Next](@next)
