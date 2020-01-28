import UIKit

extension UIViewController {
    /// Shows an alert to user with a single button to dismiss the alert.
    public func alert(
        title: String?,
        message: String?,
        buttonTitle: String = "OK",
        withCancelOption: Bool = false,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        if withCancelOption {
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("cancel", comment: ""),
                style: .cancel,
                handler: nil
            ))
        }
        let defaultAction = UIAlertAction(
            title: buttonTitle,
            style: withCancelOption ? .default : .cancel,
            handler: handler
        )
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
