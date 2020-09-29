//: [Previous](@previous)

import Foundation

var bytes: [UInt8] = [39, 77, 111, 111, 102, 33, 39, 0]
// 初始化内存空间
let uint8Pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: 8)
// 为初始化的内存分配值
uint8Pointer.initialize(from: &bytes, count: 8)

// 当您只需要临时访问其他类型的指针的内存时：
let length = uint8Pointer.withMemoryRebound(to: Int8.self, capacity: 8) {
    return strlen($0)
}

// 当需要永久性将内存重新绑定为其他类型时:
let uint64Pointer = UnsafeMutableRawPointer(uint8Pointer).bindMemory(to: UInt64.self, capacity: 1)
var fullInteger = uint64Pointer.pointee
var firstByte = uint8Pointer.pointee

let rawPointer = UnsafeMutableRawPointer(uint64Pointer)
fullInteger = rawPointer.load(as: UInt64.self)   // OK
firstByte = rawPointer.load(as: UInt8.self)      // OK

// 读取内存存储的值
var numbers = [10, 20, 30, 40]
var numberPointer = UnsafeMutablePointer<Int>.allocate(capacity: numbers.count)
numberPointer.initialize(from: &numbers, count: numbers.count)

numberPointer.pointee
numberPointer[1]
numberPointer[2]

(numberPointer + 1).pointee

//: [Next](@next)
