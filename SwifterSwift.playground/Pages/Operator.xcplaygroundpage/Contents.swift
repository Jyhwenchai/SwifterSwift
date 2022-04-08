//: [Previous](@previous)

import UIKit

/*:
 操作符
 
 - 赋值运算符 (=)
 - 比较运算符 (>  =  <  <=  ==、 !=)
 - 算数运算符 ( +  -  *  /)
 - 取余运算符 ( % )
 - 复合赋值运算符 ( +=  -=  *=  /=)
 - 闭区间运算符   ( a...b )
 - 半开区间运算符  ( a..<b )
 - 三元条件运算符  (boolValue ? v1 : v2)
 - 逻辑运算符 （与、或、非）
 - ?? 合并运算符
 */

//: 赋值运算符
let a = 0
var b = a
var (c, d) = (1, 2)
print(c, d)
(c, d) = (d, c) // 可以通过这个操作对 c、d 的值进行交换
print(c, d)

//: 比较运算符 (>  =  <  <=  ==、 !=)
let comparisonValue1 = 1
let comparisonvalue2 = 2

comparisonValue1 > comparisonvalue2
comparisonValue1 >= comparisonvalue2
comparisonValue1 < comparisonvalue2
comparisonValue1 <= comparisonvalue2
comparisonValue1 == comparisonvalue2
comparisonValue1 != comparisonvalue2


//: 算数运算符 ( +  -  *  /)
let arithmeticValue1 = 1
let arithmeticValue2 = 2

arithmeticValue1 + arithmeticValue2
arithmeticValue1 - arithmeticValue2
arithmeticValue1 * arithmeticValue2
arithmeticValue1 / arithmeticValue2


//: 取余运算符 ( % )
10 % 3
//10 % 2.6  // 不能对小数求余

//: 复合赋值运算符 ( +=  -=  *=  /=)
var x = 10
x += 6
x -= 6
x *= 6
x /= 6


//: 闭区间运算符，在 swift 中的定义为 `struct ClosedRange<Bound> where Bound: Comparable`，语法糖为`...`
for i in 1...5 {
    print(i)
}

//: 半开区间运算符，在 swift 中的定义为 `struct Range<Bound> where Bound: Comparable`，语法糖为`..<`
for i in 1..<5 {
    print(i)
}


//: 三元条件运算符  (boolValue ? v1 : v2)
let value1 = 1
let value2 = 2
let result = value1 > value2 ? value1 : value2



//: 逻辑运算符 （与、或、非）
let and = 1 < 2 && 2 < 3

let or = 1 < 2 || 2 < 3

let not = !true

//: ?? 合并运算符，用于对可选类型的值为 `nil` 时提供一个默认值
var optionalValue: String? = nil
let resultValue: String = optionalValue ?? "default value"

//: [Next](@next)
