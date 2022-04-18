//: [Previous](@previous)

import UIKit

//: # 字符串
//: swift 中的字符串是值类型，一个 struct
/*:
- 单行字符串
- 多行字符串
- 原始字符串
- 常见属性与方法
- 字符串截取相关操作
 */

//: ## 字符串定义
//: ### 单行字符串
//: 通常字符串使用双引号进行包裹
var str1 = "string"
let str2 = "string"

//: ### 定义多行字符串
//: 如果需要书写多行字符串可以使用三个引号进行包裹，那么字符串中的换行会被保存
let str3 = """
today is wednesday,
it's woking day.
"""
print(str3)

//: ### 原始字符串
//: 如果需要保存特殊的字符不被转义，这里可以使用 `#""#` 定义原始字符串，元素字符串中的字符将原样输出而不进行解析
let str4 = #"this is raw string, it will keep origin output charactor, example / @ \n \p etc."#
print(str4)

//: 使用 `#""" """#` 使应用多行与原始字符串同时符合
let str5 = #"""
this is a muti-line string,
and it can keep origin output charactor,
example \n  \p \\ etc.
"""#
print(str5)

// ## 字符串的插值
// 单行
let world = "world"
let helloworld = "hello, \(world)"
print(helloworld)

// 多行
let helloworldMultiLine = """
hello
\(world)
"""
print(helloworldMultiLine)

// 使用 `\#()` 对原始字符串中进行插值
let name = "jone"
let str6 = #"hello \#(name)"#

//: ## 常用属性方法等
print("str1: \(str1)")
str1 == str2    // 判断是否相等
str1.isEmpty    // 判断是否为空
str1.count      // 获取长度
str1.uppercased()   // 全大写
str1.lowercased()   // 全小写
str1.capitalized    // 首字母大写


//: ## 字符串截取相关操作
//: 使用 `String.Index` 来获取字符串的相关位置
print("startIndex: \(str1.startIndex)") // 获取str1的起始位置
print("endIndex: \(str1.endIndex)")     // 获取str1的结束位置


//: 字符串截取，拼接
str1.prefix(4)  // 从头开始截取4个字符
str1.suffix(4)  // 从尾开始向前截取4个字符
str1.suffix(from: str1.startIndex)  // 从尾开始到指定位置的字符串

// 字符串拼接，返回一个新字符串
str1 + str2

// 字符串拼接，在原始字符串上追加
str1.append(" other string")

str1 = "hello, world"
// 在指定位置插入字符串
str1.insert(contentsOf: " right", at: str1.endIndex)

// 在字符串最左边插入字符串
let zeroIndex = str1.index(str1.startIndex, offsetBy: 0)
str1.insert(contentsOf:"left ", at: zeroIndex)

// 从指定 `String.Index` 起偏移指定距离的位置
let index: String.Index = str1.index(str1.startIndex, offsetBy: 1)
str1 = "Swifter"

// 取 从 str1.startIndex 开始 偏移4个位置后的字符，当前位置的限制范围小于 str1.endIndex，超过指定返回则不进入 if 语句
if let i = str1.index(str1.startIndex, offsetBy: 4, limitedBy: str1.endIndex) {
    print(str1[i])
}

str1.hasPrefix("Swift")    // 判断是否以某个子串开始
str1.hasSuffix("Swift")    // 判断是否以某个子串结尾

str1.remove(at: str1.startIndex)  // 移除某个字符
let range = str1.index(str1.startIndex, offsetBy: 2)..<str1.endIndex

// 移除给定范围的字符
str1.removeSubrange(range)

//: [Next](@next)
