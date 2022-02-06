import UIKit
import Foundation

protocol BaseTicket {
    var name: String { get }
    var departure: Date? { get set }
    var arrival: Date? { get set }
}
extension Date {
    static func fiveHoursFromNow() -> Date {
        return Date().addingTimeInterval(5 * 60 * 60)
    }
}
struct Economy: BaseTicket {
    let name = "Economy"
    var departure: Date?
    var arrival: Date?
}
struct Business: BaseTicket {
    let name = "Business"
    var departure: Date?
    var arrival: Date?
}
struct First: BaseTicket {
    let name = "First"
    var departure: Date?
    var arrival: Date?
}
class Service {
    var tickets: [BaseTicket]
    init(tickets: [BaseTicket]) {
        self.tickets = tickets
    }
    func addTicket(ticket: BaseTicket) {
        self.tickets.append(ticket)
    }
    func printTicket() {
        tickets.forEach { print($0) }
    }
}
let economyTickets = [Economy(departure: Date(), arrival: Date.fiveHoursFromNow())]
let service: Service = Service(tickets: economyTickets)
service.addTicket(ticket: First(departure: Date(), arrival: Date.fiveHoursFromNow()))

protocol Parser {
    associatedtype Input
    associatedtype Output
    func parse(input: Input) -> Output
}
extension Parser {
    func parse(input: String) -> [String] {
        return [input, "parser"]
    }
}
class Demo: Parser {
    func parse(input: Int) ->[Int]{
        return [1, 2]
    }
}

let demo = Demo()
print(demo.parse(input: "extension"))

class TextFirldParser: Parser {
    func parse(input: String) -> String {
        return "parse"
    }
}
class HTMLParser: Parser {
    func parse(input: String) -> [Int] {
        return [1, 10, 100]
    }
}
class JsonParser: Parser {
    typealias Input = String
    typealias Output = [String: String]
    
    func parse(input: Input) -> Output {
        return ["title": input]
    }
}
func runParser<P: Parser>(parser: P, input: [P.Input]) where P.Input == JsonParser {
    input.forEach{
        print($0)
    }
}

protocol Account {
    var balance: Double { get set }
    mutating func deposit(amount: Double)
    mutating func withdraw(amount: Double)
    func transfer(from: Account, to: Account, amount: Double)
    func calculateInterestEarned() -> Double
}

extension Account {
    mutating func deposit(amount: Double) {
        balance += amount
    }
    mutating func withdraw(amount: Double) {
        balance -= amount
    }
    func calculateInterestEarned() -> Double {
        print("extension calculate")
        return (balance * (0.1/100))
    }
}

protocol Verification {
    func performVerification(req: VerificationReq, completion: (VerificationRes) -> Void)
}

extension Verification {
    func performVerification(req: VerificationReq, completion: (VerificationRes) -> Void){
        
    }
}
struct VerificationReq {
    let accounts: [Account]
}
struct VerificationRes {
    let verified: Bool
}

struct CheckingAccount: Account, Verification {
    var balance: Double
    func calculateInterestEarned() -> Double {
        print("checking account calculate")
        return (balance * (0.1/100))
    }
    func transfer(from: Account, to: Account, amount: Double) {
        performVerification(req: VerificationReq(accounts: [from, to])){ res in
            if res.verified {
                // transfer funds
            }
        }
    }
}
struct ManeyMarketAccount: Account {
    var balance: Double
    func transfer(from: Account, to: Account, amount: Double) {}
}
let checkingAccount = CheckingAccount(balance: 300.0)
struct Course {
    let courseNum: String
    let name: String
    let creditHours: Int
}
// 型定義的な役割
protocol Student {
    var courses: [Course] { get set }
    func verify() -> Bool
    mutating func enroll(course: Course)
}
// 実際のfunction body記述
extension Student {
    mutating func enroll(course: Course){
        courses.append(course)
    }
}
// inherited
protocol VerifiedStudent: Student {
    func verify() -> Bool
}
extension VerifiedStudent {
    mutating func enroll(course: Course) {
        if verify() {
            courses.append(course)
            print("Successfully enroll in course")
        }
    }
    func verify() -> Bool {
        return true
    }
}
struct InternationalStudent: VerifiedStudent {
    var courses: [Course]
}
var internationalStudent = InternationalStudent(courses: [Course(courseNum: "A", name: "Course A", creditHours: 2)])
internationalStudent.enroll(course: Course(courseNum: "B", name: "Course B", creditHours: 2))


