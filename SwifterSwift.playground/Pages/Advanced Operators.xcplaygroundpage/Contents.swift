//: [Previous](@previous)

import UIKit

/// 操作符重载
struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    
    static func += (left: inout Vector2D, right: Vector2D) -> Vector2D {
        return left + right
    }
    
}

extension Vector2D: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

var vector2D1 = Vector2D(x: 5, y: 7)
let vector2D2 = Vector2D(x: 9, y: 2)

// 加法
let result = vector2D1 + vector2D2

// 前缀 `-` 值取反
let negative = -result

// +=
vector2D1 += vector2D2

let equalValue = vector2D1 == result

/// 自定义操作符
/// 使用 `operator` 关键字在全局级别声明新的运算符，并用 `prefix` 前缀，`infix` 中缀或 `postfix` 后缀修饰符标记：
prefix operator +++
infix operator +-
infix operator -=: AdditionPrecedence // 表示 `-=` 属于优先级组 AdditionPrecedence

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D{
        return vector += vector
    }
    
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}

//: [Next](@next)
