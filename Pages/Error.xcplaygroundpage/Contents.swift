import UIKit
import Foundation

/**
 Type of Errors
  Syntax Errors
  Runtime Errors
  Logic Errors
 */
enum BankAccountError: Error {
    case insufficientFunds
}
class BankAccount {
    var balance: Double
    init(balance: Double) {
        self.balance = balance
    }
    func withdraw(amount: Double) throws {
        if balance < amount {
            throw BankAccountError.insufficientFunds
        }
        balance -= amount
    }
}
let account = BankAccount(balance: 100)
do {
    try account.withdraw(amount: 300)
} catch {
    print(error)
}

struct Post: Decodable {
    let title: String
    let body: String
}
enum NetworkError: Error {
    case badUrl
    case decodingError
    case badRequest
    case noData
    case custom(Error)
}
func getPosts(completion: @escaping(Result<[Post], NetworkError>) -> Void) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        completion(.failure(.badUrl))
        return
    }
    URLSession.shared.dataTask(with: url) {(data, res, err) in
        if let err = err {
            completion(.failure(.custom(err)))
        } else if(res as? HTTPURLResponse)?.statusCode != 200 {
            completion(.failure(.badRequest))
        }
        
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        if let posts = posts {
            completion(.success(posts))
        } else {
            completion(.failure(.decodingError))
        }
    }.resume()
}
//getPosts { res in
//    switch res {
//    case .success(let posts):
//        print(posts)
//    case .failure(let err):
//        print(err)
//    }
//}

enum ItemError: Error {
    case notExist(String)
    case soldout(String)
}
struct Item {
    let isExist: String
    let isSoldout: String
}
struct Store {
    func cell() -> Item? {
        do {
            let isExist = try checkIsExist()
            let isSoldout = try checkIsSoldout()
            return Item(isExist: isExist, isSoldout: isSoldout)
        } catch {
          print("Can not cell: \(error)")
          return nil
        }
    }
    private func checkIsExist() throws -> String {
        throw ItemError.notExist("not exist")
    }
    private func checkIsSoldout() throws -> String {
        throw ItemError.soldout("soldout")
    }
}

enum ValidationError: Error {
    case emptyValue
    case invalidEmail
}

func validateEmail(_ email: String) throws -> String? {
    if email.isEmpty {
        throw ValidationError.emptyValue
    }
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let validator = NSPredicate(format: "SELF MATCHES %@", pattern)
    let isValid = validator.evaluate(with: email)
    if !isValid {
        throw ValidationError.invalidEmail
    }
    return "Email is valid" // nil
}
do {
    let res: String? = try validateEmail("test@gmail.com")
    if let res = res {
        print(res)
    } else {
        print("res is nil")
    }
}catch {
    print(error)
}

struct Email {
    let email: String
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    init(_ text: String) throws {
        if text.isEmpty {
            throw ValidationError.emptyValue
        }
        let validator = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isValid = validator.evaluate(with: text)
        if !isValid {
            throw ValidationError.invalidEmail
        }
        self.email = text
    }
}
do {
    try Email("")
} catch {
    print(error)
}
/**
  try?
    somethig went wrong -> return nil
  try!
    something went wrong -> runtime error
*/
let email = try? Email("invalid email type")
print(email)

