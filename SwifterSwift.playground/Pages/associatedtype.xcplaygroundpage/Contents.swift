//: [Previous](@previous)

import Foundation

//: 关联类型 `associatedtype` 只能在协议中定义

protocol Testable {
    associatedtype T
    var value: T { get }
    func test(_ input: T) -> T
}

//: 在对应实现的 struct、 class 或者该协议自身的扩展中，我们可以通过 `typealiase` 为关联类型取一个具体的类型为我们所用，可以作为属性、方法参数或方法返回值等
struct IntCalculate: Testable {
    
    typealias T = Int

    var value: Int
    
    func test(_ input: Int) -> Int {
        return input + value
    }
}
struct StringCalculate: Testable {
    typealias T = String
    
    var value: String

    func test(_ input: String) -> String {
        return value + input
    }
    
}

let intCalculate = IntCalculate(value: 5)
intCalculate.test(10)

let stringCalculate = StringCalculate(value: "Hello")
stringCalculate.test(" World!")

//: 使关联类型享有泛型的功能
//: 之前的例子中虽然可以使用关联类型应用于不同类型的计算，但是需要创建两个类，其实我们也可以通过实行泛型让关联类型也具有泛型的优势
struct Calculate<C: Equatable>: Testable {
    
    var value: C
    
    func test(_ input: C) -> C {
        return input == value ? value : input
    }
    
    typealias T = C
    
}

let intCalc = Calculate(value: 10)
let strCalc = Calculate(value: "hello")
intCalc.test(66)
strCalc.test("world")

struct Function<Input, Output> {
    let raw: (Input) -> Output

    init(_ raw: @escaping (Input) -> Output) {
        self.raw = raw
    }

    func callAsFunction(_ input: Input) -> Output {
        raw(input)
    }
}

extension Function {
    func combined(with value: Input) -> Function<Void, Output> {
        Function<Void, Output> { self.raw(value) }
    }

    func chained<T>(to next: @escaping (Output) -> T) -> Function<Input, T> {
        Function<Input, T> { next(self.raw($0)) }
    }
}

extension Function where Input == Void {
    func callAsFunction() -> Output {
        raw(Void())
    }
}
