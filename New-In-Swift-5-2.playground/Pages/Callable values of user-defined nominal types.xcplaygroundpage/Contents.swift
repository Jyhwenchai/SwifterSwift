//: [Previous](@previous)

/*:
 # Callable values of user-defined nominal types (用户定义的标称类型的可调用值)
 
 在 [SE-0253](https://github.com/apple/swift-evolution/blob/master/proposals/0253-callable.md) 中 Swift 实现了一个特殊的方法，只要你的值类型实现了这个方法那么你可以直接该值。
 
 如下面的例子中，我们创建了一个 `User` 实例，通过实现 `callAsFunction` 方法我们可以直接以 `user()` 的方式得到 `fullName` 而不必调用 `callAsFunction()` 方法。

 
 */

struct User {
    var firstName: String
    var lastName: String
    
    func callAsFunction() -> String {
        firstName + lastName
    }
}

let user = User(firstName: "Hello, ", lastName: "World!")
let fullName = user()

/*:
 在前面的例子中仅仅是定义了一个系统提供的一个固定的名为 `callAsFunction` 的方法，并没有提供任何参数或返回值。不过，实际上在满足名称匹配的基础上，我们可以进行任何所需要的修改，添加参数、返回值、返回异常或者是关键字等等。
 */
struct Walk {
    var stepCount = 0
    
    mutating func callAsFunction(step: Int) -> String {
        return "User took \(stepCount + step) steps."
    }
}

var walk = Walk(stepCount: 1000)
let steps = walk(step: 2000)


//: [Next](@next)
