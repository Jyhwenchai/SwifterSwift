//: [Previous](@previous)

import Foundation


/*:
 - 什么是可选类型？
 - 为什么需要可选类型？
 - 如何对可选类型进行解包？
 - 什么是可选绑定？
 - 什么是可选链？
 - 空合并运算符
 */

//: - 什么是可选类型？
//:
//: 下面示例定义了一个普通带有值的变量，而且其中确定了 `string` 必须有一个值, 如果尝试赋值 `nil` 则会编译错误
var string = "hello"
//string = nil

//: 如果一个变量的值可以有也可以没有，那么就需要可选类型来表示这种类型的变量，可选类型需要在原类型的基础上加上 `?` 符号来表示
var optionalValue: String? = nil
optionalValue = "world" // 在需要的时候进行赋值

//: swift 中对可选类型的定义是一个枚举，如下
enum Optional<T> {
    case None
    case Some(T)
}


//: ### 为什么需要可选类型？
//:
//: 在 OC 中没有可选类型这一说，于是在一些错误上我们难以判断跟踪问题的根源, 定义一个对象 `MyObject *m`, 该对象中实现下面方法 `- (int)calcuteInt:(int)i {return i * 2}`, 在 `m` 调用这样的方法过程中如果 `m` 没有进行赋值，编译器将不会有任何的提示，有时候这样的错误往往难以定位， 所以 swift 中区分了可选类型与非可选类型
//:
//: 如果是非可选类型那么开发者在创建对象的时候就保证对象已经初始化， 如果是可选类型那么开发者就需要对传入的类型进行判断对象是否存在，存在才能继续后续的逻辑处理

var aValue: String? = "a optional string"
if aValue != nil {
    print(aValue!)
}

//: ###如何对可选类型进行解包？
//:
//: 如果定义了一个变量为可选类型，那么你需要在使用的时候进行解包
var string1: String? = "test"
// 使用 `!` 号对 string1 进行强制解包
var text = string1!
print(string1)  // 打印结果为 Optional("test")
print(text) // 打印结果为 test

//: 尽管我们可以对可选类型的变量进行强制解包，但是 `swift` 提供给我们更友好的方式来对可选类型进行处理
//:
//: 我们可以使用 `if let` 对可选类型变量进行可选绑定
example {
    let string: String? = "it's optional value"
        if let string = string {
            print(string)
        } else {
            print("string is nil")
        }
}


//: 使用 `guard let` 当可选类型值为 nil 时截断提前返回
example {
    let noneString: String? = nil
    guard let string = noneString else { return }
    print(string)
}


//: 可选链允许我们在可选变量为 `nil` 的时候调用属性、方法、角标等。如果有一个环节得到的是一个 `nil` 值，那么这个可选链将立即终止并返回 `nil` 值。
class Test {
    let name: String? = "jone"
}

var test: Test? = nil
let nilValue = test?.name?.uppercased()
print(nilValue)
test = Test()
let result = test?.name?.uppercased()
print(result!)


//: 为了简化对可选类型中是否为 `nil` 的处理，`swift` 中提供了 `??` 运算符来提供一个默认值
let defaultValue = "nothing"
var optionalA: String? = nil
let resultValue: String = optionalA ?? defaultValue
print(resultValue)

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
