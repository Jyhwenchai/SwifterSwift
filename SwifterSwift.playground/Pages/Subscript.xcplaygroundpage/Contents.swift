//: [Previous](@previous)

import UIKit

/*:
 ### Subscript 下标
 
 你可以在 `class`, `struct`, 和 `enum` 中定义下标，使用下标后你可以应用实例对象跟数组一样访问元素的值 `array[index]`, 本质上数组的的这种访问方式也是定义了下标的原因，此外你可以为一个类型定义多个下标。
 
 下标的语法使用 `subscript` 作为关键字，可以接收参数以及类似于计算属性的 `get` 和 `set` 方法
 
     subscript(index: Int) -> Int {
         get {
             // Return an appropriate subscript value here.
         }
         set(newValue) {
             // Perform a suitable setting action here.
         }
     }


 - 创建和使用下标
 - 动态查找成员
 - 静态下标 （static subscript） Swift5.1 - SE-0254
 - @dynamicMemberLookup 对泛型的支持
 */

//: swift 中使用关键字 `subscript` 定义下标
//:
//: 如果下标是只读的，那么只需实现 `subscript` 中的 `get` 即可
struct Names {
    var names = ["John", "Swifter", "nick"]
    
    subscript(index: Int) -> String {
        get {
            return names[index]
        }
        
        set {
            names[index] = newValue
        }
    }
    
}

//: 下标的使用就像访问数组的元素一样
var names = Names()
names[0] = "Jack"
print("first item: \(names[0])")

//: 如果需要可以对下标进行重载
class Base {
    var names = ["1", "2", "3"]
    subscript(index: Int) -> String {
        return names[index]
    }
}

class Child: Base {
    var count: Int {
       return names.compactMap {Int($0)}.reduce(0){$0 + $1}
    }
    override subscript(index: Int) -> String {
        get {
            return "\(count) - \(names[index])"
        }
        
        set {
            names[index] = newValue
        }
    }
    
    // 只读下标的简写, 也可以提供一个外部参数
    subscript(add index: Int) -> Int {
        return count + index
    }
}

var child = Child()
child[0] = "5"
let count = child[add: 3]
print("first name: \(child[0]), count: \(count)")


//: ### 动态查找成员
//:
//: `swift` 提供了动态查找成员的方式来访问属性，简单的说就是允许你访问一个未定义的属性
//:
//: 动态查找成员使用关键字 `@dynamicMemberLookup` 修饰，并实现 `subscript(dynamicMember key: String) -> String { }` 下标
//:
//: 你可以在 （`enum`, `struct`, `class`, `protocol`） 中使用它
//:
//: 首先我们看下面例子中通过计算属性 `fullName` 来得到完整的用户名称
struct Person {
    var firstName: String
    var lastName: String
    
    // 通过计算属性来获取 fullName
    var fullName: String {
        return firstName + lastName
    }
    
}
 
let person = Person(firstName: "Will", lastName: "Smith")
print("person fullName: \(person.fullName)")


//: 如果使用动态查找成员的方式来实现，我们可以在不定义计算属性 `fullName` 的情况下也能使用点语法来访问 `fullName`
@dynamicMemberLookup
struct DynamicMemeberPerson {
    var firstName: String
    var lastName: String
    
    subscript(dynamicMember key: String) -> String {
        switch key{
        case "firstName":
            return firstName
        case "lastName":
            return lastName
        case "fullName":
            return firstName + " " + lastName
        default:
            return ""
        }
    }
}

let dmPerson = DynamicMemeberPerson(firstName: "Taylor", lastName: "Swift")
print("person fullName: \(dmPerson.fullName)")

//: 动态成员查找也可以通过重载 `subscript` 返回不同的类型, 这时候在使用的时候你需要指明动态查找成员的类型，否则将无法编译通过
@dynamicMemberLookup
struct DynamicMemeberStruct {
  
    subscript(dynamicMember key: String) -> String {
        return "Hello"
    }
    
    subscript(dynamicMember key: String) -> Int {
        return 22
    }
}

let dms = DynamicMemeberStruct()
// 指明动态成员的类型
let hello: String = dms.hello
let age: Int = dms.age

print(hello)
print(age)

