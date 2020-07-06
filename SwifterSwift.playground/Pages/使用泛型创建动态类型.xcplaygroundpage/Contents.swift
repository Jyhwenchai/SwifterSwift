//: [Previous](@previous)

import Foundation

protocol ModelProtocol where Self: Codable {
    func success(_ response: (Self) -> Void)
}

struct Man: Codable {
    var name: String
}

struct ModelManager {
    
    func success<Model>(_ type: Model.Type, data: [String: Any], response: (Model) -> Void) where Model: Codable {
        
        do {
            let decoder = JSONDecoder()
            
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            
            let model = try decoder.decode(Model.self, from: jsonData)
            
            response(model)

        } catch {
            print(error.localizedDescription)
        }
        
    }
}

let dict = [
    "name": "jone"
]

let manManager = ModelManager()
manManager.success(Man.self, data: dict) { (man) in
    print(man)
}

/////////////////////////////////////
protocol APIModel {
    init?(data: [String: Any])
}

extension APIModel {
    init?(data: [String: Any]) {
        if let obj: Self = ModelMapper(data).map() {
            self = obj
        }
        return nil
    }
}

struct APIEmptyModel: APIModel {
    init(data: [String : Any]) {}
}

struct ModelMapper<Model: APIModel> {
    var data: [String: Any]
    init(_ data: [String: Any]) {
        self.data = data
    }
    
    func map() -> Model? {
        return Model(data: data)
    }
}

struct User: APIModel {
    var name: String
}

struct Animal: APIModel {
    var name: String
}

let user = User(data: ["name": "john"])
let animal = Animal(data: ["name": "Tiger"])

print(user?.name, animal?.name)
