import Foundation
import WebKit

protocol ReadyForOperations: AnyObject {
    func readyForOperations()
}

final class JSOperationManager: NSObject, WKNavigationDelegate {
    var operationManager: JSScriptMessageHandler?
    var jsScript: String!
    private var webView: WKWebView!
    var readyForOperationsDelegate: ReadyForOperations?

    init(jsScript: String, progreassDelegate: JSEventsListener, readyForOperationDelegate: ReadyForOperations?) {
        super.init()
        self.jsScript = jsScript
        self.readyForOperationsDelegate = readyForOperationDelegate
        self.operationManager = JSScriptMessageHandler(delegate: progreassDelegate)

        initWebView()
    }

    // MARK: - Private Methods
    private func initWebView() {
        webView = WKWebView(frame: .zero, configuration: configureWebView())
        webView.navigationDelegate = self
        webView.loadHTMLString("", baseURL: nil)
    }
    
    func configureWebView() -> WKWebViewConfiguration {
        let webviewConfig: WKWebViewConfiguration = WKWebViewConfiguration()
        let contentController: WKUserContentController = WKUserContentController()
        let script = WKUserScript(source: jsScript, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        webviewConfig.userContentController = contentController
        webviewConfig.userContentController.addUserScript(script)
        webviewConfig.userContentController.add(operationManager!, name: Constants.SCRIPT_MESSAGE)
        return webviewConfig
    }

    // MARK: - Public Methods
    /// Start js operation with operation id
    func startOperations(operation: Operation) {
        webView.evaluateJavaScript("\(Constants.START_OPERATION_JS_FUNCTION)(\(operation.id))") { _, error in
            if let jsExecutionError = error {
                print(jsExecutionError.localizedDescription)
            }
        }
    }

    // MARK: WKNavigationDelegate
    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        readyForOperationsDelegate?.readyForOperations()
    }
}
