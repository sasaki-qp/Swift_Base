import UIKit
import Foundation

struct DataSequence: AsyncSequence {
    typealias Element = Data
    let urls: [URL]
    
    init(urls: [URL]) {
        self.urls = urls
    }
    
    func makeAsyncIterator() -> DataIterator {
        return DataIterator(urls: urls)
    }
}

struct DataIterator: AsyncIteratorProtocol {
    typealias Element = Data
    let urls: [URL]
    private var index = 0
    private let urlSession = URLSession.shared
    
    init(urls: [URL]) {
        self.urls = urls
    }
    
    mutating func next() async throws -> Data? {
        guard index < urls.count else {
            return nil
        }
        let url = urls[index]
        index += 1
        let (data, _) = try await urlSession.data(from: url)
        return data
    }
}

Task {
    let urlStr = "https://source.unsplash.com/random"
    let urls: [URL] = Array(0...10).map {_ in URL(string: urlStr)}.compactMap({ $0 })
    
    for try await data in DataSequence(urls: urls) {
        print(data.count) // binary
    }
}
