import Foundation
import WebKit

enum JSOperationStatus {
    case inProgress(value: Float)
    case completed(value: Float)
    case error
}

protocol JSEventsListener: AnyObject {
    /// Delegate for operation status: start, in-progress & completed
    func operationStatus(operation: Operation)
    /// Delegate for operation failed
    func operationFailed(error: String)
}

final class JSScriptMessageHandler: NSObject, WKScriptMessageHandler {
    private var completedValue: Float { Constants.OPERATION_COMPLETED_STATUS }
    private var completed: String { OperationStatus.COMPLETED }
    private var error: String { OperationStatus.ERROR }

    private weak var jsListenerDelegate: JSEventsListener?

    init(delegate: JSEventsListener) {
        jsListenerDelegate = delegate
    }

    // MARK: - WKScriptMessageHandler delegate Methods
    /// Callback from js script
    func userContentController(_: WKUserContentController, didReceive message: WKScriptMessage) {
        parseJSEvent(message: message)
    }

    /// Parse js response message
    private func parseJSEvent(message: WKScriptMessage) {
        guard let data = message.body as? String,
            var operation = try? Operation(data) else {
            jsListenerDelegate?.operationFailed(error: NSLocalizedString("IncorrectData", comment: ""))
            return
        }

        if let currentValue = operation.progress {
            operation.status = .inProgress(value: currentValue / Constants.STATUS_COMPLETED_DIVISOR)
        } else if operation.message == completed, let _state = operation.state {
            if _state == error {
                operation.status = .error
            } else {
                operation.status = .completed(value: completedValue)
            }
        }
        
        if let status = operation.status {
            switch status {
            case let .completed(value):
                operation.progress = value
                operation.state = OperationUIStatus.COMPLETED
            case .error:
                operation.state = OperationUIStatus.ERROR
            case let .inProgress(value):
                operation.progress = value
                operation.state = OperationUIStatus.IN_PROGRESS
            }
        }
        jsListenerDelegate?.operationStatus(operation: operation)
    }
}
