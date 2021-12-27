import Foundation
import Models

public protocol RepoListReducerType {
    func reduce(_ state: RepoListStateModel, action: RepoListReducerAction) -> RepoListReducerUpdate
}

public struct RepoListReducer: RepoListReducerType {
    public init() {}
    
    public func reduce(_ state: RepoListStateModel, action: RepoListReducerAction) -> RepoListReducerUpdate {
        switch action {
        case .fetched:
            return RepoListReducerUpdate(
                state: state,
                effect: .showLoading
            )
        case .reposLoaded(let model):
            var repos = state.repos
            repos.append(contentsOf: map(items: model.items))
            let newState = RepoListStateModel(
                currentPage: state.currentPage + 1,
                lastFetchedPage: state.lastFetchedPage,
                isFetching: false,
                numberOfPages: model.totalCount/30,
                repos: repos
            )

            return RepoListReducerUpdate(
                state: newState,
                effect: .update
            )
        case .tappedRepo(let atIndex):
            guard state.repos.indices.contains(atIndex) else {
                return RepoListReducerUpdate(
                    state: state,
                    effect: .none
                )
            }

            let repo = state.repos[atIndex]
            return RepoListReducerUpdate(
                state: state,
                effect: .showRepo(repo)
            )
        case .requestedNewPage:
            return RepoListReducerUpdate(
                state: state,
                effect: .fetchRepos(page: state.currentPage)
            )
        }
    }

    private func map(items: [RepoList.Repo]) -> [RepoStateModel] {
        return items.map {
            RepoStateModel(
                id: $0.id,
                name: $0.name,
                description: $0.description ?? "",
                owner: RepoStateModel.OwnerStateModel(
                    name: $0.owner.login,
                    avatarUrl: $0.owner.avatarUrl
                ),
                stars: $0.stargazersCount,
                forks: $0.forks
            )
        }
    }
}
