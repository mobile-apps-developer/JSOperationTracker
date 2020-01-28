import UIKit
import UICircularProgressRing

class OperationCell: UITableViewCell {
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var operationTitle: UILabel!
    @IBOutlet weak var progressRing: UICircularProgressRing!
    
    func setUpCell(operation: Operation, progress: Float) {
        self.operationTitle.text = "Operation " + "\(operation.id)"
        self.progressRing.font = UIFont.systemFont(ofSize: 12)

        self.progressRing.startProgress(to: CGFloat(progress * 100.0), duration: 0)

        if let state = operation.state {
            self.statusLabel.text = state

            if state == OperationUIStatus.ERROR {
                self.progressRing.innerRingColor = .systemPurple
            }
            if state == OperationUIStatus.COMPLETED {
                self.progressRing.innerRingColor = .systemGreen
            }
            if state == OperationUIStatus.IN_PROGRESS {
                self.progressRing.innerRingColor = .systemIndigo
            }
        }
    }
}
