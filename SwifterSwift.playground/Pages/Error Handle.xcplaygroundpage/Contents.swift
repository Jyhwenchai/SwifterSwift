//: [Previous](@previous)

import UIKit

//: # 错误处理
/*:
 - 如何抛出错误
 - 如何使用 `do-catch`
 - 如何使用 `defer` 语句
 - API 可用性的检查
 */

//: 可以通过遵循 `Error` 协议来定义异常
enum RequestError: Error {
    case ParameterError
    case UnknowError(message: String)
}

typealias LoginInfo = (url: URL?, userId: Int, data: Dictionary<String, Any>)

//: 使用 `throws` 允许方法返回错误信息
func login(loginInfo: LoginInfo) throws {
    guard let _ = loginInfo.url else {
        throw RequestError.UnknowError(message: "not found requst url")
    }
    
    guard loginInfo.userId > 0  else {
        throw RequestError.ParameterError
    }
}

//: 我们也可以在正确的条件下返回期待的类型
func checkLoginInfo(loginInfo: LoginInfo) throws -> LoginInfo {
    if !loginInfo.data.isEmpty {
        // 成功返回正确的值
        return loginInfo
    } else {
        // 错误则抛出一个 Error
        throw RequestError.ParameterError
    }
}

//: 使用 `do-catch` 进行错误捕获
let requestInfo: LoginInfo = (URL(string: "/login"), 0, [:])
do {
    try login(loginInfo: requestInfo)
} catch RequestError.ParameterError {
    print("参数错误")
} catch RequestError.UnknowError(let message) {
    print(message)
}

//: 我们也可以让错误传播而不是立即处理
func errorFunc() throws {
    try checkLoginInfo(loginInfo: requestInfo)
}

let request: LoginInfo = (URL(string: "/login"), 0, ["login_type": "User"])
//: 可以使用 try? 尝试得到一个正确的结果，而不需要使用 `do-catch` 进行错误处理，这样会得到一个可选类型的变量，你需要对这个变量进行解包 (if let) 操作
if let loginInfo = try? checkLoginInfo(loginInfo: request) {
    print("loginInfo.url: \(loginInfo.url!.absoluteString), userId: \(loginInfo.userId), data: \(loginInfo.data)")
}

//: 你可以可以使用 try! 来表示你确定不会抛出错误，但这么做并不安全！你应该避免这么做，因为一旦出现了异常程序将会崩溃
let result = try! checkLoginInfo(loginInfo: request)

//: 可以使用 `defer` 语句来在代码执行完成后进行一些清理操作，无论这个过程是否有抛出错误或者是正确的执行
func deferFunc() {
    print("function start")
    var str: String?
    
    defer {
        print("in defer")
        if let s = str {
            print("str is \(s)")
        }
    }
    
    str = "Swifter"
    print("function end")
}

deferFunc()


/// API 可用性的检查
/// #available() 中可以表达多个
/// iOS 表示 iOS 系统， OSX 表示 OSX 系统，watchOS 表示 watchOS 系统， tvOS 表示 tvOS 系统
if #available(iOS 9.0, OSX 10.10, *) {
    print("可使用 iOS 9.0, OSX 10.10 及更高版本")
}

if #available(iOS 9.0, *) {
    print("可使用 iOS 9.0 及更高版本")
} else {
    print("可使用低于 iOS 9.0 版本")
}

if #unavailable(iOS 9.0) {
    print("可使用低于 iOS 9.0 版本")
} else {
    print("可使用 iOS 9.0 及更高版本")
}

//: [Next](@next)
