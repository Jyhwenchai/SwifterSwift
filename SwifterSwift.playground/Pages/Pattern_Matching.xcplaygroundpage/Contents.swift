//: [Previous](@previous)

import UIKit

//: # 模式匹配
/*:
 在 `swift` 中模式匹配是一个非常强大的功能，它使你的代码变的更加清晰简洁
 
 - if else 条件语句
 - if let | guard let
 - if case let | guard case let
 - switch 中的模式匹配
 - 对元组进行模式匹配
 - 对Range进行模式匹配
 - 对类型进行模式匹配
 */

//: `swift` 的 `if else`, 在 `swift` 不需要使用括号包裹条件体
let intValue = 100

if intValue > 99 {
    print(intValue)
} else {
    print(intValue)
}

/*:
  `if let` (适用于 `Optional` 类型)
 - 如果可选类型非 `nil` 则进入 `if` 分支,否则进入 `else` 分支
 - `guard let` 判断与其相反
 */

var doubleValue: Double? = 20
example {
    if let doubleValue = doubleValue {
        print(doubleValue)
    } else {
        print("doubleValue is nil")
    }
}

doubleValue = nil
example {
    guard let doubleValue = doubleValue else {
        print("doubleValue is nil")
        return
    }
    print(doubleValue)
}

/*:
 可以使用 if case let | guard case let 对枚举值进行筛选
 - if case let x = y { ... } 相当于 switch y { case let x: ... }
 */
enum Media {
    case Book(title: String, author: String, year: Int)
    case Movie(title: String, director: String, year: Int)
    case WebSite(urlString: String)
}

let m = Media.Movie(title: "Captain America: Civil War", director: "Russo Brothers", year: 2016)
if case let Media.Book(title, _, _) = m {
    print("This is a movie named \(title)")
} else {
    print("This is not a movie")
}

//: 相当于
switch m {
    case let Media.Book(title, _, _):
        print("This is a movie named \(title)")
    default:
        print("This is not a movie")
}

//: if case let 与附加多个条件一起使用
if case let Media.Movie(_, _, year) = m, year < 2018 {
    print("the movie's year is before the first movie ever made")
}

//: guard case let
example {
    guard case let Media.Movie(_, _, year) = m, year < 2018 else {
        print("guard case let")
        return
    }
    print("out guard case let")
}

/*:
 - `switch` 中使用 `case`
 - `switch` 使用 `case let where`
 */
enum Direction {
    case North, South, East, West
}

extension Direction: CustomStringConvertible {
    var description: String {
        switch self {
            case .North: return "↑"
            case .South: return "↓"
            case .East:  return "→"
            case .West:  return "←"
        }
    }
}


//: 使用case let where
extension Media {
    var publishedAfter1930: Bool {
        switch self {
            case let .Book(_, _, year) where year > 1930: return true
            case let .Movie(_, _, year) where year > 1930: return true
            case .WebSite: return true // 它的另一种写法是 "case .WebSite(_)"，只不过这里忽略了其关联的元组值，所以使用这种更简单的写法
            default: return false
        }
    }
}



//: 对元组进行模式匹配,在 `case` 中使用 `_` 省略值，使用 `where` 进行条件约束
let point = CGPoint(x: 7, y: 0)
switch (point.x, point.y) {
    case (0, 0): print("On the origin!")
    case (0, _): print("x=0: on Y-axis!")
    case (_, 0): print("y=0: on X-axis!")
    case (let x, let y) where x == y: print("On y=x")
    default: print("Quite a random point here.")
}



/*:
 对 Range 进行模式匹配,`Range<T>` 是一个泛型类型
 - 我们可以使用 `Range(start: 1900, end: 2000)` 来显式地声明一个 `range`，也可以使用语法糖区间操作符 `..<`（不包含右测的结束值）或 `...`（包含右侧结束值），所以我们也可以将 `Range(start: 1900, end: 2000)` 改为 `1900..<2000`
 */
let count = 7
switch count {
    case Int.min..<0: print("Negative count, really?")
    case 0: print("Nothing")
    case 1: print("One")
    case 2..<5: print("A few")
    case 5..<10: print("Some")
    default: print("Many")
}

// 字母间也可以使用区间操作符进行匹配
func charType(car: Character) -> String {
    switch car {
    case "A", "E", "I", "O", "U", "Y", "a", "e", "i", "o", "u", "y":
        return "Vowel"
    case "A"..."Z", "a"..."z":
        return "Consonant"
    default:
        return "Other"
    }
}
print("Jules Verne".map{charType(car: $0)})


/*:
 对类型进行模式匹配
 使用 case let as、case let as?、case let as! 和 is 进行匹配
 */

protocol Medium {
    var title: String { get }
}
struct Book: Medium {
    let title: String
    let author: String
    let year: Int
}
struct Movie: Medium {
    let title: String
    let director: String
    let year: Int
}
struct WebSite: Medium {
    let url: NSURL
    let title: String
}

//: 一组遵循 `Medium` 协议的对象
let media: [Medium] = [
    Book(title: "20,000 leagues under the sea", author: "Jules Vernes", year: 1870),
    Movie(title: "20,000 leagues under the sea", director: "Richard Fleischer", year: 1955)
]

//: 使用 as、is 进行匹配
//:
//: > as 和 is 区别是 as 用来进行类型转换，将一个变量转换为另一种指定的类型，当然这不一定会转换成功。而 is 仅用来判断一个变量是否是指定的类型
for medium in media {
   
    print(medium.title)
   
    switch medium {
    case let value as Book: // 这里尝试将 medium 转换为 book 类型
        print("Book published in \(value.year)")
    case let value as Movie:
        print("Movie released in \(value.year)")
    case is WebSite:    // 判断 medium 是否为 WebSite 类型
        print("A WebSite with no date")
    default:
        print("No year info for \(medium)")
    }
}

// 定义 `Person` 基类
class Person {
    var name : String
    
    init(_ name: String){
        self.name = name
    }
}

// 定义 `Student` 类
class Student : Person {}

// 定义 `Teacher` 类
class Teacher : Person {}

//: 使用 is 进行类型判断
func showPersonName(_ people : Person){
    let name = people.name
    let string = people is Student ? "学生" : "老师"
    print("这个\(string)的名字是: \(name)")
}

var person: Person?
var student = Student("Tom");
var teacher = Teacher("Kevin Jakson");

//： 使用 as 进行向上的类型转换
let person1 = student as Person
let person2 = teacher as Person

// showPersonName 函数可以正确的输出 name 属性
showPersonName(person1)
showPersonName(person2)



/*:
 `swift` 模式匹配 && `override ~= operator`
 Swift 的 switch 使用 ~= 操作符进行模式匹配，
 
     switch rhs {
        case lhs
     }
 
 `~=` 操作符有两个参数，其中 lhs 是左参数， rhs 是右参数。swift 在进行模式匹配时隐式调用 ~= 操作符。
 
 下面👇的例子总 ~= 的算法是：左参数(lhs)是一个 Affine 对象，右参数(rhs)是一个 Int 类型， 输入一个 rhs 如果 rhs % lhs.a 的值等于 lhs.b 则返回 true，否则为 false。
 */

struct Affine {
    var a: Int
    var b: Int
}

// lhs为左参数，rhs为右参数
func ~= (lhs: Affine, rhs: Int) -> Bool {
    return rhs % lhs.a == lhs.b
}

switch 5 {
    case Affine(a: 2, b: 0): print("Even number")
    case Affine(a: 3, b: 1): print("3x+1")
    case Affine(a: 3, b: 2): print("3x+2")
    default: print("Other")
}


//: [Next](@next)
