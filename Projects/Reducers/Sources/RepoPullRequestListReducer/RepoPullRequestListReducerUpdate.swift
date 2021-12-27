import Foundation
import Models

public enum RepoPullRequestListReducerAction {
    case fetched
    case requestedNewPage
    case pullRequestsLoaded([RepoPullRequest])
    case tappedPullRequest(atIndex: Int)
}

public enum RepoPullRequestListReducerEffect: Equatable {
    case fetchPullRequest(Int)
    case showPullRequest(RepoPullRequestStateModel)
    case update
    case none
}

public struct RepoPullRequestListReducerUpdate {
    public let state: RepoPullRequestListStateModel
    public let effect: RepoPullRequestListReducerEffect

    public init(
        state: RepoPullRequestListStateModel,
        effect: RepoPullRequestListReducerEffect
    ) {
        self.state = state
        self.effect = effect
    }
}
