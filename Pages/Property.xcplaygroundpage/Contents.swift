import UIKit

enum Level {
    case easy
    case medium
    case hard
}

struct Exam {
    var level: Level
    lazy private(set) var questions: [String] = {
        sleep(3)
        switch level {
            case .easy:
                    return ["What is 1 + 1", "What is 1 - 1"]
            case .medium:
                    return ["What is 10 + 10", "What is 10 - 10"]
            case .hard:
                    return ["What is 100 + 100", "What is 100 - 100"]
        }
    }()
}
var exam: Exam = Exam(level: .easy)
//print(exam.questions)
//lazyを使用しているpropertyはインスタンスにアクセスされていない場合、何かのpropertyを初期化すると上書きされる
exam.level = .hard
print(exam.questions)
// private(set): exam.questions = ["something"] -> Error

// Computed property
struct Workout {
    // stored property
    let start: Date
    let end: Date
    // computed property
    var time: TimeInterval {
        end.timeIntervalSince(start)
    }
}
let start = Date()
sleep(3)
let end = Date()
let workout = Workout(start: start, end: end)
print(workout.time)

struct Website {
    var url: String {
        willSet { // 4 }
        didSet { // 3
            // encoding correct property
            url = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? url
        }
    }
    init(url: String){
        defer {
            self.url = url // 2
        }
        self.url = url // 1
    }
}
// didSet doesnt active
var website = Website(url: "www.com.movies/?search=Test Demo")
// didSet active(not use defer)
website.url = "www.com.movies/?search=Test Demo"
// www.com.movies%2F%3Fsearch=Test%20Demo
print(website.url)

