//: [Previous](@previous)

import UIKit

//: # Set
/*:
 
 - 集合的创建及初始化
 - 集合的常用属性
 - 集合的增删改查
 - 集合的相关操作
 - 集合的注意点

 */

//: ## 集合的创建及初始化
var set: Set<Int> = [1, 2, 3, 4]
let array = [6, 7, 8, 9]
var varSet = Set<Int>(array)
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
let initialIndices = Set(0..<5)

//: ## 集合的常用属性
set.isEmpty // 判空
set.count   // 个数
set.contains(3) // 是否包含某个元素
set.max()   // 集合中的最大元素
set.min()   // 集合中的最小元素

//: ## 集合的增删改查
// 遍历
for elem in varSet {
    print(elem)
}

// 新增元素
varSet.insert(5)
varSet.union(set)   // 集合的并集，返回一个新的集合
varSet


// 删除元素
varSet.remove(5)
varSet.removeFirst()
//let index = varSet.firstIndex(of: 1)!
//varSet.remove(at: index)

/*:
 集合中元素操作图如下

![setVennDiagram](setVennDiagram.png)
 */
// 集合的并集
let unionSet = varSet.union(set)
print(unionSet)

// 获得 set varSet 中都有的元素
set = [6, 7]
varSet = [7, 8, 9]
let intersectionSet = varSet.intersection(set)
print(intersectionSet)


// 去除 set、varSet 都包含的元素，剩余元素合并
let symetricDiffSet = varSet.symmetricDifference(set)
print(varSet)
print(set)
print(symetricDiffSet)

// 去除 varSet 里的元素，如果这些元素出现在 set 中
varSet.subtract(set)
print(varSet)



//: 集合的注意点

// Set 是无序的
// Set中的元素是唯一的，会过滤掉相同的元素


//: [Next](@next)
