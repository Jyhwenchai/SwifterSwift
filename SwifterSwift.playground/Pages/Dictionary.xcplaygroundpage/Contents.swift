//: [Previous](@previous)

import UIKit

//: # 字典

/*:

 - 创建及初始化字典
 - 字典的常见操作
 - 字典的增删改查
 - 一些注意点
 */

//: ## 创建及初始化字典
let dict: Dictionary<String, Int> = ["1": 1, "2": 2, "3": 3]

var varDict: [String: Int] = ["3": 3, "4": 4, "5": 5]

let letDict = ["7": 7, "8": 8, "9": 9]  // 类型推断

let emptyDict: [String: Int] = [:]     // 空字典

//: ## 字典的常见操作

// 判空
dict.isEmpty

// 元素个数
dict.count

// 空间大小
dict.capacity

// 反转操作
varDict.reversed()

//: ## 字典的增删改查

// 获取所有key
let keys = [String](dict.keys)

// 获取所有元素的值
let values = [Int](dict.values)

// 使用元组接收字典的 `keys` 和 `values`
let (dictKeys, dictValues) = (dict.keys, dict.values)

print("keys: \(dictKeys), values:\(dictValues)")

// 遍历
for key in dict.keys { // 获取所有的key
    print(key)
}

for value in dict.values { // 获取所有的value
    print(value)
}

for (key, value) in dict.enumerated() {
    print("key: \(key), value:\(value)")
}

// 添加操作
varDict["10"] = 10

// 修改操作
varDict["10"] = 11
varDict.updateValue(10, forKey: "10")

// 获取第一个元素的索引
let startIndex = varDict.startIndex
// 得到一个元组类型的键值对
let (key, value) = varDict[startIndex]

// 获取最后一个元素的索引
let endIndex = varDict.endIndex

// 获取 `key` 为10的元素索引
varDict.index(forKey: "10")

// 获取指定索引元素的后一个索引
let indexTwo = varDict.index(after: startIndex)
varDict[indexTwo]

// 获取指定索引起进行偏移后得到的索引(比如： 第一个元素的位置再偏移2个距离得到的索引)
print(varDict)
print()
let offsetIndex = varDict.index(startIndex, offsetBy: 2)
print(varDict[offsetIndex])
print()

// 通过筛选得到满足条件的第一个元素
let elem = varDict.firstIndex { (key, value) -> Bool in
    return value >= 4
}
varDict[elem!]

// 删除指定索引的元素
varDict.remove(at: startIndex)

// 删除指定key的元素
varDict.removeValue(forKey: "10")

// 删除所有元素
varDict = [:]
varDict.removeAll()


//: [Next](@next)
