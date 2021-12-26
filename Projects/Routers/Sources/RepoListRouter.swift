import RepoListFeature
import Reducers
import RxSwift
import Interactors
import Networking
import UIKit

public final class RepoListRouter: RouterType {
    private let navigationController: UINavigationController
    private var presenter: RepoListPresenter?
    private var childRouter: RouterType?

    public init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }

    public func setUp() {
        presenter = RepoListPresenter(
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

        presenter?.delegate = self

        presenter?.setUp()
    }
}

extension RepoListRouter: RepoListPresenterDelegate {
    public func show(_ controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }
}