//: 另外动态查找成员是可以继承的
@dynamicMemberLookup
class Animal {
    subscript(dynamicMember key: String) -> String {
        return "run"
    }
}

class Dog: Animal {}
let dog = Dog()
print(dog.run)

//: - Experiment:
//: 原理：动态查找成员的原理其实就是将点语法转换成下标语法进行访问, 如之前的 `dog.run` => `dog[dynamicMember: "run"]` 的形式

//: 与 `@dynamicMemberLookup` 对应的另外一个标记是 `@dynamicCallable`， 该标记使 `struct`、`class` 具有直接调用的能力
//:
//: 与 `@dynamicCallable` 配对的有两个方法
//: - `dynamicallyCall(withArguments:)`
//: - `dynamicallyCall(withKeywordArguments:)`

@dynamicCallable
struct Callable {
  func dynamicallyCall(withArguments args: [Int]) -> Int { return args.count }
}

let c1 = Callable()
//: 现在可以像调用方法一样直接调用实例对象
c1() // 执行 `c1.dynamicallyCall(withArguments: [])`
//: 同时也可以带有参数
c1(1, 2) // 执行 `c1.dynamicallyCall(withArguments: [1, 2])`

//: 如果只定义了 `dynamicallyCall(withArguments:)` 方法，那么将无法使用带参数标签的访问方式
// c1(a: 1, 2) // 错误，没用定义 `withKeywordArguments` 方法


//: 如果只定义了 `withKeywordArguments:` 方法，那么处理的行为示例所示
@dynamicCallable
struct KeywordCallable {
  func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Int>) -> Int {
    return args.count
  }
}
let c2 = KeywordCallable()
c2() // 执行 `c2.dynamicallyCall(withKeywordArguments: [:])`
c2(1, 2) // 执行 `c2.dynamicallyCall(withKeywordArguments: ["": 1, "": 2])`
c2(a: 1, 2) // 执行 `c2.dynamicallyCall(withKeywordArguments: ["a": 1, "": 2])`

//: 如果同时定义了 `withArguments:` 与 `withKeywordArguments:` 方法，那么处理的行为将根据参数自动选择合适的一个
@dynamicCallable
struct BothCallable {
  func dynamicallyCall(withArguments args: [Int]) -> Int { return args.count }
  func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Int>) -> Int {
    return args.count
  }
}
let c3 = BothCallable()
c3() // 执行 `c3.dynamicallyCall(withArguments: [])`
c3(1, 2) // 执行 `c3.dynamicallyCall(withArguments: [1, 2])`
c3(a: 1, 2) // 执行 `c3.dynamicallyCall(withKeywordArguments: ["a": 1, "": 2])`


//: ### static subscript - Swift5.1
//: 你可以在之前任何可以声明下标的地方声明静态下标
public enum Environment {
  public static subscript(_ name: String) -> String? {
    get {
      return String(cString: getenv(name))
    }
    set {
      guard let newValue = newValue else {
        unsetenv(name)
        return
      }
      setenv(name, newValue, 1)
    }
  }
}

Environment["PATH"]! += ":/some/path"

print(Environment["PATH"]!)

//: 在 `static subscript` 中使用 `@dynamicMemberLookup` 会发生循环引用
@dynamicMemberLookup
public enum EnvironmentTwo {

    public static subscript(_ name: String) -> String? {
        get {
            return String(cString: getenv(name))
        }
        set {
            guard let newValue = newValue else {
                unsetenv(name)
                return
            }
            setenv(name, newValue, 1)
        }
    }


    public static subscript(dynamicMember name: String) -> String? {
        get { return self[name] }
//        set { self.rname = newValue }   // 导致循环引用
    }

}

//EnvironmentTwo.PATH! += ":/some/path"
//print(EnvironmentTwo.PATH!)

//：`@dynamicMemberLookup` 也对泛型支持
struct Point {
    var x: Float
    var y: Float
}

@dynamicMemberLookup
struct Circle<T> {
    let center: T
    let radio: Float
    
    subscript<U>(dynamicMember keyPath: KeyPath<T, U>) -> U {
        return center[keyPath: keyPath]
    }
}

let circle = Circle(center: Point(x: 5, y: 5), radio: 10)
print("circle center: (\(circle.x), \(circle.y))")


//: [Next](@next)
