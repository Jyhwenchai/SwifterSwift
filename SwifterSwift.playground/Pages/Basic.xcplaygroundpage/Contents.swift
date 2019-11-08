//: [Previous](@previous)

import UIKit

/*:
- 变量与常量的定义
- 类型推断与类型标注
- 常用函数
- 基础数据类型
- 可选类型
- 附加
 */


//: 使用 `let` 定义常量
let constInt = 50     // 整形常量
let constString = "Const String"    // 字符串常量

//: 你不能修改一个常量，尝试的修改将无法通过编译
//constInt = 100 // error

//: 使用 `var` 定义变量, 你可以在变量定义的生命周期范围的任何地方修改它的值
var variableInt = 50
var variableString = "Variable String"

// 修改变量的值
variableInt = 100
variableString += " ..."

//： 类型推断 - 在没有进行显示声明变量类型时编译器会根据变量的值自动推断变量的类型）
let intValue = 10   // swift 会自动推断其为 Int 类型

//: 类型标注 - 显式的指出变量的类型
let doubleValue: Double = 30    // 显示指出一个 Double 类型的变量

// 定义布尔值
var boolValue: Bool = true

// 布尔值的反转
boolValue.toggle()


//: 常用属性、函数
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
x.round(.towardZero)    // 接收参数, 得到小于等于 x 原始值的一个整数

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

/*:

 **基本数据结构**
 
- 整形: Int Int8 Int16 Int32 Int64
     
- 无符号整形: UInt UInt8 UInt16 UInt32 UInt64
     
- 浮点数类型: Float Float32 Float64 Float80 Double
 */
// 字符
let char: Character = "C"

// 字符串
let str: String = "String"

//: 数组 (`swift` 中数组必须指定存储类型) | 有序
let array: Array<Int> = [1, 2, 3]
let otherArray: [Int] = [1, 2, 3]

//: 字典 (`swift` 中字典必须指定 `key` 和` value` 的类型) | 有序
let dict: Dictionary<String, String> = ["0": "A", "1": "B"]
let otherDict: [String: String] = ["0": "A", "1": "B"]

//: 集合 | 无序
let set: Set<Int> = [1, 2, 3]


//: 枚举
enum Direction {
    case north
    case south
    case east
    case west
}

//: Any 可以表示任意类型 （基础数据类型，类类型，方法等）
var any: Any = 86   // 值类型
any = CALayer()     // 引用类型

//: AnyObject 可以表示所有引用类型的实例
let classObj: AnyObject = UIView(frame: CGRect.zero)
//let classObj2: AnyObject = CGRect.zero  // build error, 无法为其赋予一个值类型的值

//: 可选类型  [Optional Type](Optional)
//:
//: `swift` 中使用可选类型来表示'有'和’无‘的概念, 所以如果需要表达一个变量可以有值也可以没有值，那么你可以在定义的类型后加上一个 `?` 号
var optionalValue: String? = nil // nil 就表示无(.none)
optionalValue = "have"  // 赋予一个有效的值就表示有(some)

//: 非可选类型必须给定一个存在的值, 否则将出现编译错误
//let notNilValue: String = nil   // error



//: 附加
//:
//: `typealias AnyClass = AnyObject.Type` 获得一个类的元类型,实际使用中我们可以同过 `class.self` 获得，元类型中存放着类型的相关信息
let classType: AnyClass = UIView.self   // 获得 UIView 类的元类型，元类型中存放着 UIView 的相关信息

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

// method 方法变为一个闭包
let closure = a1.method(A.init())
closure()   // 执行闭包 输出：Instance Method


//: [Next](@next)

























































