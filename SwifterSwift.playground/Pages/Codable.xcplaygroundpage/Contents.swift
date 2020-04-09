//: [Previous](@previous)

import Foundation

//: 参考：[Codable](https://learnappmaking.com/codable-json-swift-how-to/)


//: `swift` 中 `Codable` 默认实现了 `encode` 与 `decode` 的操作，让 `json` 的转换操作变的更加简单易用
//:
//: 在默认的情况下如果 `json` 中的字段名称与定义的 `Model` 模型中的属性命名相同，那么在 `decode` 的过程中 `swift` 会自动映射到对应的字段，你不需要编写任何额外的代码就可以使用 `JSONDecoder` 进行解析
let example01 = {
    
    print("=== example 01 === ")
    
    let jsonString = """
        {
            "first_name": "Arthur",
            "last_name": "Dent"
        }
    """
    
    struct User: Codable {
        var first_name: String
        var last_name: String
    }
    
    if let jsonData = jsonString.data(using: .utf8) {
        
        let decoder = JSONDecoder()

        do {
            // 将 json 转换成 model
            let user = try decoder.decode(User.self, from: jsonData)
            print(user.first_name)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

example01()

//: 如果你 `Model` 模型中的字段名称与 `json` 所定义的不匹配，可以通过自定义 `CodingKey` 的方式来建立 `json` 与 `Model` 模型间的映射
let example02 = {
    print("\n=== example 02 === ")
    let jsonString = """
        {
            "first_name": "Arthur",
            "last_name": "Dent"
        }
    """
    
    struct User: Codable {
        var firstName: String
        var lastName: String
        
        // 自定义 CodingKey
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
        }
      
        // 通过该方法将 `jsonString` 解析出的内容与 `User` 中的字段进行一一对应
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            firstName = try container.decode(String.self, forKey: .firstName)
            lastName = try container.decode(String.self, forKey: .firstName)
        }
    }
    
    if let jsonData = jsonString.data(using: .utf8) {
        
        let decoder = JSONDecoder()

        do {
            // 将 json 转换成 model
            let user = try decoder.decode(User.self, from: jsonData)
            print(user.firstName)
        } catch {
            print(error.localizedDescription)
        }
    }
}

//: 在现实项目中我们的 `json` 一定不会那么简单，它可能包含更多的嵌套，包含数组等类型，下面的示例展示了如果对 `json` 数组进行转换的过程
example02()

let example03 = {
    
    print("\n=== example 03 === ")
    
    let jsonString = """
    {
        "users":
        [
            {
                "first_name": "Arthur",
                "last_name": "Dent"
            }, {
                "first_name": "Zaphod",
                "last_name": "Beeblebrox"
            }, {
                "first_name": "Marvin",
                "last_name": "The Paranoid Android"
            }
        ]
    }
    """

    struct User:Codable
    {
        var firstName:String
        var lastName:String

        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
        }
        
        // json 与 model 字段名称不一致时的映射处理
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            firstName = try container.decode(String.self, forKey: .firstName)
            lastName = try container.decode(String.self, forKey: .firstName)
        }
        
    }

    struct Response: Codable {
        
        var users: [User]
        
        enum CodingKeys: String, CodingKey {
            case users
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            var labelContainer = try container.nestedUnkeyedContainer(forKey: .users)
            var users: [User] = []
            // 处理数组的转换
            while !labelContainer.isAtEnd {
                let user = try labelContainer.decode(User.self)
                users.append(user)
            }
            self.users = users
        }
        
        
    }


    if let jsonData = jsonString.data(using: .utf8) {
        
        let decoder = JSONDecoder()

        do {
            let response = try decoder.decode(Response.self, from: jsonData)
            response.users.forEach { user in
                print(user.firstName)
            }
            
        } catch {
            print("sdfsdf")
            print(error.localizedDescription)
        }
    }

}

example03()
