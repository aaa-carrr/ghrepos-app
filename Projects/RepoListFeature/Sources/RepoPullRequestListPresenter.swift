import DesignSystem
import RxSwift
import RxCocoa
import Reducers
import Models
import UIKit
import Interactors

// MARK: - Delegate
public protocol RepoPullRequestListPresenterDelegate: AnyObject {
    func show(_ controller: UIViewController)
    func show(pullRequest url: String)
}

// MARK: - Protocol
public protocol RepoPullRequestListPresenterType: AnyObject {
    func setUp()
    var delegate: RepoPullRequestListPresenterDelegate? { get set }
}

public final class RepoPullRequestListPresenter:RepoPullRequestListPresenterType {
    // MARK: - Properties
    private let controller: RepoPullRequestListViewController
    private let reducer: RepoPullRequestListReducerType
    private let interactor: RepoPullRequestListInteractorType
    private let scheduler: SchedulerType

    private var state: RepoPullRequestListStateModel
    private let stateRelay: PublishRelay<RepoPullRequestListViewControllerState>
    private var disposeBag: DisposeBag = DisposeBag()

    public weak var delegate: RepoPullRequestListPresenterDelegate?

    // MARK: - Init
    public init(
        state: RepoPullRequestListStateModel,
        reducer: RepoPullRequestListReducerType,
        interactor: RepoPullRequestListInteractorType,
        scheduler: SchedulerType
    ) {
        self.state = state
        self.reducer = reducer
        self.interactor = interactor
        self.scheduler = scheduler
        self.stateRelay = PublishRelay<RepoPullRequestListViewControllerState>()
        self.controller = RepoPullRequestListViewController(
            repoListView: RepoPullRequestListTableView(),
            state: stateRelay.asObservable()
        )
    }

    // MARK: - API
    public func setUp() {
        setUpController()
    }

    // MARK: - Controller
    private func setUpController() {
        controller.onAction = { [weak self] action in
            self?.handleControllerAction(action)
        }

        delegate?.show(controller)
    }

    private func handleControllerAction(_ action: RepoPullRequestListViewControllerAction) {
        switch action {
        case .tappedPullRequest(let atIndex):
            let update = reducer.reduce(state, action: .tappedPullRequest(atIndex: atIndex.row))
            handleReducerUpdate(update)
        case .fetched:
            stateRelay.accept(.loading)
            let update = reducer.reduce(state, action: .fetched)
            handleReducerUpdate(update)
        case .requestedNewPage:
            let update = reducer.reduce(state, action: .requestedNewPage)
            handleReducerUpdate(update)
        }
    }

    // MARK: - Reducer
    private func handleReducer(action: RepoPullRequestListReducerAction) {
        let update = reducer.reduce(state, action: action)
        state = update.state
        handleReducerUpdate(update)
    }

    private func handleReducerUpdate(_ update: RepoPullRequestListReducerUpdate) {
        switch update.effect {
        case .fetchPullRequest:
            let resource = RepoPullRequestListResource(
                author: state.repoAuthor,
                repo: state.repoName
            )

            interactor
                .pullRequestList(from: resource)
                .observe(on: scheduler)
                .map { $0 }
                .subscribe(onSuccess: { [weak self] pullRequests in
                    self?.handleReducer(action: .pullRequestsLoaded(pullRequests))
                }, onFailure: { [weak self] _ in
                    self?.stateRelay.accept(.error)
                }).disposed(by: disposeBag)
        case .showPullRequest(let pullRequest):
            delegate?.show(pullRequest: pullRequest.url)
        case .update:
            let viewModel = makeViewModel()
            stateRelay.accept(.show(viewModel))
        case .none:
            break
        }
    }

    // MARK: - Helpers
    private func makeViewModel() -> RepoPullRequestListTableViewModel {
        return RepoPullRequestListTableViewModel(
            section: RepoPullRequestListTableViewSection(section: 0),
            cells: state.pullRequests.map { [weak self] in
                let userProfile = UserProfileCompactViewModel(
                    username: $0.author.name,
                    profileImage: LoadableImage(
                        single: self?.interactor.authorProfileImage(from: $0.author.avatarUrl) ?? Single<UIImage>.just(UIImage()),
                        defaultImage: UIImage(systemName: "person.circle.fill") ?? UIImage()
                    )
                )

                let splitDate = $0.dateOfCreation.split(separator: "T").first

                return RepoPullRequestListTableViewCellViewModel(
                    id: $0.id,
                    pullRequestTitle: $0.title,
                    pullRequestBody: $0.body,
                    pullRequestAuthor: userProfile,
                    pullRequestDateOfCreation: String(splitDate ?? "")
                )
            }
        )
    }
}

