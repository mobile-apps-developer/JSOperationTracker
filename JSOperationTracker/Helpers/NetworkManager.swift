import Foundation

final class NetworkManager {
    /// Get js script data from server
    func getData(from url: URL, completionHandler: @escaping ((Data?, Error?) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            OperationQueue.main.addOperation {
                completionHandler(data, error)
            }
        }.resume()
    }
}
