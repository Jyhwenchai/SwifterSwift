//: [Previous](@previous)

import Foundation


/*:
 泛型
 - 泛型方法
 - 泛型类型
 - 对泛型类型的扩展
 - 泛型的一致性处理
 - 泛型下标
 */

//: 如果我们需要交互两个变量的值，变量的类型可能是 Int，Float, String，我们需要分别定义对应类型的方法来进行处理
func swapInt(a: inout Int, b: inout Int) {
    let temp = a
    a = b
    b = temp
}

func swapFloat(a: inout Float, b: inout Float) {
    let temp = a
    a = b
    b = temp
}

func swapString(a: inout String, b: inout String) {
    let temp = a
    a = b
    b = temp
}

//: 上面的例子中除了参数的类型不同外，函数体的实现都是相同了，这就造成了大量重复的代码
//:
//: swift 中可以通过泛型方法来解决这一问题
//:
//: 这里的 `T` 表示通用的类型，当你正在在使用时才会确定下来真实的类型
func swapValue<T>(a: inout T, b: inout T) {
    let temp = a
    a = b
    b = temp
}

var intA = 1
var intB = 11
var stringA = "A"
var stringB = "B"

print("交换前：intA: \(intA) - intB: \(intB)")
print("交换前：stringA: \(stringA) - stringB: \(stringB)")

swapValue(a: &intA, b: &intB)
swapValue(a: &stringA, b: &stringB)

print("交换后：intA: \(intA) - intB: \(intB)")
print("交换后：stringA: \(stringA) - stringB: \(stringB)")

//: 这个例子中你也可以使用 `inout` 来对引用类型实现交换的功能，如下示例
var objA = NSObject()
var objB = NSObject()
print("交换后：stringA: \(objA) - stringB: \(objB)")
swapValue(a: &objA, b: &objB)
print("交换后：stringA: \(objA) - stringB: \(objB)")

//: 你也可以同时定义多个泛型
func genericFunc<T, E>(a: T, b: E) {}

//: 你可以在 `class`、 `struct`、或 `enum` 进行使用泛型
class List<T> {
    var items: [T] = []
    func add(item: T) {
        items.append(item)
    }
}

var intList = List<Int>()
var stringList = List<String>()
var objList = List<NSObject>()

//: 我们还可以对泛型类型进行约束, 使泛型遵循某个协议
extension List where T: Numeric {
    func sum() -> T {
        return items.reduce(0, +)
    }
}

let a = 10
let b = 20
let c = 30
let list = List<Int>()
list.add(item: a)
list.add(item: b)
list.add(item: c)
print("sum: \(list.sum())")


//: 泛型的一致性处理
//:
//: 下面例子我们使 `List` 遵循 `Equatable` 协议，并且 `List` 中的元素也遵循 `Equatable` 协议，这里还需要实现 `==` 操作符，这样使用两个 List 之间可以进行相等性的判别
extension List: Equatable where T: Equatable {
    static func == (lhs: List<T>, rhs: List<T>) -> Bool {
        if lhs.items.count != rhs.items.count {
            return false
        }
        
        for (e1, e2) in zip(lhs.items, rhs.items) {
            if e1 != e2 {
                return false
            }
        }
        return true
    }
    
}

//: 实现泛型角标
extension List {
    subscript<T: Hashable>(item: T) -> Int {
        return item.hashValue
    }
}

print(list[10])


//: [Next](@next)
