//: [Previous](@previous)

import UIKit

/*:
 - 定义数组
 - 访问数组
 - 数组的增删改查
 - 数组的常用算法
 - Array 与 NSArray 之间的桥接
 */

//: 定义数组的几种方式
let array: Array<Int> = [1, 2, 3]   // 使用类型标注显示声明array为Int类型数组

var intArray: [Int] = [4, 5, 6]    // [Int]相当于Array<Int>

let doubleArray = [10.5, 2.3, 6.7]  // 类型推断其未Array<Double>

let stringArray = [String](arrayLiteral: "1", "2", "3")     // 另一种初始化数组的方式

print(stringArray)


//: - 访问数组

// 判空
array.isEmpty

// 元素个数
array.count

// 第一个元素
array.first

// 最后一个元素
array.last

// 使用下标访问数组元素
array[1]

// 根据区间运算符来获取数组中的片段
intArray[0...2]
intArray[0..<2]
intArray[2...]

let appendArray = array + intArray  // 数组的加法,返回一个新的数组
intArray.append(contentsOf: array)  // 数组追加元素

array.contains(2)   // 检查是否包含指定元素
let newArray = array.contains { (i) -> Bool in
    return i > 2
}
print(newArray)

// 从指定位置 from 开始计数，统计到 to 位置的距离
let index = intArray.distance(from: 2, to: 4)
intArray[index]

// 重置数组送元素的顺序
print(intArray)
intArray.shuffle()
print(intArray)

//: 数组的增删改查
intArray.removeFirst()  // 删除第一个元素
intArray
intArray.removeLast()   // 删除最后一个元素
intArray
intArray.remove(at: 3)  // 删除第3个元素
intArray
intArray.removeLast(2)  // 删除最后2个元素
intArray
intArray.removeAll()    // 删除所有元素

// 在指定位置插入一个元素
intArray.insert(2, at: 0)

// 在指定位置插入一组元素
intArray.insert(contentsOf: [6, 7, 8], at: 1)

// 使用区间运算符批量修改
intArray[1...2] = [11, 22]
print(intArray)

// 返回删除最后一个元素后的数组片段，源数组不变
let indexSlice = intArray.dropLast()
intArray

print(type(of: intArray))       // Array<Int> 类型
print(type(of: indexSlice))     // ArraySlice<Int> 类型，这里的 indexSlice 只是 intArray 中的一个视图

// 下面 intArray.first 与 indexSlice.first 的地址相同，就可以看出 indexSlice 是 intArray 中的一部分
print(Unmanaged.passUnretained(intArray.first as AnyObject).toOpaque())
print(Unmanaged.passUnretained(indexSlice.first as AnyObject).toOpaque())

let deleteResult = Array(indexSlice)

// 修改数组中指定下标的值
intArray[1] = 9
intArray

// 数组的遍历
for (index, element) in intArray.enumerated() {
    print("index: \(index), element: \(element)")
}

for index in 0..<intArray.count {
    print(index)
}

for element in intArray {
    print(element)
}



//: 数组的常用算法

// 数组的排序
intArray.sort()
intArray.sort {
    $0 > $1
}

intArray[1] = 3
// 返回一个排序后的数组，原数组顺序不变
let newIntArray = intArray.sorted()
print(intArray)
print(newIntArray)


// 使用 `filter` 算法对数组进行过滤
var filterArray = [1,2,3,4,5,6,7,8,9]
let filtered = filterArray.filter{$0 > 5}
print(filtered)


// 使用 `filter` 将产生一个过滤后的新数组，那么有时候我们还需要对数组的每个元素进行一些逻辑处理，然后再得到处理后的新数组，这时候就需要 `map`
var mapArray = [1,2,3,4,5,6]
let m = mapArray.map{$0 * 3}
print(m)
print(mapArray)

// 使用 forEach 算对数组进行遍历，使用forEach 遍历有些限制（无法取得下标、直接拿到元素对象等）。这里迭代数组还是推荐使用 for-in
var forEachArray = [1,2,3,4,5,6,7]
forEachArray.forEach {
    print($0)
}

//: 数组的拷贝
// 当数组中的元素类型为值类型时，例如 Int、String、Struct 等，使用赋值操作符，数组将发生一次拷贝操作，新的修改不会影响旧数组
let oldArray = [1,2,3]
var copyArray = oldArray
copyArray[1] = 4
print(oldArray)
print(copyArray)

// 当数组中的元素是引用类型时，发生的拷贝操作仅仅是数组本身，而其中的引用类型的元素对象将与旧数组中的对象是同一个对象
class CopyArray {
    var count = 10
}

let oldArray1 = [CopyArray(), CopyArray()]
let copyArray2 = oldArray1
copyArray2[0].count = 5
print("old first value: \(oldArray1.first!.count)")
print("copy first value: \(copyArray2.first!.count)")


// 拷贝后的数组共享一份存储对象，当数组发生拷贝后，新旧数组将访问同一份存储对象，直到其中的一个数组的元素发生了改变，才会创建新的存储对象
var copyArray3 = oldArray
let copyArray4 = oldArray

print("copyArray3 内存地址: \(Unmanaged.passUnretained(copyArray3 as AnyObject).toOpaque())")
print("copyArray4 内存地址: \(Unmanaged.passUnretained(copyArray4 as AnyObject).toOpaque())")

copyArray3[0] = 8
print(copyArray3)
print(copyArray4)

print("copyArray3 内存地址: \(Unmanaged.passUnretained(copyArray3 as AnyObject).toOpaque())")
print("copyArray4 内存地址: \(Unmanaged.passUnretained(copyArray4 as AnyObject).toOpaque())")


//: [Next](@next)
