//: [Previous](@previous)

/*:
 # Subscripts can now declare default arguments（下标现在支持添加默认参数）
 */

struct User {
    var houses: [String]
    
    subscript(index: Int, default house: String = "normal housing") -> String {
        if index >= 0 && index < houses.count {
            return houses[index]
        } else {
            return house
        }
    }
    
}

let user = User(houses: ["High-end residential", "old house", "Garden House"])
print(user[0])
print(user[-1])
print(user[-1, default: "Sky Villa"])

//: [Next](@next)
