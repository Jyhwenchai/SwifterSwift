//: [Previous](@previous)

import Foundation

// 初始化一个变量
var int8: Int8 = 44

// 指针 ptr 指向变量 int8，之后可以访问变量所在的内存
let int8Ptr: UnsafePointer<Int8> = UnsafePointer(&int8)

// 动过 `pointee` 读取 ptr 指向的内存中的值
print(int8Ptr.pointee)

var uInt8: UInt8 = 64
let uInt8Ptr = UnsafePointer(&uInt8)

// 当您只需要临时访问其他类型的指针的内存时，请使用 `withMemoryRebound（to：capacity :)` 方法。例如，您可以使用此方法来调用一个API，该API需要一个指向与指针的 Pointee 布局兼容的其他类型的指针。以下代码临时将 uInt8Ptr 引用的内存从 UInt8 重新绑定到 Int8
let length = uInt8Ptr.withMemoryRebound(to: Int8.self, capacity: 8) { obj -> Int in
    print(type(of: obj.pointee.self))
    return strlen(obj)
}

print(length)

// 当需要永久性将内存重新绑定为其他类型时，请首先获取指向该内存的原始指针，然后在该原始指针上调用 `bindMemory（to：capacity :)` 方法。以下示例将 uInt8Ptr 引用的内存绑定到 UInt64 类型的一个实例：

let uint64Ptr = UnsafeRawPointer(uInt8Ptr).bindMemory(to: UInt64.self, capacity: 1)

// 将 uInt8Ptr 引用的内存重新绑定到UInt64之后，未定义作为UInt8实例访问该指针的引用内存
var fullInteger = uint64Ptr.pointee
var firstByte = uInt8Ptr.pointee

let rawPointer = UnsafeRawPointer(uint64Ptr)
fullInteger = rawPointer.load(as: UInt64.self)
firstByte = rawPointer.load(as: UInt8.self)

// 执行类型指针算法
var ints = [10, 20, 30, 40]
let intPointer: UnsafePointer<Int> = UnsafePointer(ints)
let x = intPointer.pointee
print(x)

let offsetPointer = intPointer + 2 // 或者使用角标 intPointer[2]
let y = offsetPointer.pointee
print(y)

// 相比于 let intPointer: UnsafePointer<Int> = UnsafePointer(ints) 更安全的写法
ints.withUnsafeBufferPointer { intPointer in
    let x = intPointer.last
    print(x!)
}

/// 隐式转换或桥接
func printInt(atAddress p: UnsafePointer<Int>) {
    print(p.pointee)
}

// 隐式转换
printInt(atAddress: intPointer)

let mutableIntPointer = UnsafeMutablePointer(mutating: intPointer)
printInt(atAddress: mutableIntPointer)

// 使用 Swift 的隐式桥接
var value: Int = 23

printInt(atAddress: &value)

let numbers = [5, 10, 15, 20]
printInt(atAddress: numbers)

//: [Next](@next)
