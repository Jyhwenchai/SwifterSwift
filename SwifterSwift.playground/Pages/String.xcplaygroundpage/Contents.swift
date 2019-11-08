//: [Previous](@previous)

import UIKit

//: 定义单行字符串
var str1 = "string"
let str2 = "string"

//: 定义多行字符串
let str3 = """
today is wednesday,
it's woking day.
"""
print(str3)

//: 使用 `#""#`保持原始字符串
let str4 = #"this is raw string, it will keep origin output charactor, example / @ \n \p etc."#
print(str4)

//: 使用 `#""" """#` 使应用多行与原始字符串同时符合
let str5 = #"""
this is a muti-line string,
and it can keep origin output charactor,
example \n  \p \\ etc.
"""#
print(str5)

//： 如果需要在原始字符串中插入变量那么需要使用 `\#()` 来进行包裹
let name = "jone"
let str6 = #"hello \#(name)"#


//: 常用属性方法等
str1 == str2    // 判断是否相等
str1.isEmpty    // 判断是否为空
str1.count      // 获取长度
str1.uppercased()   // 全大写
str1.lowercased()   // 全小写
str1.capitalized    // 首字母大写


//: 使用 `String.Index` 来获取字符串的相关位置
print("startIndex: \(str1.startIndex)") // 获取str1的起始位置
print("endIndex: \(str1.endIndex)")     // 获取str1的结束位置


//: 字符串截取，拼接
str1.prefix(4)  // 从头开始截取
str1.suffix(4)  // 从尾开始截取
str1.suffix(from: str1.startIndex)  // 从指定位置到结尾的字符串

// 字符串拼接，返回一个新字符串
str1 + str2

// 字符串拼接，在原始字符串上追加
str1.append(" other string")

// 在指定位置插入字符串
str1.insert(contentsOf: " insert string", at: str1.endIndex)

// 在指定位置后插入新字符串 参数必须小于str1.endIndex（即在str1的起始位置之后插入新字符串）
str1.insert(contentsOf: " new string ", at: str1.index(after: str1.startIndex))

// 在str2.endIndex之前的位置插入新字符串（也就是长度为str2.length - 1的位置插入新字符串）
str1.insert(contentsOf: " hello string!", at: str2.index(before: str2.endIndex))

// 在字符串最左边插入字符串
let zeroIndex = str1.index(str1.startIndex, offsetBy: 0)
str1.insert(contentsOf:"add left ", at: zeroIndex)

// 从指定 `String.Index` 起偏移指定距离的位置
let index: String.Index = str1.index(str1.startIndex, offsetBy: 1)
var s = "Swifter"
if let i = s.index(s.startIndex, offsetBy: 4, limitedBy: s.endIndex) {
    print(s[i]) // 取 从s.startIndex开始 偏移4个位置后的字符，当前位置的限制范围小于s.endIndex
}

s.hasPrefix("Swift")    // 判断是否以某个子串开始
s.hasSuffix("Swift")    // 判断是否以某个子串结尾

s.remove(at: s.startIndex)  // 移除某个字符
let range = s.index(s.startIndex, offsetBy: 2)..<s.endIndex
s.removeSubrange(range)     // 移除给定范围的字符

//: [Next](@next)
