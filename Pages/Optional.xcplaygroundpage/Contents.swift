import UIKit

struct Student: CustomStringConvertible {
    var description: String {
        var studentDescription: String = firstname
        if let middlename = middlename {
            studentDescription += " - \(middlename)"
        }
        return studentDescription
    }
    let firstname: String
    let lastname: String
    let middlename: String?
    let grade: String?
}
var student = Student(firstname: "test", lastname: "demo", middlename: "optional-middlename", grade: "A")
print(student)

if let middlename = student.middlename,
   let grade = student.grade {
    print("\(middlename) grade is \(grade)")
}

struct Teacher {
    let firstname: String?
    let lastname: String?
    
    var displayName: String {
        guard let firstname = firstname,
              let lastname = lastname else {
                  return "at least, either is nil"
        }
        return "\(firstname) - \(lastname)"
    }
    
    var displayName2: String {
        switch (firstname, lastname){
        case let(first?, last?): return "\(first) - \(last)"
        case let(first?, nil): return first
        case let(nil, last?): return last
        case let(nil, nil): return "both nil"
        }
    }
}
let teacher = Teacher(firstname: "test", lastname: nil)
print(teacher.displayName)
print(teacher.displayName2)

struct Grade {
    let gpa: Double
    let letter: String
}
struct Stu {
    let firstname: String
    var grade: Grade?
}
let stu = Stu(firstname: "test", grade: Grade(gpa: 3.0, letter: "B"))
print(stu.grade?.gpa ?? "Not available")

enum UserAgreement: RawRepresentable {
    case accepted
    case rejected
    case notSet
    init(rawValue: Bool?){
        switch rawValue {
        case true?: self = .accepted
        case false?: self = .rejected
        default: self = .notSet
        }
    }
}

