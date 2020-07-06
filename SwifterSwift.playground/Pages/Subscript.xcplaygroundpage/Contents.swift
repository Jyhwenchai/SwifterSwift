//: [Previous](@previous)

import UIKit

/*:
 # Subscript （下标）
 
 你可以在 `class`, `struct`, 和 `enum` 中定义下标，使用下标后你可以对 `Array` 中的实例对象使用 `array[index]` 进行访问, 对 `Dictionary` 实例中的元素使用 `soomeDictionary[key]` 进行访问。
 
 你可以为一个类型定义多个下标或者是不同类型的参数。
 
 ## Subscript 语法
 下标的语法使用 `subscript` 作为关键字，可以接收参数以及类似于计算属性的 `get` 和 `set` 的语法。在 `subscript` 的参数列表中可以定义多个参数，同时它支持读写或者是只读的操作。
 
     subscript(index: Int) -> Int {
         get {
             // Return an appropriate subscript value here.
         }
         set(newValue) {
             // Perform a suitable setting action here.
         }
     }
 */

//: ## 可读写的下标与只读下标
//: 下面的例子定义了一个可进行读写操作的下标，默认的在 `set` 提供了一个叫 `newValue` 的参数，我们可以直接使用它而不用显式的在以 `set(newValue)` 的方式进行书写
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

var names = Names()
names[0] = "Jack"
print("first item: \(names[0])")

//: 下面定义了只读的下标，只读下标可以使用与只读计算属性相似的语法来省略 `get` 关键字
struct ReadOnly {
    
    var names: [String]
    
    subscript(index: Int) -> String {
        return names[index]
    }
}


//: ## 下标定义的多种方式
//: * 带有多个参数的下标
//: * 带有可变参数的下标
//: * 带有默认参数的下标
//: 下面的示例演示了带有多个参数的下标
struct Matrix {
    let rows: Int, colums: Int
    var grid: [Double]
    
    init(rows: Int, colums: Int) {
        self.rows = rows
        self.colums = colums
        grid = Array(repeating: 0, count: rows * colums)
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            return grid[row * column]
        }
        set {
            grid[row * column] = newValue
        }
    }
}

//: 下面示例演示了带有可变参数的下标
struct Army {
    let soldiers: [Int: String]
    
    subscript(numbers: Int...) -> [String] {
        var names = [String]()
        numbers.forEach { number in
            names.append(soldiers[number]!)
        }
        return names
    }
}

//: 下面示例演示了带有默认参数的下标
struct RandomColor {
    let colors = [UIColor.red, .yellow, .blue]
    subscript(_ colorIndex: Int = Int.random(in: 0...2)) -> UIColor {
        return colors[colorIndex % 3]
    }
}

//: ## 类型下标
//: 之前所有的下标示例都是基于实例对象的使用，实际上下标也可以在类型上直接使用
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)


//: ## 下标的重载
//: 我们可以在子类中对父类已有的下标进行重载，如下示例：
class Base {
    var names = ["1", "2", "3"]
    subscript(index: Int) -> String {
        return names[index]
    }
}

class Child: Base {
    override subscript(index: Int) -> String {
        get {
            return "name - \(names[index])"
        }
        set {
            names[index] = newValue
        }
    }
}

let base = Base()
//base[0] = "4"     // error 只读下标不能赋值
let child = Child()
child[0] = "5"  // 重载后为可进行读写操作的下标
print(base[0], " - " ,child[0])

struct GenericSubscript<G> {
    let value: G
    subscript<S>(_ key: S) -> [S: G] {
        return [key: value]
    }
}

//:
//: ## @dynamicMemberLookup
//:
//: `swift` 提供了动态查找成员的方式来访问属性，简单的说就是允许你访问一个未定义的属性
//:
//: 动态查找成员使用关键字 `@dynamicMemberLookup` 修饰，并实现 `subscript(dynamicMember key: String) -> String { }` 下标
//:
//: 你可以在 （`enum`, `struct`, `class`, `protocol`） 中使用它
//:
//: 首先我们看下面通过计算属性 `fullName` 来得到完整的用户名称的例子：
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

//: 另外动态查找成员也是可以继承和重载的
@dynamicMemberLookup
class Animal {
    subscript(dynamicMember key: String) -> String {
        return "Animal run"
    }
}

class Dog: Animal {
    override subscript(dynamicMember key: String) -> String {
        return "Dog run"
    }
}
let dog = Dog()
print(dog.run)

//: - Experiment:
//: 原理：动态查找成员的原理其实就是将点语法转换成下标语法进行访问, 如之前的 `dog.run` => `dog[dynamicMember: "run"]` 的形式


//: ## @dynamicCallable
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


//: 如果只定义了 `dynamicallyCall(withKeywordArguments:)` 方法，那么处理的行为示例所示
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


//: ## 补充
//: 在 `static subscript` 中使用 `@dynamicMemberLookup` 会发生循环引用
@dynamicMemberLookup
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


    public static subscript(dynamicMember name: String) -> String? {
        get { return self[name] }
//        set { self.rname = newValue }   // 导致循环引用
    }

}

//Environment.PATH! += ":/some/path"
//print(Environment.PATH!)

//: `@dynamicMemberLookup` 也对泛型支持
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
