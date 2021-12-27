import Foundation
import Models

public enum RepoListReducerAction {
    case fetched
    case requestedNewPage
    case reposLoaded(RepoList)
    case tappedRepo(atIndex: Int)
}

public enum RepoListReducerEffect: Equatable {
    case fetchRepos(page: Int)
    case showRepo(RepoStateModel)
    case update
    case showLoading
    case none
}

public struct RepoListReducerUpdate {
    public let state: RepoListStateModel
    public let effect: RepoListReducerEffect

    public init(
        state: RepoListStateModel,
        effect: RepoListReducerEffect
    ) {
        self.state = state
        self.effect = effect
    }
}
