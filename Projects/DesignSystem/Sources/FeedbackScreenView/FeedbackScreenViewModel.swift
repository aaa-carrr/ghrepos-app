import UIKit

enum FeedbackScreenViewModel {
    case error
    case loading

    var message: String {
        switch self {
        case .loading:
            return ""
        case .error:
            return "Algo de errado ocorreu. Tente novamente."
        }
    }

    var icon: UIImage? {
        switch self {
        case .loading:
            return nil
        case .error:
            return UIImage(systemName: "xmark.octagon.fill")
        }
    }

    var iconColor: UIColor {
        switch self {
        case .loading:
            return .systemBackground
        case .error:
            return .systemRed
        }
    }

    var action: String {
        switch self {
        case .loading:
            return ""
        case .error:
            return "Tentar novamente"
        }
    }

    var loading: Bool {
        switch self {
        case .loading:
            return true
        case .error:
            return false
        }
    }
}
