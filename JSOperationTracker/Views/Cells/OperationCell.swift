import UIKit

class OperationCell: UITableViewCell {
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    func setUpCell(operation: Operation) {
        if let progress = operation.progress {
            self.progressView.progress = progress
        }
        if let state = operation.state {
            self.statusLabel.text = state

            if state == OperationUIStatus.ERROR {
                self.progressView.progressTintColor = .systemPurple
            }
            if state == OperationUIStatus.COMPLETED {
                self.progressView.progressTintColor = .systemGreen
            }
            if state == OperationUIStatus.IN_PROGRESS {
                self.progressView.progressTintColor = .systemIndigo
            }
        }
    }
}
