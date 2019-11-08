//: [Previous](@previous)

import UIKit

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

let countrys = [china, japan, america]

//: 如果你需要获取 `countrys` 的所有 `id` 及所有的 `name`，在不知道 `KeyPath` 的情况下，通常会想下面这样使用 `map` 来解决这个问题
let ids = countrys.map {$0.id}
let names = countrys.map {$0.name}

print("ids: \(ids), names: \(names)")

//: 我们可以使用 `KeyPath` 使代码看起来更加舒服, 这里我们定义了一个 `map` 方法，它接收一个 `KeyPath<Element, T>` 作为参数, 其中 `Element` 表示当前 `Sequence` 所存储的元素，`T` 表示元素 `Element` 的属性, 那么我们就可以通过修改 `map` 参数为 `\.id` 的方式来得到期待的结果
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

// 使用常规的方式对 cell 与 model 直接进行关联
struct SongCellConfigurator {
    func configure(_ cell: UITableViewCell, for song: Song) {
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artistName
        cell.imageView?.image = song.albumArtwork
    }
}

// 使用 KeyPath 进行优化
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

//: `ReferenceWritableKeyPath` 可以定义一个既可读又可写的 `KeyPath`
struct Item { var index: Int}

class ListController {
    private var items = [Item]() { didSet { render() } }
    
    func loadItems() {
        load { (items) in
            
        }
    }
    
    func render() {
        print("rendering")
    }
    
    func load(_ complete: ([Item]) -> ()) {
        complete([Item(index: 0), Item(index: 1)])
    }
    
}

func setter<Object: AnyObject, Value>(
    for object: Object,
    keyPath: ReferenceWritableKeyPath<Object, Value>
    ) -> (Value) -> Void {
    return { [weak object] value in
        object?[keyPath: keyPath] = value   // 实现写的操作
    }
}

extension ListController {
    func reLoadItems() {
        reLoad(then: setter(for: self, keyPath: \.items))
    }
    
    func reLoad(then: ([Item]) -> Void) {
        let data = [Item(index: 0), Item(index: 1)]
        then(data)
    }
    
//    func reLoad(then: (Any) -> Void) {
//        let data = [Item(index: 0), Item(index: 1)]
//        then(data)
//    }
}

//: [Next](@next)
