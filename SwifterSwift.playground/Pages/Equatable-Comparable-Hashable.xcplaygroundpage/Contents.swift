//: [Previous](@previous)


/*:
 - Equatable
 - Comparable
 - Hashable
 */

//: 继承 `Equatable` 的 `struct`、`enum`， 可以让它们进行相等性比较，`swift` 中的基础数据类型包括 `Array`、`Dictionary` 等都默认实现了该协议
//:
//: 下面用简单的示例来解释如何使用 `Equatable` 实现对等性的判断
struct Person {
    var name: String
    var age: Int
    var sex: Int
}

let p1 = Person(name: "John", age: 22, sex: 1)
let p2 = Person(name: "Jane", age: 25, sex: 2)

// 默认你无法对 p1 p2 进行比较是否是同一个人
//if p1 == p2 {
//    print("the some people")
//}

/// 我们实现 `Equatable` 协议让 `Person` 可比较
//extension Person: Equatable {
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        return lhs.name == rhs.name &&
//        lhs.age == rhs.age &&
//        lhs.sex == rhs.sex
//    }
//}

//: 在 Swift4.1 中 Apple 为实现 `Equatable` 的对象提供了默认的合成方法，所以现在我们可以仅仅声明符合 `Equatable` 协议即可实现相等性的比较了
extension Person: Equatable {}

// 现在我们可以比较两个人是否是同一个人了
if p1 == p2 {
    print("the some people")
} else {
    print("not the some people")
}


print("\n ================================= \n")


//: 如果你希望对一组 `Person` 对象进行排序，那么你可以使用 `sorted` 方法
let persons = [Person(name: "John", age: 22, sex: 1),
                Person(name: "Jane", age: 25, sex: 2),
                Person(name: "Taylor", age: 16, sex: 2),
                Person(name: "Adele", age: 40, sex: 2)]
let r1 = persons.sorted { $0.name < $1.name }
print(r1)

//: 有时候我们需要更复杂的排序逻辑，那么使用 `sorted` 方法就显得十分啰嗦, 那么我们可以使 Person 符合 `Comparable` 协议来对排序进行处理
extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.age > rhs.age
    }
}

let r2 = persons.sorted()
print(r2)


print("\n ================================= \n")

//: `Hashable`, 符合 `Hashalbe` 的实例需要提供合成一个 `hashValue` 的算法, 改算法应该尽量减少 `hashValue` 碰撞的几率同时要保证合成的性能
//:
//: 前面的示例中我们可以将 `Person` 类型的实例存储在 `Array` 中，但是目前我们无法将其存储到 `Set`、中或作为 `Diactionary` 的 `key`

// 下面两条语句无法通过编译
//let sets: Set = Set(persons)
//let dicts = [p1: "User"]

//: 如果需要将 `Person` 存储到 `Set` 中或者作为 `Diactionary` 的 `key`, 我们需要让 `Person` 符合 `Hashable` 协议
//:
//: Swift4.2 中优化了对 `hashValue` 的合成，现在我们可以通过 `Hasher` 让系统为我们来合成 `hashValue`
extension Person: Hashable {
    
    // 默认的如果默默什么都不是实现，Swift 将自动合成 hashValue
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(name)
//        hasher.combine(age)
//        hasher.combine(sex)
//    }
}

// 现在我们可以在 Set 和 Dictionary 中使用它们了
let sets: Set = Set(persons)
let dicts = [p1: "User", p2: "Person"]
print("p1 hashValue: \(p1.hashValue), p2 hashValue: \(p2.hashValue)")


//: [Next](@next)
