//: [Previous](@previous)


import UIKit

var str = "Hello, playground"

/*:
 - 新增 `CaseInterable` 协议
    > 定义的枚举遵循 `CaseInterable` 协议后，编译时会自动合成一个 `allCases` 属性，包含枚举的所有 `case` 项的数组
 
 - `#warning` 和 `#error` 编译指令
    > `#warning` 主要用于提醒你或者别人一些工作还没有完成，`Xcode` 模板常使用 `#warning` 标记一些你需要替换成自己代码的方法存根(method stubs)。
    > `#error` 主要用于如果你发送一个库，需要其他开发者提供一些数据。比如，一个网络 `API` 的认证密码，你需要用户输入它们自己的密码，就使用 `#error` 在继续之前强制他们更改这行代码
 
 - 动态成员查找
    > `@dynamicMemberLookup`: 可以让 `Swift` 以一种下标方法去进行属性访问
    > `@dynamicCallable`: 动态传参
    > `subscript(dynamicMember:)`：可以通过所请求属性的字符串名得到，并且可以返回你想要的任何值
 
 - 新的随机数 `API`
    > 可以通过调用 `random()` 随机数方法来生成一个随机数, 只需提供一个随机数范围即可
 
 - 数组的相关更新
    > 支持使用新方法 `shuffle()` 和 `shuffled()` 方法对数组元素进行重新随机排序
    > `randomElement()`: 数组的一个新方法, 如果数组部位空, 则返回数组中的一个随机元素, 否则返回 `nil`
    > 提供了 `last(where:)` 和 `lastIndex(where:)` 方法来获取数组中满足条件的最后的元素和索引值
 
- 更简单，更安全的哈希，4.2中新增了新的 `Hasher` 结构，它提供了一个随机播种的通用散列函数
 
 - `allSatisfy()` 一种检查序列中的所有元素是否满足条件的新方法
 - 布尔切换，引入了一种新的 `toggle()` 方法, 可以将布尔值取反
 */

enum NetState: CaseIterable {
    
    case wifi
    case hotWifi
    case mobile
    case none
}



print(NetState.allCases)

//: `allCases` 的自动合成仅替换没有参数的 `case` 值, 但是如果需要你需要所有 `case` 值, 可以重写 `allCases` 属性自己添加
enum FoodKind: CaseIterable {
    //此处, 必须重写allCases属性, 否则报错
    static var allCases: [FoodKind] {
        return [.apple, .pear, .orange(look: false)]
    }
    
    case apple
    case pear
    case orange(look: Bool)

}


//: 动态成员查找 - 见 [Subscript](Subscript)
// 默认的如果不声明为 @dynamicMemberLookup 则会编译错误（因为Swift是一门类型安全的语言，如果没有定义对应属性会直接报错）
// 返回值除了下面列出的 String、Int 类型，也可以是返回一个函数
// 支持继承
@dynamicMemberLookup
struct Titan {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Titanjun", "city": "Hang"]
        return properties[member, default: "0"] //默认值
    }
    
    // 重载方法以返回不同类型的值（Int类型）
    subscript(dynamicMember member: String) -> Int {
        let properties = ["age": 20, "source": 99]
        return properties[member, default: 0] //默认值
    }

}

let titan = Titan()
let name: String = titan.name
let age: Int = titan.age


// 用途，作为语法糖可以简化一些操作
// 默认的你需要这样来Json进行解析
// json[0]?["name"]?["first"]?.stringValue
// 通过定义动态查找成语后：
@dynamicMemberLookup
enum JSON {
    case intValue(Int)
    case stringValue(String)
    case arrayValue(Array<JSON>)
    case dictionaryValue(Dictionary<String, JSON>)
    
    var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }
        return nil
    }
    
    subscript(index: Int) -> JSON? {
        if case .arrayValue(let arr) = self {
            return index < arr.count ? arr[index] : nil
        }
        return nil
    }
    
    subscript(key: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[key]
        }
        return nil
    }
    
    subscript(dynamicMember member: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[member]
        }
        return nil
    }
}
// 写起来可以这样：
// json[0]?.name?.first?.stringValue

//: @dynamicCallable 动态传参
// 常规操作
//a = someValue(keyword1: 42, "foo", keyword2: 19)

// dynamicallyCall
//a = someValue.dynamicallyCall(withKeywordArguments: [
//    "keyword1": 42, "": "foo", "keyword2": 19
//    ])

//: 新随机数api
let ranInt = Int.random(in: 0..<5)
let ranFloat = Float.random(in: 0..<5)
let ranDouble = Double.random(in: 0..<5)
let ranCGFloat = CGFloat.random(in: 0..<5)
let ranBOOL = Bool.random()

//: 数组的随机排序
var albums = ["Red", "1989", "Reputation"]

// 没有返回值
albums.shuffle()

// 有返回值, 重新返回一个数组
let shuffled = albums.shuffled()

//: 获取数组中的随机元素
if let random = albums.randomElement() {
    print("The random album is \(random).")
}

//：数组新增last，last(index：)方法
//获取满足条件的数组中的第一个值
let a = [20, 30, 10, 40, 20, 30, 10, 40, 20]
print(a.first(where: { $0 > 25 })!)
print(a.index(where: { $0 > 25 })!)
print(a.index(of: 10)!)

//在Swift4.1中
print((a.reversed().index(where: { $0 > 25 })?.base).map({ a.index(before: $0) })!)
//输出: 7

//Swift 4.2
//获取满足条件的元素
print(a.last(where: { $0 > 25 })!)   //40
//获取满足条件的元素的索引
print(a.lastIndex(where: { $0 > 25 })!)   //7

//: Hasher()
struct iPad: Hashable {
    var serialNumber: String
    var capacity: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(serialNumber)
    }
}

let first = iPad(serialNumber: "12345", capacity: 256)
let second = iPad(serialNumber: "54321", capacity: 512)

var hasher = Hasher()
hasher.combine(first)
hasher.combine(second)
let hash = hasher.finalize()

//: 检查元素是否满足条件
// 判断数组的所有元素是否全部大于85
let scores = [86, 88, 95, 92]
// 返回一个BOOL
let passed = scores.allSatisfy({ $0 > 85 })




//: [Next](@next)
