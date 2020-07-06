//: [Previous](@previous)

/*:
 # Lazy filtering order is now reversed (懒惰的过滤顺序现在颠倒了)
 
 Swift5.2中有一个小的更改，可能会导致功能中断：如果您使用诸如数组之类的惰性序列，并对其应用过滤器，则这些过滤器现在将以相反的顺序运行。

 例如，下面的代码具有一个过滤器，该过滤器选择以 S 开头的名称，然后另一个过滤器打印出名称，然后返回：
 */
let users = ["ABCD", "BCDE", "BACD", "CDAB"].lazy
let u = users
    .filter { $0.hasPrefix("B") }
    .filter { print($0); return true}

print(u.count)
print(u.elements)
