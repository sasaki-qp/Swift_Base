import UIKit

//struct Session {
//    let title: String
//    let speaker: String
//    let date: Date
//    let isKeynote: Bool
//    let isWorkShop: Bool
//    let isRecorded: Bool
//    let isJoinSession: Bool
//    let joinSpeakers: [String]
//}
enum Session {
    case keynote(title: String, speaker: String, date: Date, isRecorded: Bool)
    case normal(title: String, speaker: String, date: Date)
    case workshop(title: String, speaker: String, date: Date, isRecorded: Bool)
    case join(title: String, speaker: [String], date: Date)
}

struct Teacher {
    let name: String
    let courses: [String]
}
struct Student {
    let name: String
    let courses: [String]
    var grade: String?
}
enum User {
    case teacher(Teacher)
    case student(Student)
}

let teacher = Teacher(name: "John", courses: ["Math", "History"])
let student = Student(name: "Tom", courses: ["Math", "Science"])

let users: [Any] = [teacher, student]
let allUsers: [User] = [User.teacher(teacher) ,User.student(student)]

for user in allUsers {
    switch user {
        case .teacher(let teacher):
            print(teacher.name);
        case .student(let student):
            print(student.grade ?? "untitled")
    }
}

class BaseTicketOpts {
    var departure: String
    var arrival: String
    var price: Double
    init(departure: String, arrival: String, price: Double){
        self.departure = departure
        self.arrival = arrival
        self.price = price
    }
}

class Business: BaseTicketOpts {
    var isMeal: Bool
    var chargingPorts: Bool
    
    init(departure: String, arrival: String, price: Double, isMeal: Bool, chargingPort: Bool){
        self.isMeal = isMeal
        self.chargingPorts = chargingPort
        super.init(departure: departure, arrival: arrival, price: price)
    }
}
class FirstClass: BaseTicketOpts {
    var isMeal: Bool
    
    init(departure: String, arrival: String, price: Double, isMeal: Bool){
        self.isMeal = isMeal
        super.init(departure: departure, arrival: arrival, price: price)
    }
}
func checkIn (ticket: BaseTicketOpts) {
    switch ticket {
        case let ticket as Business:
            print(ticket)
        case let ticket as FirstClass:
            print(ticket)
        default: break;
    }
}


