//: [Previous](@previous)

/*:
 # Key Path Expressions as Functions(键路径表达式作为函数)
 
 在     [SE-0249](https://github.com/apple/swift-evolution/blob/master/proposals/0249-key-path-literal-function-expressions.md) 中引入了使用键值表达式的便捷方式。
 
 在 Swift5.2 中我们可以使用 `\Root.value` 的键值表达式使用在任何定义为 `(Root) -> Value` 函数的地方。下面使用 `User` 的例子作为示例。
 
 */

struct User {
    let firstName: String
    let lastName: String?
    
    var fullName: String {
        return firstName + (lastName ?? "")
    }
}


/*:
 创建一些 `User` 实例并存储在数组中
 */
let userA = User(firstName: "A_", lastName: "A")
let userB = User(firstName: "B_", lastName: "B")
var userC = User(firstName: "C_", lastName: "C")
let users = [userA, userB, userC]

/*:
 在 Swift5.2 之前如果我们想要获得所有用户的 `firstName`，那么我们需要这么做：
 */
let firstNames = users.map { $0.firstName }
/*:
 在 Swift5.2 开始我们可以使用键值表达式得到所有用户的 `firstName`:
 */
let newFirstNames = users.map(\.firstName)


//: [Next](@next)

