import Foundation

public enum RepoPullRequestListViewControllerAction {
    case tappedPullRequest(atIndex: IndexPath)
    case fetched
    case requestedNewPage
}
