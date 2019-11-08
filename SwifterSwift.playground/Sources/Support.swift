import Foundation

public func example(_ description: String = "", action: () -> Void) {
    if description.isEmpty { return }
    print("\n --- Example of:", description, "---")
    action()
}
