//: [Previous](@previous)

import UIKit

//: # 控制流
/*:
 swift 中的循环语句
 
 - for-in
 - while
 - repeat-while
 - if
 - if else
 - switch
 */


//: 使用 `for in` 遍历 Range 类型
for i in 0...6 {
    print(i)
}

//: 使用 `_` 可以忽略遍历的值
for _ in 0...6 {
    print("Hello")
}

//: 遍历集合类型，对于数组遍历的结果是由索引和数组的值构成的一个元组对象
let array = [0, 1, 2, 3, 4, 5, 6]
for (index, value) in array.enumerated() {
    print("index \(index) : value \(value)")
}

//: 对于字典遍历的结果是由 key 和字典的值构成的一个元组对象
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
