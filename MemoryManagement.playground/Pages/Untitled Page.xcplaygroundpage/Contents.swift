//: [Previous](@previous)

import Foundation

/**
        Swift                       C
 
    对于返回类型，变量和参数，适用以下映射：
    UnsafePointer<Type>                     -> const Type *
    UnsafeMutablePointer<Type>              -> Type *
    
    对于类类型，以下映射适用：
    UnsafePointer<Type>                     -> Type * const *
    UnsafeMutablePointer<Type>              -> Type * __strong *
    AutoreleasingUnsafeMutablePointer<Type> -> Type **
 
    对于指向未类型化的原始内存的指针，适用以下映射：
    UnsafeRawPointer                        -> const void *
    UnsafeMutableRawPointer                 -> void *
 */


//: [Next](@next)
