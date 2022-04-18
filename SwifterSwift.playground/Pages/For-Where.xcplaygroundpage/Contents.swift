//: [Previous](@previous)

//: # 用于约束的 where 语句
/*:
 - 使用 where 进行过滤
 - 使用 for-[case let]-in
 - 使用for-[case let]-in-[where]
 */

//: 下面👇是一个常规使用 if 筛选数据的例子
for number in 0...10 {
    if number % 2 == 0 {
        print(number)
    }
}


//: 我们使用 `where` 能够很好的简化前面的示例，并且易于阅读
for number in 0...10 where number % 2 == 0 {
    print(number)
}

//: 我们可以使用 `for case in` 对一组元组进行筛选
let tuples = [(1, "a"), (2, "b"), (3, "c"), (4, "d"), (5, "e"), (6, "f")]
for case let (2, letter) in tuples {
    print("letter: \(letter)")
}

//: 实际上我们对于一个数组的遍历就是使用 `for [case let] in`，只不过这里是打印出所有数组中的元素并为进行筛选，所以忽略了 case let
let numbers = [1, 2, 3, 4, 5, 6]
for case let (index, value) in numbers.enumerated() {
    print("index: \(index), value: \(value)")
}

for (index, value) in numbers.enumerated() {
    print("index: \(index), value: \(value)")
}

//: 我们也可以使用 `for [case let] in` 对包含可选类型元素的数组进行筛选
let optionalArray = [1,2,3,4,nil,5,nil,6,7,8]
for case let .some(value) in optionalArray {
    print("value: \(value)")
}

//: 简化对可选类型塞选的写法
for case let value? in optionalArray {
    print("value: \(value)")
}

//: 使用 `for [case let] in [where]` 对遍历中的数据进一步筛选
for case let value? in optionalArray where value > 5 {
    print("greater five value: \(value)")
}


//: 使用 `if-case-let` 进行数据匹配
enum APIError {
    case RequestOutTime(String)
    case NoNetworkError(Int)
    case UnkonwError
}

var error = APIError.NoNetworkError(400)
if case let .NoNetworkError(code) = error {
    print("error code: \(code)")
}



//: [Next](@next)
