import UIKit
import WebKit

class OperationsViewController: UIViewController, JSEventsListener {
    // MARK: - IBOutlets
    @IBOutlet var operationsTableView: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!
    var progressMaping = [Int:Float]()

    // MARK: - Variables
    private var jsOperationManager: JSOperationManager?
    private lazy var serverOperations: [Operation] = []

    // MARK: - View's Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Download the javascript file
        loader.startAnimating()
        downloadJSScript()
    }

    // MARK: - Private Methods
    private func downloadJSScript() {
        NetworkManager().getData(from: Endpoints.jsScriptEndPoint) { [weak self] data, error in
            self?.loader.stopAnimating()
            guard let self = self else { return }
            if let _data = data, let jsScript = String(data: _data, encoding: .utf8) {
                self.evaluteJSScript(jsScript: jsScript)
            } else if let _error = error {
                self.alert(title: NSLocalizedString("JSScriptError", comment: ""), message: _error.localizedDescription)
            }
        }
    }

    /// Evalue js script data
    private func evaluteJSScript(jsScript: String) {
        jsOperationManager = JSOperationManager(jsScript: jsScript, progreassDelegate: self, readyForOperationDelegate: self)
    }

    private func prepareOperations() {
        for count in 1 ... Constants.NUMBER_OF_OPERATIONS {
            let operation = Operation(id: count, message: "", state: OperationUIStatus.START, progress: Constants.OPERATION_INITIAL_PROGRESS)
            serverOperations.append(operation)
            jsOperationManager?.startOperations(operation: operation)
        }
    }

    // MARK: - JSEventsListener Delegate
    func operationStatus(operation: Operation) {
        if operation.progress != nil { progressMaping[operation.id] =  operation.progress }
      let index = operation.id - Constants.CELL_INDEX_DECREMENT // JS Operations starting value is 1
      serverOperations[index] = operation
      let indexPath = IndexPath(row: index, section: Constants.ZERO)
      if let _ = operationsTableView.indexPathsForVisibleRows?.contains(indexPath) {
        let cell = self.operationsTableView.cellForRow(at: IndexPath(item: index, section: 0)) as? OperationCell
            let tracking = (progressMaping[operation.id] ?? 0.0)
            cell?.setUpCell(operation: operation, progress: tracking)
        }
    }

    func operationFailed(error: String) {
        alert(title: NSLocalizedString("OperationError", comment: ""), message: error)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension OperationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return serverOperations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.OPERATION_CELL, for: indexPath) as? OperationCell else { return UITableViewCell() }
        let operation = serverOperations[indexPath.row]
        cell.setUpCell(operation: operation, progress: progressMaping[operation.id] ?? 0.0)
        return cell
    }
}

// MARK: - ReadyForOperationsDelegate
extension OperationsViewController: ReadyForOperations {
    func readyForOperations() {
        self.prepareOperations()
        self.operationsTableView.reloadData()
    }
}
