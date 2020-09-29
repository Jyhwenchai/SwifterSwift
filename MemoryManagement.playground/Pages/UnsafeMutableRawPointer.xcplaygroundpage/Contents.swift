//: [Previous](@previous)

import Foundation


MemoryLayout<UInt32>.size
MemoryLayout<UInt16>.stride

let bytesPointer = UnsafeMutableRawPointer.allocate(byteCount: 4, alignment: 4)
// 存储内存的值为 0xFFFF_FFFF，即内存空间所在的32位，每一位都置为1
// ①①①①①①①① ①①①①①①①① ①①①①①①①① ①①①①①①①①
bytesPointer.storeBytes(of: 0xFFFF_FFFF, as: UInt32.self)

// 读取内存中的前8位的值
// ①①①①①①①① => 1111111 => 255
let x = bytesPointer.load(as: UInt8.self)       // 255

// 移动指针到后两个内存空间
// ①①①①①①①① ①①从这里开始往后取16位内存空间
// ①①①①①①①① ①①①①①①①① => 1111111_1111111 => 65535
let offsetPointer = bytesPointer + 2
let y = offsetPointer.load(as: UInt16.self)     // 65535

// 当 bytesPointer 存储的值为 0xFFF0_FFFF 时，下面从右往左计算偏移得到 11110000 => 240
let s = bytesPointer.advanced(by: 2)
let v = s.load(as: UInt8.self)

// 读取数组的值
let numbers = [5, 10, 15, 20]
var numbersPointer = UnsafeMutableRawPointer(mutating: numbers)
let number1 = numbersPointer.load(as: Int.self)
var values = numbersPointer.bindMemory(to: Int.self, capacity: numbers.count)
values.pointee
(values + 1).pointee
//: [Next](@next)
