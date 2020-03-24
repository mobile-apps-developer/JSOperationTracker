# JSOperationTracker App
This is a single-screen app to execute multiple "operations" defined in a javascript file, and display the progress and state of these operations to the user.
- It Download the javascript file 
- Load javascript on a webview to evaluate 
- Created mutiple opearations and call startOperation function for each operation 
- For vissually reprasentation I have used table view and each cell of the table view represent a operation and display its status and progress for showing multiple operations simultaneously.

# Main Components of App
### JSOperationManager
This class is responsible for loading the javascript to take the operations and return the response. It includes -  
- init webview to load javascript
- Start operations method to start javascript operation
- Callbacks for operation's progress and status

### Operation
Class to represent an operation which includes progress and its status parameters.

### OperationsViewController
This controller is responsible for starting the operations and showing the status of operations in tableview.

# Build Info
- iOS 13.0+
- Xcode 11.3
- Swift 5

# Project Setup
### Cocoa pods is our dependency manager, If cocoapod is not installed at your machine please visit: https://guides.cocoapods.org/using/getting-started.html
- Go to your project root directory at mac terminal
- Run `pod install`
- Close the exiting project and open it with `JSOperationTracker.xcworkspace` 
