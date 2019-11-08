//: [Previous](@previous)

//: 面向对象的实现
//class Animal {
//
//    fileprivate var landAnimal = false
//    fileprivate var landAttack = false
//    fileprivate var landMovement = false
//
//    fileprivate var seaAnimal = false
//    fileprivate var seaAttack = false
//    fileprivate var seaMovement = false
//
//    fileprivate var airAnimal = false
//    fileprivate var airAttack = false
//    fileprivate var airMovement = false
//
//    fileprivate var hitPoints = 0
//
//    init() {
//        landAnimal = false
//        landAttack = false
//        landMovement = false
//        seaAnimal = false
//        seaAttack = false
//        seaMovement = false
//        airAnimal = false
//        airAttack = false
//        airMovement = false
//        hitPoints = 0
//    }
//
//    func isLandAnimal() -> Bool {
//        return landAnimal
//    }
//    func canLandAttack() -> Bool {
//        return landAttack
//    }
//    func canLandMove() -> Bool {
//        return landMovement
//    }
//    func isSeaAnimal() -> Bool {
//        return seaAnimal
//    }
//    func canSeaAttack() -> Bool {
//        return seaAttack
//    }
//    func canSeaMove() -> Bool {
//        return seaMovement
//    }
//    func isAirAnimal() -> Bool {
//        return airAnimal
//    }
//    func canAirAttack() -> Bool {
//        return airAttack
//    }
//    func canAirMove() -> Bool {
//        return airMovement
//    }
//
//    func doLandAttack() {}
//    func doLandMovement() {}
//    func doSeaAttack() {}
//    func doSeaMovement() {}
//    func doAirAttack() {}
//    func doAirMovement() {}
//
//    func takeHit(amount: Int) {
//        hitPoints -= amount
//    }
//
//    func hitPointsRemaining() -> Int {
//        return hitPoints
//    }
//
//    func isAlive() -> Bool {
//        return hitPoints > 0 ? true : false
//    }
//}
//
//
//class Lion: Animal {
//    override init() {
//        super.init()
//        landAnimal = true
//        landAttack = true
//        landMovement = true
//        hitPoints = 20
//    }
//    override func doLandAttack() {
//        print("Lion Attack")
//    }
//    override func doLandMovement() {
//        print("Lion Move")
//    }
//}
//
//class Alligator: Animal {
//    override init() {
//        super.init()
//        landAnimal = true
//        landAttack = true
//        landMovement = true
//        seaAnimal = true
//        seaAttack = true
//        seaMovement = true
//        hitPoints = 35
//    }
//    override func doLandAttack() {
//        print("Alligator Land Attack")
//    }
//    override func doLandMovement() {
//        print("Alligator Land Move")
//    }
//    override func doSeaAttack() {
//        print("Alligator Sea Attack")
//    }
//    override func doSeaMovement() {
//        print("Alligator Sea Move")
//    }
//
//}
//
//var animals = [Animal]()
//animals.append(Alligator())
//animals.append(Alligator())
//animals.append(Lion())
//
//for (index, animal) in animals.enumerated() {
//    if animal.isAirAnimal() {
//        print("Animal at \(index) is Air")
//    }
//    if animal.isLandAnimal() {
//        print("Animal at \(index) is Land")
//    }
//    if animal.isSeaAnimal() {
//        print("Animal at \(index) is Sea")
//    }
//}

//: 面向协议的实现

protocol Name {
    var firstName: String { get set }
    var lastName: String { get set }
}

protocol Age {
    var age: Double { get set }
}

protocol Fur {
    var furColor: String { get set }
}

protocol Hair {
    var hairColor: String { get set }
}

protocol Person: Name, Age, Hair {
    var height: Double { get set }
}

protocol Dog: Name, Age, Fur {
    var breed: String { get set }
}


protocol Occupation {
    var occupationName: String { get set }
    var yearlySalary:Double { get set }
    var experienceYears: Double { get set }
}

struct Programmer: Person, Occupation {
    var firstName: String
    var lastName: String
    var age: Double
    var hairColor: String
    var height: Double
    var occupationName: String
    var yearlySalary: Double
    var experienceYears: Double
}


/// 使用面向协议编程重写之前动物游戏的例子
protocol Animal {
    var hitPoints: Int { get set }
}

extension Animal {
    mutating func takeHit(amount: Int) {
        hitPoints -= amount
    }
    func hitPointsRemaining() -> Int {
        return hitPoints
    }
    func isAlive() -> Bool {
        return hitPoints > 0 ? true : false
    }
}

protocol LandAnimal: Animal {
    var landAttack: Bool { get }
    var landMovement: Bool { get }
    
    func doLandAttack()
    func doLandMovement()
}

protocol SeaAnimal: Animal {
    var seaAttack: Bool { get }
    var seaMovement: Bool { get }
    
    func doSeaAttack()
    func doSeaMovement()
}

protocol AirAnimal: Animal {
    var airAttack: Bool { get }
    var airMovement: Bool { get }
    
    func doAirAttack()
    func doAirMovement()
}

struct Lion: LandAnimal {
    var hitPoints = 20
    let landAttack = true
    let landMovement = true
    
    func doLandAttack() {
        print("Lion Attack")
    }
    func doLandMovement() {
        print("Lion Move")
    }
}

struct Alligator: LandAnimal, SeaAnimal {
    var hitPoints = 35
    let landAttack = true
    let landMovement = true
    let seaAttack = true
    let seaMovement = true
    
    func doLandAttack() {
        print("Alligator Land Attack")
    }
    func doLandMovement() {
        print("Alligator Land Move")
    }
    func doSeaAttack() {
        print("Alligator Sea Attack")
    }
    func doSeaMovement() {
        print("Alligator Sea Move")
    }
}

var animals = [Animal]()

animals.append(Alligator())
animals.append(Alligator())
animals.append(Lion())

for (index, animal) in animals.enumerated() {
    if let _ = animal as? AirAnimal {
        print("Animal at \(index) is Air")
    }
    if let _ = animal as? LandAnimal {
        print("Animal at \(index) is Land")
    }
    if let _ = animal as? SeaAnimal {
        print("Animal at \(index) is Sea")
    }
}


/// 使用 `where` 限定遵对象是否遵循某个的协议
for (index, animal) in animals.enumerated() where animal is SeaAnimal {
    print("Only Sea Animal: \(index)")
}

/// 也可以是 `&` 组合多个协议进行限定
for (index, animal) in animals.enumerated() where animal is LandAnimal & SeaAnimal {
    print("Land and Sea Animal: \(index)")
}


//: [Next](@next)
