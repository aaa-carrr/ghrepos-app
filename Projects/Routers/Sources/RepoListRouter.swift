import RepoListFeature
import Reducers
import RxSwift
import Interactors
import Networking
import UIKit
import DesignSystem

public final class RepoListRouter: RouterType {
    private let navigationController: UINavigationController
    private var repoListPresenter: RepoListPresenterType?
    private var repoPullRequestPresenter: RepoPullRequestListPresenterType?

    public init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }

    public func setUp() {
        repoListPresenter = RepoListPresenter(
            state: RepoListStateModel(
                currentPage: 1,
                lastFetchedPage: 0,
                isFetching: false,
                numberOfPages: 1,
                repos: []
            ),
            reducer: RepoListReducer(),
            interactor: RepoListInteractor(),
            scheduler: MainScheduler.instance
        )

        repoListPresenter?.delegate = self

        repoListPresenter?.setUp()
    }
}

extension RepoListRouter: RepoListPresenterDelegate {
    public func show(repo: RepoStateModel) {
        repoPullRequestPresenter = RepoPullRequestListPresenter(
            state: RepoPullRequestListStateModel(
                repoAuthor: repo.owner.name,
                repoName: repo.name,
                currentPage: 1,
                canFetchNewPage: true,
                pullRequests: []
            ),
            reducer: RepoPullRequestListReducer(),
            interactor: RepoPullRequestListInteractor(),
            scheduler: MainScheduler.instance
        )

        repoPullRequestPresenter?.delegate = self
        repoPullRequestPresenter?.setUp()
    }

    public func show(_ controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }
}

extension RepoListRouter: RepoPullRequestListPresenterDelegate {
    public func show(pullRequest url: String) {
        let controller = RepoPullRequestWebViewController(url: url)
        navigationController.topViewController?.present(controller, animated: true)
    }
}


