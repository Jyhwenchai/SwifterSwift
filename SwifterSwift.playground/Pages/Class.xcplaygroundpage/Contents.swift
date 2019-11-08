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


/*: Swift 中的 class
 - 类的定义
 - 存储属性和计算属性
 - 初始化过程
 - 可失败的初始化
 */

//: 定义一个没有任何属性、方法的类, 以 `class` 为关键字，ClassA 为类名，花括号结尾
class ClassA {
    
}

//: 一个类可以继承于另一个类，这里 ClassB 继承于父类 NSObject
class ClassB: NSObject {
    
}

//: 一个类可以遵循某个协议，这里 ClassC 继承于类 NSObject, 实现了协议ProtocolA
protocol ProtocolA {}
class ClassC: NSObject, ProtocolA {

}

//: 类的存储属性、计算属性、下标
class ClassD {
    // 定义 `Int` 类型的存储属性，并给定初始值0
    var count: Int = 0
    
    // 定义了一个可变类型的存储属性，并给定一个初始值
    var firstName = "firstName"
    
    // 定义了一个常量存储属性，只能进行一次赋值，赋值后就无法进行修改
    let lastName = "lastName"
    
    // 定义了一个懒加载存储属性，懒加载存储属性只有第一次用到时才会执行 `Int()` 进行初始化，否则将永远不会进行初始化
    lazy var lazyValue: Int = Int()
    
    // 或则可以样书写懒加载属性的初始化方式
    lazy var otherLazyValue: Int = {
        return Int()
    }()
    
    
    // 计算属性
    var name: String {
        get { return firstName + "-" + lastName }  // get 方法
        set { print(newValue) } // set 方法，默认新值变量名为`newValue`,
        
        /// 不要企图使用下列花括号中的语句，这里与 OC 不同，swift 中的计算属性不能用来存储一个值，
        /// 这样的写法会引起循环引用，相当于在 OC 中的 `set` 方法里执行 `self.` 的操作
        /// set {
        ///     name = newValue
        /// }
    }
    
    // 只读的计算属性可以使用更简练的写法
    var fullName: String {
        return firstName + "." + lastName
    }
    
    
    // 属性监听器，对于存储属性，我们可以给它添加属性监听器，
    // 属性改变之前触发 willSet 方法，属性改变之后触发 didSet 方法
    var changeName: String = "" {
        willSet {
            if newValue.hasPrefix("Swift") {    // 可以在属性监听器里对新值进行各种处理
                firstName = newValue            // 可以属性监听器这里修改其它属性
            }
        }
        
        // 这里已经完成了对属性赋予新值的操作，那么你可以进行其它相关的事情，比如列表的刷新、布局更新等等
        didSet { print(oldValue) }
        
    }
    
    // 定义下标
    subscript(index: Int) -> Int {
        get {
            return count / index
        }
        set {
            count *= newValue
        }
    }
    
}

let classD = ClassD()
classD.name
classD.name = "czw-yixing"
classD.changeName = "Swifter"

classD.changeName
classD.name
classD.fullName

/*:
 初始化过程
 - 普通初始化方法 `init()` 称为`指定构造器`
 - 如果 `init()` 方法前带有 `convenience` 关键字，该初始化方法又称为`便利构造器`
 - 指定构造器中不能调用另一个指定构造器来初始化，便利构造器最终必须调用一个指定构造器进行初始化
 - 必须保证每一个非可选类型的属性都有一个默认值，可选类型默认值为 nil
 */
// 在未进行任何初始化方法的描述时，swift 会提供一个默认的初始化方法 `init()`, 你也可以显示的书写出来，并进行一些初始化操作
class ClassBase {
    init() {
        print("init ClassBase")
    }
}

// 如果一个类继承了父类，它将继承父类的初始化方法，你可以重写初始化方法
class classChild: ClassBase {
   override init() {    // 可以尝试注释掉该方法运行查看结果
        print("init classChild")
        // 这里会默认执行`super.init()`, 你也可以显示的书写出来
    }
}

ClassBase()     // 这里执行结果："init ClassBase"
classChild()    // 这里执行结果：1. init classChild"   2."init ClassBase"


//: 在构造方法中对属性进行初始化
// 在 `swift` 中在初始化完成前必须对所有的存储属性赋值一个值，对于 `Optional` 类型，nil 也是它的一个值
class ClassE {
    var weight = 124.0  // 定义时直接初始化
    var height: Double
    var isHuman: Bool
    
