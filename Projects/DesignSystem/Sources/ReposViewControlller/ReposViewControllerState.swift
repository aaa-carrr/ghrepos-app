import Foundation

public enum ReposViewControllerState {
    case loading
    case error
    case show(ReposTableViewModel)
}
