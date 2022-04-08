//: [Previous](@previous)

import Foundation

//: # Optional Type (可选类型)
/*:
- 什么是可选类型？
- 可选链操作
- 附加
 */

//: ## 什么是可选类型?
//: swift 是强类型的语言，默认的必须为一个指定类型的变量一个确切的值，如果不提供一个值将提示错误。但有时候我们确实有可能一个变量不一定有值，那么这个时候就需要使用 ***可选类型*** 来表示，swift 中对可选类型的定义为：
enum Optional<T> {
    case None
    case Some(T)
}

//: 一个非可选类型的变量保证了其值一定存在，我们可以安全的使用这个变量
var string = "hello"
print(string)

//: 通过在变量类型后跟上一个 `?` 可以表示一个可选类型的变量，如：
var optionalValue: String? = nil
optionalValue = "world" // 在需要的时候进行赋值

//: 由于可选类型的值不一定存在，为了安全的使用对应的变量值，通常需要做安全判断
if optionalValue != nil {
    // 这里的 `!` 表示强制解包运算符，表示我们确定 optionalValue 的值一定存在
    print(optionalValue!)
}

//: swift 提供了更加简洁的 `if let` 语法对可选类型的值做安全检查
if let optionalValue = optionalValue {
    print(optionalValue)
}

//: 或者使用 `guard let ... else`
guard let optionalValue = optionalValue else {
    fatalError("value not exist.")
}
print(optionalValue)

//: ## 可选链操作
class Test {
    let name: String? = "jone"
}

var test: Test? = nil
//: 默认的打印一个没有值的可选类型会得到以个 nil 表示不存在一个值
print(test)

//: 可选链允许我们调用一个可选类型的相关属性或者方法，得到的结果将是其属性或方法的可选类型。可选链的调用会提前返回，如下例中：如果 test 对象不存在则调用 test?.name 失败，提前返回 nil，如果 test 存在 则继续调用 test?.name?.uppercased()，如果 name 属性不存在确切的值，则提前返回 nil，否则执行 uppercased() 成功并返回一个确定的值
let nilValue = test?.name?.uppercased()
print(nilValue)
test = Test()
let result = test?.name?.uppercased()
print(result!)


//: 当将可选类型赋值给一个确切的类型变量是，`swift` 中提供了 `??` 运算符来为可选类型不存在值的情况提供一个默认值
let defaultValue = "default"
var optionalA: String? = nil
let resultValue: String = optionalA ?? defaultValue
print(resultValue)

//: ## 附加
//: 使用 `swift case` 对可选类型进行安全检查
example {
    let capital: String? = "BeiJin"
    switch capital {
    case .none: print("value is nil")
    case .some(let captial): print("value is \(captial)")
    }
}

//: 上面的示例中的 `.some(let captial)` 也可以使用下面的方式表示
example {
    let capital: String? = "BeiJin"
    switch capital {
    case .none: print("value is nil")
    case let capital?:
        print("value is \(capital)")
    }
}

//: 对于可选类型的数组的遍历
example {
    let array = ["a", "b", nil, "c"]
    for case let value? in array {
        print(value)
    }
}


//: [Next](@next)