    init() {
        height = 170    // 必须在指定构造器中对每个存储属性初始化一个默认值
        isHuman = false
    }
    
    // 也可以定义带参数的指定构造器来初始化存储属性的值
    // 类属性与参数同名的时候需要显示的书写出 `self` => self.weight 来指明属性是当前类的属性
    init(weight: Double, height: Double, isHuman: Bool) {
        self.weight = weight;
        self.height = height;
        self.isHuman = isHuman
    }
    
    // 便利构造器，其可以为属性提供一些默认值
    convenience init(weight: Double, height: Double) {
//        self.isHuman = true // error
        self.init(weight: weight, height: height, isHuman: true)
//        self.isHuman = false // pass, 在修改属性前必须保证所有属性已经初始化
    }
}

ClassE()
ClassE(weight: 200, height: 200, isHuman: false)
let eObj = ClassE(weight: 200, height: 200)            // 使用便利构造器进行初始化
eObj.isHuman

// 继承于ClassE, 则可以使用其所有指定构造器、便利构造器
class ClassEChild: ClassE {
    
}

ClassEChild()
ClassEChild(weight: 100, height: 100, isHuman: true)
ClassEChild(weight: 100, height: 100)


class ClassEChild2: ClassE {
    var age: Int = 0    //  新增属性会导致无法使用子类构造器
    
    // 这里需要重新给定一个指定构造器
    init(age: Int) {
        self.age = age
        super.init()
    }
    
    override init(weight: Double, height: Double, isHuman: Bool) {
        self.age = 0
        super.init(weight: weight, height: height, isHuman: isHuman)
    }
}

// 下面两个创建实例的调用会失败，因为子类创建了一个新的存储属性，导致无法直接使用子类的初始化方法
//ClassEChild2()
//ClassEChild2(weight: 100, height: 100)

// 当然如果你重写父类的初始化方法后，那么就可以使用了
//ClassEChild2(weight: 100, height: 100, isHuman: true)

// 使用子类的初始化方法创建实例
ClassEChild2(age: 23)

print(" \n================ \n")

//: 可失败的初始化
//: 有时候我们需要对初始化的内容进行一些限制，并不是所有的输入都是可初始化的，
//: 那么 swift 中提供了可失败的初始化方法来进行处理,
//: 可失败的初始化的表示方式是在 `init?`, 即在 `init` 关键字后面跟上一个问号

class ClassF {
    var count = 0
    
    init?(count: Int) {
        if count < 0 {
            return nil
        }
        self.count = count
    }
}

let objF1 = ClassF(count: 10)
print("count: \(objF1!.count)")
let objF2 = ClassF(count: -10)
print("count: \(objF2?.count ?? 0)")



print(" \n================ \n")

//: 类的继承
//:
//: - 一个类继承一个父类后，它拥有父类所有的属性及方法，它可以为父类的`存储属性`添加属性观察者，也可以额外新增属性、方法
//:
//: - 我们也可以添加 `override` 关键字来表示重写父类的`方法`、`属性`或者`下标`
//:
//: - 如果需要防止一个类或则类中的属性或方法在子类中被重写，你可以加入 `final` 关键字

class Base {
    var name = "default"
    var age = 0
    var color: String {
        return "Base color is red"
    }
    
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func printNameAndAge() {
        print("name: \(name), age: \(age)")
    }
    
    func description() {
        print("empty describe")
    }
}

class Child: Base {
    // 为 name 属性添加属性观察者
    override var name: String {
        willSet {
            print("will change name: \(newValue)")
        }
        
        didSet {
            print("did change name: \(oldValue)")
        }
    }
    
    // 重写父类的计算属性
    override var color: String {
        return "Child color is blue"
    }

    // 重写父类方法
    override func description() {
        print("override Base class describe method")
    }
}

let baseA = Base(name: "John", age: 22)
baseA.printNameAndAge()
baseA.description()

print("\n===============\n")
let childA = Child(name: "John", age: 22)
childA.printNameAndAge()
childA.name = "Jones"
childA.printNameAndAge()
childA.description()


// 通过 `final` 防止继承、重写属性、方法、下标等
final class FinalClassA {}

//class ChildA: FinalClassA {}  // error

class FinalClassB {
    final var name: String = "default"
    
    final func method() {
        print("final method")
    }
}

class ChildB: FinalClassB {
    // 无法重写 `final` 声明的属性和方法
}


//: [Next](@next)
