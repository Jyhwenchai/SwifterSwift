//: [Previous](@previous)

import UIKit

/*:
 `swift` 中扩展可以做的事情
 - 添加计算属性和类属性
 - 定义实例方法和类方法(或则说是静态方法)
 - 提供新便利初始化
 - 定义下标
 - 对协议提供默认方法
 - 定义和使用新嵌套类型
 - 使现有类型符合协议
 */

//: 使用扩展为现有类新增计算属性和方法
extension NSObject {
    
    // 新增计算属性
    var count: Int {
        get { return 10 }
        set { print("extension count setter") }
    }
    
    // 新增类属性
    static var classParameter: Int = 10
    
    // 新增方法
    func newFunc() {
        print("new Function")
    }
    
    // 新增类方法
    class func classFunc() {    // 值类型对象使用static关键字 比如`struct`
        print("new class Function")
    }
    
    // 新增便利构造器
    convenience init(count: Int) {
        self.init()
        self.count = count
    }
    
    // 新增下标
    subscript(index: Int) -> Int {
        get { return count }
        set(newValue) { }
    }
}

NSObject().newFunc()
NSObject.classFunc()
NSObject.classParameter = 20

protocol ExtensionProtocol { }

//: 对协议提供方法
extension ExtensionProtocol {
    
    func protocolFunc() {
        print("extension protocol function one")
    }
}

//: 使现有类型符合协议
extension UIView: ExtensionProtocol {  }
UIView().protocolFunc()

// 使用 `where` 指定实现该扩展协议的类必须是 `NSObject` 对象或其子类
extension ExtensionProtocol where Self: NSObject {
    func protocolFuncTwo() {
        print("extension protocol function two")
    }
}

//: 使NSObject对象遵守 `ExtensionProtocol` 协议
class NSObject: ExtensionProtocol { }
NSObject().protocolFunc()
NSObject().protocolFuncTwo()


// 非 `NSObject` 对象或非 `NSObject` 子类无法调用该协议的 `protocolFuncTwo` 方法
class NotNSObject: ExtensionProtocol { }
NotNSObject().protocolFunc()
//NotNSObject().protocolFuncTwo()    // error


//: [Next](@next)
