//: [Previous](@previous)

import UIKit

/*:
 Enum(枚举)
 */

//: 定义枚举，使用 `case` 来列举枚举值
enum CompassPoint {
    case north
    case south
    case east
    case west
}

//: 可以指定枚举类型
enum Direction: Int {
    case left, right, top, bottom = 10  // 给定一个值
}

//: 枚举的访问
CompassPoint.east
let direction = Direction.bottom
direction.rawValue
direction.hashValue
let customDirection = Direction(rawValue: 2)    // 通过原始值初始化一个枚举

/*:
 使用switch来匹配枚举值
 - swift中的switch默认是不会贯穿的,所以不用谢break，
 - 如果覆盖到了每一个case则不用谢default
 */
switch direction {
case .left:
    print("left")
case .right:
    print("right")
case .top:
    print("top")
case .bottom:
    print("bottom")
}

//: swift中枚举可使用元组来设置多种类型的枚举
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 87775, 51234, 3)
productBarcode = .qrCode("ABCDEF")

//: 在使用switch中可以使用 `case let` 来匹配对应的枚举类型, 见 [Pattern Matching](Pattern_Matching)
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check) where check > 1:  // 可以进行条件筛选
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
case let .upc(_, _, _, check):  // 省略部分不使用的值
    print(check)
}


//: Recursive Enumerations 递归枚举
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)  // 加法
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)    // 乘法
}

//: 如果所有的枚举值都是可递归的，则可以如下写法
indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))


//: [Next](@next)
