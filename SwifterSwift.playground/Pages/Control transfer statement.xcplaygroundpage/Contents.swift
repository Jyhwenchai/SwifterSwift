//: [Previous](@previous)

import UIKit

/*:
 - continue
 - break
 - fallthrough
 */

//: 可以使用 `continue` 在循环中提前终止本次循环中的后续逻辑转而开始下一次的循环，示例如下
for num in 0...10 {
    if num % 2 == 0 {
        continue
    }
    print("jump value: \(num)")
}

print(" \n================== \n")

//: 我们可以使用 `break` 在指定条件下终止循环，示例如下
for num in 0...10 {
    if num == 5 {
        break
    }
    print("out value: \(num)")
}

print(" \n================== \n")

//: 我们可以使用 `fallthrough` 在 `switch-case`中贯穿多个 `case` 分支，示例如下
let age = 22
switch age {
case let (year) where year < 5:
    print("kids")
case let (year) where year > 18:
    print("greater 18")
    fallthrough
case let (year) where year < 28:
    print("less than 28")
    fallthrough
default:
    print("young")
}

print(" \n================== \n")

//: `defered` 中的语句总会在返回前执行，你可以用此在某些情况下做一些清理操作
func defered() -> String {
    
    print("defered start")
    
    defer {
        print("final statement")
    }
    
    print("defered end")
    
    return "hello, world"
}

print(defered())

//: [Next](@next)
