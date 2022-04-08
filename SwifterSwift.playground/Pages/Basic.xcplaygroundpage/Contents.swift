//: [Previous](@previous)

import UIKit

//: # Basic

/*:
- 变量与常量的定义
- 类型推断与类型标注
- 基础数据类型
- 常用函数
- 可选类型
- 附加
 */


//: ## let 和 var

//: ### 使用 `let` 定义一个常量
let constInt = 50     // 整形常量
let constString = "Const String"    // 字符串常量

// 你不能修改一个常量，尝试的修改将无法通过编译
//constInt = 100 // error

//: ### 使用 `var` 定义一个变量
var variableInt = 50
var variableString = "Variable String"

// 你可以在定义变量的生命周期范围内的任何地方修改它的值
variableInt = 100
variableString += " ..."

//: ## 类型推断和类型标注
//: ### 类型推断
//: 在没有进行显示声明变量类型时编译器会根据变量的值自动推断变量的类型）
let intValue = 10   // swift 会自动推断其为 Int 类型

//: ### 类型标注
// 也可以显式的指出变量的类型
let otherIntValue: Double = 30    // 显示指出一个 Double 类型的变量

//: ## 基础数据类型
//: swift 有 6 中基础数据类型，分别是 Integer、Float、Double、Boolean、String 和 Character
/*:
- 整形: Int Int8 Int16 Int32 Int64
     
- 无符号整形: UInt UInt8 UInt16 UInt32 UInt64
     
- 浮点数类型: Float Float32 Float64 Float80 Double
 
- 布尔类型: boolean
 
- 字符串类型: String
 
- 字符类型: Character
*/

let integerValue: Int = 10
let floatValue: Float = 10.0
let doubleValue: Double = 10.0
let boolValue: Bool = true
let string: String = "Hello, Swift!"
let character: Character = string.first!

//: ## 常用属性、函数

Int.min // 获取Int类型的最小值
Int.max // 获取Int类型的最大值

max(10, 20)
min(10, 20)
max(10, 20, 30, 40)
floor(100.7)    // 向下取整
round(100.3)    // 四舍五入
round(100.5)
ceil(100.3)     // 向上取整
var x = 7.34
x.round(.towardZero)

10.distance(to: 20) // 计算 10 到 20 的距离
(-10).distance(to: 20) // 计算 -10 到 20 的距离
10.advanced(by: 20) // 在原来的位置 10 上偏移指定值的距离 20 相对于做加法，等于 30
(-10).advanced(by: 20)

// 三角函数
Float.pi
sin(45 * Float.pi / 180)
cos(45 * Float.pi / 180)
asin(45 * Float.pi / 180)
acos(45 * Float.pi / 180)
tan(45 * Float.pi / 180)
atan(45 * Float.pi / 180)

//: ## 可选类型
//: 在 swift 中使用可选类型(类型后跟一个?号)表示一个变量是否存在一个值，可选类型必须是 `var` 类型
// 如果变量不存在一个值，则输出为 nil，否则打印给定的值
var existValue: String?
existValue = "Hello"

//: ## 附加
//:
//: `typealias AnyClass = AnyObject.Type` 获得一个类的元类型,实际使用中我们可以同过 `class.self` 获得，元类型中存放着类型的相关信息

//: swift 是强类型语言，你不能将一个字符串赋值给一个数值类型，但是 swift 提供了 Any 来表示任意类型 （基础数据类型，类类型，方法等），那么现在你可以将一个字符串类型赋值给一个 Any 类型的变量
var any: Any = 86
any = "Hello"

// AnyClass 的定义是 typealias AnyClass = AnyObject.Type，所有的 class 类型都隐式的符合 AnyClass
let classType: AnyClass = UIView.self

class A {
    
    required init() {}
    
    class func classMethod() {
        print("Class Method")
    }
    
    func method() {
        print("Instance Method")
    }
}

// 可以认为 A.Type 继承于 AnyClass
let a1: A.Type = A.self
let a2: AnyClass = A.self

print("a1: \(a1)")
print("a2: \(a2)")
a1.classMethod()    // 类方法调用
(a2 as! A.Type).classMethod()   // 需要强制转换

// 说明 `init()` 方法是一个类方法，返回了一个 `A` 类的实例
A.init().method()
// 等价于上面的调用
A().method()
// 你也可以这样
let a = A.self()
a.method()

//: [Next](@next)

























































