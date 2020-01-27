import Foundation

// MARK: - Operation
struct Operation: Decodable {
    var id: Int
    var message: String
    var state: String?
    var status: JSOperationStatus?
    var progress: Float?

    enum CodingKeys: String, CodingKey {
        case id
        case message
        case state
        case progress
    }
}

extension Operation {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Operation.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: Errors.DECODING_ERROR_DOMAIN, code: Errors.DECODING_ERROR_CODE, userInfo: nil)
        }
        try self.init(data: data)
    }
}
