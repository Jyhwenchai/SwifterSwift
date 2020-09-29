//: [Previous](@previous)

import Foundation

// size: 内存占用空间以字节为单位
// alignment: 默认内存对齐方式，以字节为单位。
// stride: 存储在连续内存或Array <T>中时，从T的一个实例的开始到下一个实例的开始的字节数。
MemoryLayout<Int>.size // return 8 (on 64-bit)
MemoryLayout<Int>.alignment // return 8 (on 64-bit)
MemoryLayout<Int>.stride // return 8 (on 64-bit)

MemoryLayout<Int16>.size // return 2
MemoryLayout<Int16>.alignment // return 2
MemoryLayout<Int16>.stride // return 2

MemoryLayout<Bool>.size // return 1
MemoryLayout<Bool>.alignment // return 1
MemoryLayout<Bool>.stride // return 1

MemoryLayout<Float>.size // return 4
MemoryLayout<Float>.alignment // return 4
MemoryLayout<Float>.stride // return 4

MemoryLayout<Double>.size // return 8
MemoryLayout<Double>.alignment // return 8
MemoryLayout<Double>.stride // return 8

// Point 最大内存空间为 Double 需8字节，总共占用17字节，alignment 取最大值即8字节，stride 应该是最大占用数的整数倍，所以是 8 * 3 = 24 个字节的空间
//                 x                 y       isFilled
//  Point => █ █ █ █ █ █ █ █ ↔ █ █ █ █ █ █ █ █ ↔ █ 🀆 🀆 🀆 🀆 🀆 🀆 🀆
struct Point {
    let x: Double
    let y: Double
    let isFilled: Bool
}

MemoryLayout<Point>.size    // 17
MemoryLayout<Point>.alignment   // 8
MemoryLayout<Point>.stride  // 24
//: [Next](@next)
