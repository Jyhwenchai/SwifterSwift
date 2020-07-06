//: [Previous](@previous)

import Foundation

//: 通过 `typealias` 我们可以为 struct、class、enum、tuple、closure 等取别名

//: 为一个类型取一个别名
typealias TString = String
let s = TString("Hello, World!")

//: 为元组取别名
typealias Tuple = (Int, String)
let t = Tuple(1000, "error")
print(t.0, t.1)

//: 为一个闭包取一个别名
typealias Closure = ()->()
let c: Closure = {}

//: 在协议中为关联类型取一个别名
protocol Protocol {
    associatedtype A
    typealias T = A
}

//: 在结构体或类中为泛型取别名
struct Animal<A> {
    typealias T = A
}

class Line<L> {
    typealias T = L
}

