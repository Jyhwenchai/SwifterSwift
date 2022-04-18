//: [Previous](@previous)

import Foundation

/*:
 - map
 - flatMap (4.1之后使用对 `Optional` 类型的处理使用 compactMap 代替)
 - compactMap
 - filter
 - reduce
 - contain
 - sorted
 - partition
 */

//: `map` 可以对集合类型进行一次映射处理，得到映射后的新数组
let strings = ["oc", "swift", "python"]
var mapStrings = strings.map { (string) -> String in
    return string.capitalized
}
print(mapStrings)

//: 如果对闭包足够熟悉，我们还可以使用更简单的写法
mapStrings = strings.map { string -> String in
    string.capitalized
}
print(mapStrings)

//: 忽略闭包参数及返回值，使用 `$0`、`$1` 来替代参数
mapStrings = strings.map { $0.capitalized }
print(mapStrings)

print(" \n=============================================\n")

//: `flatMap` 将对集合类型进行展开
print(strings.flatMap { $0.uppercased()} )
print("STRING".flatMap { $0.lowercased()} )
let nestingArray: [[String]] = [["A", "B", "C"], ["D", "E", "F"], ["G", "H", "I"]]
let flatValue = nestingArray.flatMap {
    $0.map { $0 }
}
print(flatValue)


print(" \n=============================================\n")

//: `compactMap` 将忽略集合中的值为 `nil` 的对象
let optionalStrings = ["OC", "Swift", nil, "Python", nil]

//: 注意使用 `map` 处理可选类型的集合需指明闭包参数及返回类型, 但通常我们不推荐使用它，而是应该使用 `compactMap`
let mapOptionalStrings = optionalStrings.map { (string) -> String? in
    if let string = string {
        return string.lowercased()
    } else {
        return string
    }
}
print(mapOptionalStrings)

//: 使用 `compactMap` 处理
let compactMapStrings = optionalStrings.compactMap { $0?.lowercased() }
print(compactMapStrings)

print(" \n=============================================\n")

//: `filter` 可以对集合类型进行筛选
let filterStrings = strings.filter {$0.first == "s"}
print(filterStrings)


print(" \n=============================================\n")

//: `reduce` 可以对集合类型进行计算, `reduce` 的定义中 `initialResult` 是初始值，闭包有两个参数用于计算，其中 `result` 是上一次计算的结果，第二个参数 `value` 是集合中的值，返回值将用来参与下一次计算
//:
//: `func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Int) throws -> Result) throws -> Result`
let numArr = [1,2,3,4,5]
let initValue = 0
let sum = numArr.reduce(initValue) { (result, value) -> Int in
    print("result: \(result), current calcute value: \(value)")
    return result + value
}
print(sum)


print(" \n=============================================\n")

//: `contain` 可以判断集合类型是否包含给定条件的对象
let list = ["pink", "orange", "purple", "red"]
let contain = list.contains { $0.contains("p") }
print("list \(contain ? "contain" : "not contain") specified value")


print(" \n=============================================\n")

//: `sort` 可以对集合类型进行排序
let sortNums = [3, 15, 66, 32, 11, 88]
// 默认是升序
print(sortNums.sorted())
// 降序
print(sortNums.sorted(by: >))

//: 自定义排序规则
let sortStrings = ["Swift", "Objective-C", "Python", "C", "C++", "PHP"]
let sortResult = sortStrings.sorted {
    if $0.first == $1.first {
        return $0.count > $1.count ? $0 > $1 : $0 < $1
    } else {
        return $0 > $1
    }
}
print(sortResult)



print(" \n=============================================\n")

//: `partition` 将通过给定谓词条件将集合以索引 index 分割为两部分，匹配满足条件部分将置于不匹配部分之后
var numbers = [22, 11, 6, 55, 6, 8, 16, 10, 3]
let index = numbers.partition {$0 > 11}
print(numbers)
print(numbers[..<index])
print(numbers[index...])

var nums = [12, 33, 11, 55, 0, 5, 0, 21, 0]
nums.partition { $0 == 0 }
print(nums)


//: [Next](@next)
