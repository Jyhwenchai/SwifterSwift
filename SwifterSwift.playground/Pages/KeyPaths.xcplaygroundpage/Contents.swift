//: [Previous](@previous)

import UIKit

//: # KeyPath、WritableKeyPath、ReferenceWritableKeyPath

//: ## KeyPath
struct Country: CustomStringConvertible {
    let id: Int
    let name: String
    let describe: String
    
    var description: String {
        return "id: \(id) - name: \(name)"
    }
}

let china = Country(id: 0, name: "中国", describe: "中国有5000年以上的历史")
let america = Country(id: 1, name: "America", describe: "The United States is a very developed country")
let japan = Country(id: 2, name: "Japan", describe: "Japan is a country with many earthquakes")

//: 除了用点语法访问一个变量的属性外，也可以使用 keypath 进行访问变量的属性
let name = japan[keyPath: \.name]

let countrys = [china, japan, america]

//: 如果你需要获取 `countrys` 的所有 `id` 及所有的 `name`，在不知道 `KeyPath` 的情况下，通常会像下面这样使用 `map` 来解决这个问题
let ids = countrys.map { $0.id }
let names = countrys.map { $0.name }

print("ids: \(ids), names: \(names)")

//: 但实际上可以使用 `KeyPath` 使代码看起来更加简单, 这里我们定义了一个 `map` 方法，它接收一个 `KeyPath<Element, T>` 作为参数, 其中 `Element` 表示当前 `Sequence` 所存储的元素，`T` 表示元素 `Element` 的属性, 那么我们就可以通过修改 `map` 参数为 `\.id` 的方式来得到期待的结果
extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }
}

let countryIds = countrys.map(\.id)
let countryNames = countrys.map(\.name)
print("countryIds: \(ids), countryNames: \(names)")

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}

let sortById = countrys.sorted(by: \.id)
let sortByName = countrys.sorted(by: \.name)
print("sortByid: \(sortById)")
print("sortByName: \(sortByName)")

////////////////////////////////////////

struct Song {
    var name: String;
    var artistName: String;
    var albumArtwork: UIImage?
}

struct Playlist{
    var title: String
    var authorName: String
    var artwork: UIImage?
    
    
}

//: 使用常规的方式对 cell 与 model 直接进行关联
struct SongCellConfigurator {
    func configure(_ cell: UITableViewCell, for song: Song) {
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artistName
        cell.imageView?.image = song.albumArtwork
    }
}

//: 使用 KeyPath 进行优化
// 这里创建了 CellConfigurator， 并使用泛型以支持不同的模型
struct CellConfigurator<Model> {
    let titleKeyPath: KeyPath<Model, String>
    let subtitleKeyPath: KeyPath<Model, String>
    let imageKeyPath: KeyPath<Model, UIImage?>
    
    func configure(_ cell: UITableViewCell, for model: Model) {
        cell.textLabel?.text = model[keyPath: titleKeyPath]
        cell.detailTextLabel?.text = model[keyPath: subtitleKeyPath]
        cell.imageView?.image = model[keyPath: imageKeyPath]
    }
}

// 现在我们可以通过 keyPath 语法使其更通用
let songCellConfigurator = CellConfigurator<Song>(
    titleKeyPath: \.name,
    subtitleKeyPath: \.artistName,
    imageKeyPath: \.albumArtwork)

let playlistCellConfigurator = CellConfigurator<Playlist>(
    titleKeyPath: \.title,
    subtitleKeyPath: \.authorName,
    imageKeyPath: \.artwork
)

//: ## `WritableKeyPath`
//: `WritableKeyPath` 继承于 `KeyPath` 类，提供对具有值语义的可变属性的读写访问
struct User {
    var age: Int
    var name: String
}

var user = User(age: 20, name: "hehe")
func changeUserProperty<Value>(keyPath: WritableKeyPath<User, Value>, newValue: Value) {
    user[keyPath: keyPath] = newValue
    print(user[keyPath: keyPath])
}
print(user)
changeUserProperty(keyPath: \.age, newValue: 33)
changeUserProperty(keyPath: \.name, newValue: "haha")

//: ## ReferenceWritableKeyPath
//: `ReferenceWritableKeyPath` 提供对具有引用语义的可变属性的读写访问
class Person: CustomStringConvertible {
    var age: Int
    var name: String
    
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    
    var description: String {
        "Person(age: \(age), name: \(name))"
    }
}

var person = Person(age: 20, name: "hehe")
func changePersonProperty<Value>(keyPath: WritableKeyPath<Person, Value>, newValue: Value) {
    person[keyPath: keyPath] = newValue
    print(person[keyPath: keyPath])
}
print(person)
changePersonProperty(keyPath: \.age, newValue: 33)
changePersonProperty(keyPath: \.name, newValue: "haha")

//: [Next](@next)
