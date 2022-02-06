import UIKit

struct Student {
    let firstname: String
    let lastname: String
    var grade: String
}

extension Student {
    init(firstname: String, lastname: String){
        self.firstname = firstname
        self.lastname = lastname
        self.grade = "normal"
    }
}
let student = Student(firstname: "demo", lastname: "test")

protocol CarType {
    init(make: String, model: String)
}

class Car: CarType {
    var make: String
    var model: String
    var color: String
    init(make: String, model: String, color: String){
        self.make = make
        self.model = model
        self.color = color
    }
    required convenience init(make: String, model: String){
        self.init(make: make, model: model, color: "Black")
    }
}

class Toyota: Car {
    var range: Double
    override init(make: String, model: String, color: String){
        self.range = 300
        super.init(make: make, model: model, color: color)
    }
}
let toyota = Toyota(make: "toyota", model: "k", color: "black")
print(toyota)

