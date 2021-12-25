import UIKit

@propertyWrapper
final class AutoLayout<T: UIView> {
    private let view: T = {
        let view = T(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var wrappedValue: T {
        return view
    }
}
