//: [Previous](@previous)

import Foundation

func print<T>(address p: UnsafeRawPointer, as type: T.Type) {
    let value = p.load(as: type)
    print(value)
}

var value: Int = 23
print(address: &value, as: Int.self)

let numbers = [5, 10, 15, 20]
print(address: numbers, as: Int.self)

let intPointer = UnsafeRawPointer(&value)
let intValue = intPointer.load(as: Int.self)

let numbersPointer = UnsafeRawPointer(numbers)
let numbersValue = numbersPointer.load(as: Int.self)

//: [Next](@next)
