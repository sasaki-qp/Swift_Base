import UIKit

struct Item {
    var id: Int?
    var name: String
}
func saveItem(_ item: inout Item) {
    item.id = 10
//    not use inout
//    -> User
//    var copyItem: User = user
//    copyUser.userId = 10
//    return copyUser
}
var item = Item(name: "Car")
saveItem(&item) // not use inout: user = saveUser(user)
print(item)

class ItemBuilder {
    func create() -> Item {
        func prepareName () -> String {
            return "test name"
        }
        
        func prepareId () -> Int {
            return 10
        }
        return Item(id: prepareId(), name: prepareName())
    }
}
let builder: ItemBuilder = ItemBuilder()
let createItem: Item = builder.create()
print(createItem)

//let hello: (String) -> () = {print("hello \($0)!")}
let hello: (String) -> () = { name in //引数を使用しない場合は _
    print("hello \(name)!")
}
//let pow:(Int, Int) -> Int = {return $0 * $1 }
let pow: (Int, Int) -> Int = {number, times in
    return number * times
}

// return empty array
//func getPosts() -> [String] {
//    var posts: [String] = []
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//        posts = ["Hello world", "Introduction closure"]
//    }
//    return posts;
//}

//Escaping closure captures non-escaping parameter 'completion' -> @escaping
func getPosts(completion: @escaping ([String]) -> ()){
    var posts: [String] = []
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        posts = ["Hello world", "Introduction closure"]
        completion(posts)
    }
}
getPosts {(posts) in
    print(posts)
}

