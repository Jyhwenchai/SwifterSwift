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
//10 % 2.6

//: 复合赋值运算符 ( +=  -=  *=  /=)
var x = 10
x += 6
x -= 6
x *= 6
x /= 6


//: 闭区间运算符   ( ... )
for i in 1...5 {
    print(i)
}

//: 半开区间运算符  ( a..<b )
for i in 1..<5 {
    print(i)
}


//: 三元条件运算符  (boolValue ? v1 : v2)
let value1 = 1
let value2 = 2
let result = value1 > value2 ? value1 : value2



//: 逻辑运算符 （与、或、非）
let not = !true

let and = 1 & 2

let or = 1 | 2

//: ?? 合并运算符，用于对可选类型的值为 `nil` 时提供一个默认值
var optionalValue: String? = nil
optionalValue = optionalValue ?? "default value"
print(optionalValue)

//: [Next](@next)
