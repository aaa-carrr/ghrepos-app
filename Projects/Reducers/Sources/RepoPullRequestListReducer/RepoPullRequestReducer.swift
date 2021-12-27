import Foundation
import Models

public protocol RepoPullRequestListReducerType {
    func reduce(_ state: RepoPullRequestListStateModel, action: RepoPullRequestListReducerAction) -> RepoPullRequestListReducerUpdate
}

public struct RepoPullRequestListReducer: RepoPullRequestListReducerType {
    public init() {}

    public func reduce(
        _ state: RepoPullRequestListStateModel,
        action: RepoPullRequestListReducerAction
    ) -> RepoPullRequestListReducerUpdate {
        switch action {
        case .fetched:
            return RepoPullRequestListReducerUpdate(
                state: state,
                effect: .showLoading
            )
        case .requestedNewPage:
            if state.canFetchNewPage {
                return RepoPullRequestListReducerUpdate(
                    state: state,
                    effect: .fetchPullRequest(state.currentPage)
                )
            } else {
                return RepoPullRequestListReducerUpdate(
                    state: state,
                    effect: .none
                )
            }
        case .pullRequestsLoaded(let prs):
            var pullRequests = state.pullRequests
            pullRequests.append(contentsOf: map(pullRequests: prs))
            let newState = RepoPullRequestListStateModel(
                repoAuthor: state.repoAuthor,
                repoName: state.repoName,
                currentPage: state.currentPage + 1,
                canFetchNewPage: prs.count < 30 ? false : true,
                pullRequests: pullRequests
            )

            return RepoPullRequestListReducerUpdate(
                state: newState,
                effect: .update
            )
        case .tappedPullRequest(let atIndex):
            guard state.pullRequests.indices.contains(atIndex) else {
                return RepoPullRequestListReducerUpdate(
                    state: state,
                    effect: .none
                )
            }

            let pullRequest = state.pullRequests[atIndex]
            return RepoPullRequestListReducerUpdate(
                state: state,
                effect: .showPullRequest(pullRequest)
            )
        }
    }

    private func map(pullRequests: [RepoPullRequest]) -> [RepoPullRequestStateModel] {
        return pullRequests.map {
            return RepoPullRequestStateModel(
                id: $0.id,
                title: $0.title,
                body: $0.body ?? "",
                author: RepoPullRequestStateModel.AuthorStateModel(
                    name: $0.user.login,
                    avatarUrl: $0.user.avatarUrl
                ),
                url: $0.url,
                dateOfCreation: $0.createdAt
            )
        }
    }
}
