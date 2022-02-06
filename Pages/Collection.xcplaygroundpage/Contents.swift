import UIKit
// Iterator
let names = ["Alex", "John", "Anthony", "Mary", "Steven"]
var nameIterator = names.makeIterator();
while let name = nameIterator.next(){
    print(name)
}
struct Countdown: Sequence {
    let start: Int
    func makeIterator() -> some IteratorProtocol {
        return CountdownIterator(self)
    }
}
struct CountdownIterator: IteratorProtocol {
    let countdown: Countdown
    var currentValue: Int = 0

    init(_ countdown: Countdown) {
        self.countdown = countdown
        self.currentValue = countdown.start
    }
    
    mutating func next() -> Int? {
        print("invoked in for sentense")
        if currentValue > 0 {
            currentValue -= 1
            return currentValue
        } else {
            return nil
        }
    }
}
let countdown = Countdown(start: 10)
let countdown2 = Countdown(start: 5)
// for count in countdown { print(count) }
struct Clothing {
    let color: String
    let genre: String
    let price: Double
}
let clothes: [Clothing] = [
    Clothing(color: "red", genre: "tops", price: 5.0),
    Clothing(color: "red", genre: "bottoms", price: 10.0),
    Clothing(color: "bkue", genre: "tops", price: 15.0),
]
let filteredClothes: [Clothing] = clothes.filter {elm in
    return elm.price >= 10.0
}
clothes.enumerated().forEach { (index, value) in }

//let indexes: Range<Int> = 1..<5000
//let filterStrs: [String] = indexes.lazy.filter { index -> Bool in
//    return index % 2 == 0
//}.map{ index -> String in
//    print("Map, index(filter return value): \(index)")
//    return "current index \(index)"
//}
//print(filterStrs.suffix(3))
//suffix get item last 3(argument)
struct Cart {
    private(set) var items: [Clothing] = []
    
   mutating func addItem(_ item: Clothing) {
        self.items.append(item)
    }
    
    var total: Double {
        items.reduce(0){(value, item) -> Double in
            print("In reduce function \(value)")
            return value + item.price
        }
    }
}
var cart: Cart = Cart()
cart.addItem(clothes[0])
cart.addItem(clothes[1])
cart.addItem(clothes[2])
print(cart.total)

let ratings: [Int] = [1, 2, 2, 1, 3, 2, 3, 3, 1, 1]
let res = ratings.reduce(into: [:]) {(res: inout [String: Int], rating: Int) in
    switch rating {
        case 1..<2: res["Bad", default: 0] += 1
        case 2..<3: res["Normal", default: 0] += 1
        case 3..<4: res["Good", default: 0] += 1
        default: break
    }
}
print(res)


