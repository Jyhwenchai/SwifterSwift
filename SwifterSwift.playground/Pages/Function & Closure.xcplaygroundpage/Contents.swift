//: [Previous](@previous)

import UIKit

/*:
 function的定义
 其中使用 `func` 作为方法的关键字，`funcName` 为函数名，`outParam` 为函数的外部参数，
 `innerParam` 为内部参数，外部参数可省略使用 `_`表示，`->` 后为函数的返回类型，这里是 `String` 类型
 */
func funcName(outParam innerParam: String) -> String {
    return "this is a function"
}

//: 定义无参数，无返回值的函数
func func1() { }
func1()

//: 定义带一个参数为 `String` 类型的参数，这里使用 `_` 省略外部参数
func func2(_ innerparam: String) { }
func2("Hello, World")

//: 定义带多个个参数，返回值为 `String` 类型的函数
func func3(_ param1: String, _ param2: String) -> String { return param1 + "，" + param2 }
func3("Hello", "World")

//: 如果不填写外部参数，则外部参数名与内部参数名相同
func func4(param: String) { print(param) }
func4(param: "Hello，World")

//: 默认如果函数参数是值类型的话，在函数内会发生一次拷贝，在函数内所做修改不会影响原始值,
//:
//: 如果使用 `inout` 关键字则会引用原有数据的地址，此时在函数内所做的修改会影响原始值 （其实也就相当于指针 void func5(int *param); ）
var intValue = 99
func func5(param: inout Int) { param = 10 }
var value = 8
func5(param: &intValue)
//: 函数可以有多个返回值，可以通过元组进行返回
func func6() -> (Int, String) {
    return (200, "success")
}

//: 我们可以定义一个带有可变参数的函数，可变参数表示在函数调用的时候可以传入0至多个相同类型的参数
func func7(paramCount: Int, paramNames: String...) {
    for name in paramNames {
        print("name: \(name)")
    }
}

func7(paramCount: 3, paramNames: "cai", "zhi", "wen")

//: Closer 闭包
/*:
 闭包的定义如下:
 
 以花括号包裹，使用 `in` 关键字，其左侧为参数列表和返回类型的定义，其右侧是将要执行的操作，相当于函数体

 {\
    (参数列表) -> 返回类型 in\
        执行语句\
 }
 */


//: 定义一个没有参数，没有返回值的闭包
let closure = {
    () -> Void in
        print("this is a closer")
}

//: 定义一个参数为 `String` 类型，返回值为 `String` 类型的闭包
let closure2 = {
    (param: String) -> String in
        return "Hello, World"
}

//: 闭包可以作为函数参数, 这里在 `param: ()->()` 定义了无参数无返回值的闭包作为函数参数, 并且返回了一个无参数无返回值 的闭包作为函数的返回值
func closureFunc(param: ()->()) -> ()->() {
    let closure = {
        () -> () in
        print("this is a closer")
    }
    return closure
}

//: 函数中使用闭包，你可以传入一个定义好的闭包，也可以在函数调用时同时定义闭包
closureFunc(param: closure)
closureFunc(param: { ()->() in
    print("Hello, World")
})

//: 尾随闭包
//:
//: 如果闭包作为函数的最后一个参数(这种闭包称为尾随闭包)，则可以省略函数调用的括号，而进行如下简写
closureFunc { ()->() in
    print("Hello, World")
}

//: 如果闭包没有参数则可以如下简写
closureFunc {
    print("Hello, World")
}

//: 如果闭包带有参数, 那么将以元组来接收参数
func closureFunc2(param: (_ param1: String, _ param2: String)->()) {}

closureFunc2 { (param1, param2) in
    print(param1 + "" + param2)
}

//: 如果不使用参数，可以使用下划线忽略参数
closureFunc2 { (_, _) in
    print("忽略了参数")
}

//: 还可以使用 `$0` 表示闭包的第一个参数，`$1` 表示闭包的第二个参数,以此类推
closureFunc2 {
    print($0 + "" + $1)
}

/*:
 非逃逸闭包和逃逸闭包
 
 非逃逸闭包：在函数内立即执行，生命周期限于函数内，函数执行结束，闭包生命周期结束

 逃逸闭包：  不一定会在函数内立即执行，函数执行结束，闭包生命周期还未结束，其生命周期长于函数，逃逸闭包的执行可脱离函数之外
 */

// 下面定义一个存放无参数无返回值的闭包的全局数组, 用以保存逃逸闭包以延长闭包的生命周期
var completionHandlers: [() -> Void] = []

// 定义一个接收逃逸闭包的函数
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)    // 逃逸闭包在函数内不一定立即执行，可以被外部变量‘completionHandlers’所持有，所以闭包可以脱离函数外，从 `completionHandlers` 取出来再执行
}

// 定义另一个接收非闭包的函数
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()   // 由于闭包在这里会立即执行，所以又被称为非逃逸，其生命周期跟随函数调用的结束而结束
}

/*
 定义一个类:
 初始化x值为10
 通过调用上面定义的两个函数,使用尾随闭包的方式将实现对 x 赋值
 */
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }
        someFunctionWithEscapingClosure { self.x = 100 }
    }
}

// 创建类的对象
let instance = SomeClass()


//: 执行doSomething函数，在调用方法的同时立即在方法体里面执行非逃逸闭包，处理完闭包体力的内容该闭包的生命周期也就结束了
instance.doSomething()
print(instance.x)

//: 逃逸闭包并没有立即在方法体中被调用，而是保存在了 completionHandlers 数组中，只有在取重数组中的闭包进行调用才会真正的执行闭包里的内容
completionHandlers.first?()
print(instance.x)


//: 一个使用闭包实现最大值、最小值、加法等操作的例子
struct TestType {
   typealias getNumClosure = ((Int, Int) -> Int)
 
   var numOne = 5
   var numTwo = 8
 
   var results = 0;
 
   mutating func getNum(handler: getNumClosure) -> Int {
         results = handler(numOne,numTwo)
         print("Results: \(results)")
         return results
   }
}

var max: TestType.getNumClosure = {
   if $0 > $1 {
         return $0
   } else {
     return $1
   }
}
 
var min: TestType.getNumClosure = {
   if $0 < $1 {
         return $0
   } else {
         return $1
   }
}
 
var multiply: TestType.getNumClosure = {
    return $0 * $1
}
 
var second: TestType.getNumClosure = {
   return $1
}
 
var answer: TestType.getNumClosure = {
   return $0 + $1
}
var myType = TestType()
myType.getNum(handler: max)
myType.getNum(handler: min)
myType.getNum(handler: multiply)
myType.getNum(handler: second)
myType.getNum(handler: answer)


//: [Next](@next)
