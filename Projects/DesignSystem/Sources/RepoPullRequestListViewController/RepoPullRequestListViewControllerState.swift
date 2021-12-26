import Foundation

public enum RepoPullRequestListViewControllerState {
    case loading
    case error
    case show(RepoPullRequestListTableViewModel)
}
