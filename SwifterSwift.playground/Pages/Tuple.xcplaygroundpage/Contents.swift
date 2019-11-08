//: [Previous](@previous)

import Foundation

//: 元祖的定义
var simpleTuple = ("hello", "world")    // 类型推断
let tuple: (Int, String) = (404, "Not Found")   // 指定类型
var varTuple = (errno: 404, errmsg: "Not Found")   // 给予元组参数名称


//: 元组的访问
simpleTuple.0   // 使用下标访问
varTuple.errmsg // 使用参数名访问
let (errno, _) = varTuple   // 元祖的赋值，使用 '_'忽略参数
print(errno)

//: 元组的比较, 只有相同类型的元组才可以比较
tuple == varTuple


//: 元组可以作为函数返回值，从而得到多个结果
func method() -> (Int, String) {
    return tuple
}

method()

//: 可以在 `Array` 或 `Dictionary` 等集合类型的遍历中使用
for (index, elem) in [1, 2, 3 ,4].enumerated() {
    print("index:\(index), element: \(elem)")
}


//: [Next](@next)
