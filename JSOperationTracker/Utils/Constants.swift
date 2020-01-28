import Foundation

struct Endpoints {
    static let jsScriptEndPoint = URL(string: "https://www.dropbox.com/s/utqx8qha367mlqa/tasks.js?dl=1")!
}

struct Constants {
    static let NUMBER_OF_OPERATIONS = 15
    static let SCRIPT_MESSAGE = "operation"
    static let START_OPERATION_JS_FUNCTION = "startOperation"
    static let OPERATION_CELL = "OperationCell"
    static let ZERO = 0
    static let STATUS_COMPLETED_DIVISOR: Float = 100.0
    static let OPERATION_INITIAL_PROGRESS: Float = 0.0
    static let OPERATION_COMPLETED_STATUS: Float = 1.0
    static let CELL_INDEX_DECREMENT = 1
}

struct OperationStatus {
    static let COMPLETED = "completed"
    static let ERROR = "error"
}

struct Errors {
    static let DECODING_ERROR_DOMAIN = "Decoding"
    static let DECODING_ERROR_CODE = 0
}

struct OperationUIStatus {
    static let START = "Start"
    static let IN_PROGRESS = "In Progress"
    static let COMPLETED = "Completed"
    static let ERROR = "Error"
}
