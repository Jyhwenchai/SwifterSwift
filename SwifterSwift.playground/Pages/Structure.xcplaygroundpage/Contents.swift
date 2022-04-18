//: [Previous](@previous)

import UIKit

///
/// swift 中 class 与 struct 的相同之处
/// - 都可以有属性 (Properties)
///
///     swift 中的属性有分`存储属性`和`计算属性`
///
///     存储属性：存储属性可以存储变量或常量，可以拥有属性观察者。
///     计算属性：计算属性不能用来存储一个值，通常计算属性用于将计算的结果赋予存储属性，
///     以及将计算属性进行一些逻辑运算后进行返回
///
///     * 特殊的我们也可以将`存储属性`定义为懒加载的`存储属性`，
///     懒加载的存储属性只有第一次使用的时候才会进行初始化，如果没有地方使用到则不会进行初始化
///
/// - 都可以有方法 (Methods)
/// - 都可已有初始化方法 (Initializers)
/// - 都可以有下标 (Subscripts)
/// - 都可以进行扩展 (Extensions)
/// - 都可以遵从协议 (Protocol)
///
////////////////////////////////////////////////////////////////
///
/// swift 中 class 与 struct 的不同之处
///
/// - class 是引用类型，而 struct 是值类型
///
///     这意味着当你创建一个 class 实例对象后，使用另一个变量来引用前面的实例，
///     那么这两个变量引用的是同一个对象，修改其中一个变量引用的实例，另一个也将随之变化
///
///         class CustomClass {
///             var name: String = ""
///         }
///
///         let objA = CustomClass()
///         let objB = objA
///
///         objA.name = "hello"
///         print("objA.name: \(objA.name),  objB.name: \(objB.name)")
///         // 输出 objA.name: hello,  objB.name: hello
///
///
///     而在使用 struct 创建的实例对象中，如果使用另一个变量来引用前面的实例，
///     那么系统将会拷贝一份具有相同内容的实例对象，修改其中的一个变量引用的实例，另一个不受影响
///
///        struct CustomStruct {
///             var name: String = "default"
///        }
///
///        var structA = CustomStruct()
///        let structB = structA
///
///        structA.name = "hello"
///        print("structA.name: \(structA.name),  structB.name: \(structB.name)")
///        // 输出 structA.name: hello,  structB.name: default
///
/// - class 可以继承，而 struct 不支持继承
/// - class 可以有自定义的反初始化方法，而 struct 没有
/// - 引用计数, class 用引用计数的概念，而 struct 没有，因为 struct 是值类型，所以多个变量间的引用会发生拷贝


//: 定义一个没有任何属性、方法的结构体, 其中 `struct` 是关键字，StructA 是结构体名称，使用花括号包裹结构体内容
struct StructA {
    
}

//: 在结构体中如果不提供构造方法，`swift` 默认会提供一个全能初始化方法
struct Circle {
    // 存储属性
    var radius: Double
    var center: CGPoint
    
    // 计算属性
    var area: Double {
        get {
            return Double.pi * radius * radius
        }
        
        set {
            radius = sqrt(newValue / Double.pi)
        }
    }
}

//: 使用全能初始化器进行初始化
var circle = Circle(radius: 10, center: CGPoint(x: 0, y: 0))
circle.area = 100

//: 当然你也可以自己创建初始化方法
struct Rectangle {
    var width: Double
    var height: Double = 20
    static let tag = "Tag"  // 静态属性
    
    // 定义初始化方法
    init(width: Double) {
        self.width = width
    }
    
    // 定义方法
    func calcuteArea() -> Double {
        return width * height
    }
}

Rectangle(width: 40)

// 结构体中的角标
struct Table {
    var multiplier: Int
    
    // 定义下标
    subscript(index: Int) -> Int {
        get {
            return multiplier * index
        }
        
        set {
            multiplier = newValue
        }
    }
    
    // 只读下标
//    subscript(index: Int) -> Int {
//        return multiplier * index
//    }
}

var table = Table(multiplier: 10)
table.multiplier
table[4]    // 使用下标
table[4] = 6
table.multiplier


//: [Next](@next)
