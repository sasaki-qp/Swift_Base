import UIKit

struct Movie: Codable {
    let name: String
}
let numbers: [Int] = [1, 2, 3, 4, 5, 6]
let names: [String] = ["John", "Sum", "Tom", "Steven"]
let movies: [Movie] = [Movie(name: "A"), Movie(name: "B"), Movie(name: "C")]

func firstLast<T>(items: [T]) -> (T, T){
    return (items[0], items[items.count - 1])
}

func findIndex<T: Equatable>(list: [T], value: T) -> Int? {
    return list.firstIndex{(num) -> Bool in
        return num == value
    }
}

func selializeToData<T: Encodable>(value: T) -> Data? {
    return try? JSONEncoder().encode(value)
}
print(selializeToData(value: Movie(name: "A")))

protocol A { func A() }
protocol B { func B() }
protocol C { func C() }
//func abc<T: A, B, C>
typealias ABC = A & B & C
struct AStruct: A {
    func A () {
        print("A struct")
    }
}
struct ABCStruct: ABC {
    func A() { print("A function") }
    func B() { print("B function") }
    func C() { print("C function") }
}
func abc<T: ABC>(value: T) {
    print(type(of: value))
}
abc(value: ABCStruct())

// Equatable: ==
// Comparable: < >
enum Card: Comparable {
    case ace   // smaller
    case queen
    case king  // bigger
}

func compare<T: Comparable>(items: [T]) -> [T]? {
    let sortedItems = items.sorted() { return $0 < $1}
    return sortedItems
}
print(compare(items: [40, 10, 30, 50, 20]))
print(compare(items: [Card.king, Card.ace, Card.queen]))

enum Callback<T: Codable, E: Error> {
    case success(T)
    case failure(E)
}
enum NetworkError: Error {
    case badUrl
}
struct Post: Codable {
    let title: String
}

func getPosts(completion: (Callback<[Post], NetworkError>) -> Void) throws {
    let posts: [Post] = [Post(title: "A"), Post(title: "B")]
//    if posts.count == 2 {
//        throw NetworkError.badUrl
//    }
    completion(.success(posts))
}

do {
    try getPosts{ (res) in
        print(res)
    }
} catch {
    print(error)
}
