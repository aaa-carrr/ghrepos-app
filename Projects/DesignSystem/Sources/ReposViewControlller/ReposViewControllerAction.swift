import Foundation

public enum ReposViewControllerAction {
    case tappedRepo(atIndex: IndexPath)
    case fetched
    case requestedNewPage(atIndices: [IndexPath])
}
