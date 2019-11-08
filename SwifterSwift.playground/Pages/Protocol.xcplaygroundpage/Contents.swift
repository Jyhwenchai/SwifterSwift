//: [Previous](@previous)

import Foundation

//: 定义一个空协议
protocol ProtocolName { }

//: 在协议中定义初始化方法、计算属性
protocol SomeProtocol {
    
    // 协议中可以定义构造方法
    init(someParameter: Int)
    
    // 协议中可定义计算属性
    var mustBeSettable: Int { get set }         // 可读写的计算属性
    var doesNotNeedToBeSettable: Int { get }    // 只读计算属性
}

//: 在 `protocol` 钱可以使用`@objc` 修饰，`@objc` 修饰的协议只有OC对象才可实现
//:
//: 另外正常来说 `swift` 中的协议都是必须实现的，`optional` 的存在是为了兼容 OC 中的协议可选的特性，在 `swift` 只有 `@objc` 修饰的协议才能使用 `optional` 关键字
@objc protocol OCProtocol {
    
    // 声明协议方法
    func protocolFunc()    // 实现该协议必须实现该方法
    @objc optional func protocolFunc2()   // 实现该协议不一定要实现该方法（可选的）
}

//: 只有OC对象才可实现的另一种写法是使协议继承于 `NSObjectProtocol`
protocol OCProtocol2: NSObjectProtocol {
    func protocolFunc()
//    @objc optional func protocolFunc2()   // 这里无法使用这种写法
}

//: 实现协议的对象是 `enum`、`struct` 等值类型则只有声明为 `mutating` 的方法才可以修改其属性
//:
//: 如果是 `class` 对象则都可修改, 不论是否使用 `mutating` 修饰
protocol SwiftProtocol {
    func protocolFunc()
    mutating func mutatingFunc()
}

struct StructObject: SwiftProtocol {
    
    var count: Int
    
    mutating func mutatingFunc() {
        count = 10  // mutating修饰的方法可以修改属性
    }
    
    func protocolFunc() {
//        count = 10    // error无法操作count属性
    }
    
}

struct StructObject2: SomeProtocol {
    var count: Int
    
    // 实现协议的构造方法
    init(someParameter: Int) {
        count = someParameter
    }
    
    // 实现协议的计算属性
    var mustBeSettable: Int {
        get { return count }
        set { count = newValue }
    }
    
    var doesNotNeedToBeSettable: Int { return count }
    
    
}

class ClassObject: SwiftProtocol {
    
    var count: Int = 0
    
    func protocolFunc() {
        count = 10
    }
    
    func mutatingFunc() {
        count = 20
    }
}

//: 非OC对象无法实现OC类型的协议（使用 `@objc` 或继承于 `NSObjectProtocol` 的协议）
//struct StructObject2: OCProtocol {
//
//}

// 只有OC对象才可以实现的协议
class OCObejectClass: NSObject, OCProtocol {
    
    var count = 10
    
    func protocolFunc() {
        count = 20
    }
}

class OCObejectClass2: NSObject, OCProtocol2 {
    
    func protocolFunc() {
        
    }
}

//: 协议可作为对象的属性
protocol RandomNumberGenerator {
    func random() -> Int
}

class Dice {
    
    let generator: RandomNumberGenerator
    
    init(generator: RandomNumberGenerator) {
        self.generator = generator
    }
    
    func roll() -> Int {
        return generator.random()
    }
}

//: 协议可以继承另一个协议
protocol FatherProtocol {
    func fatherFunc()
}

protocol ChildProtocol: FatherProtocol {
    func childFunc()
}

class NewObject: ChildProtocol {
    
    func childFunc() { }

    func fatherFunc() { }
    
}


//: [Next](@next)
