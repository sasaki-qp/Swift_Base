import UIKit

struct Item: Codable {
    let id: Int
    let name: String
    let type: String
}

enum CustomError: Error {
    case invalidUrl
}

class Service {
    func fetch(url : URL?) async throws -> [Item] {
        guard let url = url else {
            throw CustomError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let items: [Item] = try JSONDecoder().decode( [Item].self, from: data)
        return items
    }
}

func fetchData () async {
    do {
        let items: [Item] = try await Service().fetch(url: URL(string: ""))
        print("success fetch items: \(items)")
    } catch {
      print(error)
    }
}

