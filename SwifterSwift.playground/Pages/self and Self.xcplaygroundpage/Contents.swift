import UIKit

/*:
 
 # Self .self 和 .Type
 
 在 Swift 中元类型（metaType）非常有用，我们会经常用到它，只不过它的表现看起来并不那么容易理解
*/

/*:
 ## .Type
 
 什么是元类型? 所谓的元类型其实就是类型的类型。在 Swift 中通常说 `let intValue: Int = 1` 中的 intValue 是 Int 类型，那么 Int 它的类型又是什么呢？答案是 `Int.Type`，而它就是 Int 的元类型。所以在 Swift 中使用 `.Type` 类表示一个类型的元类型。
 */

let intValue: Int = 1

// 我么可以通过 type(of:) 获取一个实例对象的元类型
let intMataType: Int.Type = type(of: intValue)

//: 在实际的应用中可以使用它动态的创建一些类，如下实例中我们根据传入需要的类型动态创建 Man 和 Woman两个类
class People {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
    
    static func doSomething() {
        print("doSomething")
    }
}

class Man: People { }
class Woman: People { }

func createPeople<T: People>(p: T.Type) -> T {
    switch p {
    case is Man.Type:
        return p.init(name: "Man")
    case is Woman.Type:
        return p.init(name: "Woman")
    default:
        fatalError()
    }
}

createPeople(p: Man.self)
createPeople(p: Woman.self)

/*:
 ## .self
 
 在前一个说明元类型的示例中出现了 `Man.self` 和 `Woman.self`，那这里的 `.self` 又表示什么呢？前面我们说过 Swift 中使用 `.Type` 表示一个类的元类型，那么既然是类型那么它就可以有对应的值。而这里的 `Man.self` 与 `Woman.self` 就对应着元类型 `Man.Type` 与 `Woman.Type` 的值。
 
 查看 Swift 文档可以发现 `AnyClass` 的声明为 `typealias AnyClass = AnyObject.Type`，换种方式表达也许会更清晰些
 `typealiase Int = Int(1).Type`。也就是说所有实例对象的元类型是其类型本身（这里指实例 Int(1) 的元类型时 Int 本身）。而 Int 本身的元类型又是 `Int.Type`, 在前面我们知道 `Int.self` 是 `Int.Type` 的值，所以我们会发现 `Int.self == Int`，他们都是 `Int.Type` 的值。我们也可以通过下面的示例进行验证。
 
 */

// 通过 Int(1).self 获取到 Int(1) 实例对象的元类型，可以发现其元类型就是 Int 本身
let intInstatnceType: Int = Int(1).self

// 动过 Int.self 获取到 Int 类型的元类型，可以发现元类型为 Int.Type
let IntMataType: Int.Type = Int.self

// 因为 Int.self 与 Int 等价它们都是 Int.Type 的值，所以下面的语句成立
let intInstance: Int = Int.self(1)  // == Int(1)
let intInstance2: Int = Int(1)      // == Int.self(1)


/*:
 ## Self
 
 在协议中 `Self` 表示遵循此协议的类型，例如：`String`、`Int`等。相对的 `self` 表示某种类型的值，例如 ”hello, world“、1 等。
 
 */

//: 在协议中可以使用 `Self` 作为方法的参数和返回值，表示函数的参数与返回值必须是符合该协议的类型。
protocol ProtocolA {
    func method(param: Self) -> Self
}

//: 但是当一个 `class` 实现该协议时会发现参数中的 `Self` 变成了定义的 `class` 本身，如果你尝试写一个带有 `Self` 的方法系统将给出编译错误并提示你 `Self` 不能作为一个类的参数
class ClassA: ProtocolA {
    func method(param: ClassA) -> Self {
        return self
    }
    
    // 下面的方法无法通过编译
//    func method2(param: Self) -> Self {
//        return self
//    }
}

//: 相比于 `class`，当使用 `struct` 实现该协议时，Swift 会将参数与返回值的类型都转换为定义的 `struct` 本身，当时我们尝试使用 `Self` 来作为结构体方法的参数与返回值会发现 Swift 允许我们这么做。
struct StructA: ProtocolA {
    func method(param: StructA) -> StructA {
        return self
    }
    
    func method2(param: Self) -> Self {
        return self
    }
}


/*:
 NOTE:
 
 在 Swift 中 type(of:) 被称为动态元类型，.self 被称为静态元类型，其实也很容易理解，因为，type(of:) 在运行时才能获取到真实的元类型，而 .self 在编译时就可以知道。
 */
