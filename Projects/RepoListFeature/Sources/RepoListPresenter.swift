import DesignSystem
import RxSwift
import RxCocoa
import Reducers
import Models
import UIKit
import Interactors

// MARK: - Delegate
public protocol RepoListPresenterDelegate: AnyObject {
    func show(_ controller: UIViewController)
    func show(repo: RepoStateModel)
}

// MARK: - Protocol
public protocol RepoListPresenterType: AnyObject {
    func setUp()
    var delegate: RepoListPresenterDelegate? { get set }
}

public final class RepoListPresenter: RepoListPresenterType {
    // MARK: - Properties
    private let controller: ReposViewController
    private let reducer: RepoListReducerType
    private let interactor: RepoListInteractorType
    private let scheduler: SchedulerType

    private var state: RepoListStateModel
    private let stateRelay: PublishRelay<ReposViewControllerState>
    private var disposeBag: DisposeBag = DisposeBag()

    public weak var delegate: RepoListPresenterDelegate?

    // MARK: - Init
    public init(
        state: RepoListStateModel,
        reducer: RepoListReducerType,
        interactor: RepoListInteractorType,
        scheduler: SchedulerType
    ) {
        self.state = state
        self.reducer = reducer
        self.interactor = interactor
        self.scheduler = scheduler
        self.stateRelay = PublishRelay<ReposViewControllerState>()
        self.controller = ReposViewController(
            repoListView: ReposTableView(),
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

    private func handleControllerAction(_ action: ReposViewControllerAction) {
        switch action {
        case .tappedRepo(let atIndex):
            let update = reducer.reduce(state, action: .tappedRepo(atIndex: atIndex.row))
            handleReducerUpdate(update)
        case .fetched:
            let update = reducer.reduce(state, action: .fetched)
            handleReducerUpdate(update)
        case .requestedNewPage:
            let update = reducer.reduce(state, action: .requestedNewPage)
            handleReducerUpdate(update)
        }
    }

    // MARK: - Reducer
    private func handleReducer(action: RepoListReducerAction) {
        let update = reducer.reduce(state, action: action)
        state = update.state
        handleReducerUpdate(update)
    }

    private func handleReducerUpdate(_ update: RepoListReducerUpdate) {
        switch update.effect {
        case .fetchRepos(page: let page):
            stateRelay.accept(.loading)
            let resource = RepoListInteractorResource(page: page)
            interactor
                .repoList(from: resource)
                .observe(on: scheduler)
                .map { $0 }
                .subscribe(onSuccess: { [weak self] model in
                    self?.handleReducer(action: .reposLoaded(model))
                }, onFailure: { [weak self] _ in
                    self?.stateRelay.accept(.error)
                }).disposed(by: disposeBag)
            
        case .showRepo(let repo):
            delegate?.show(repo: repo)
        case .update:
            let viewModel = makeViewModel()
            stateRelay.accept(.show(viewModel))
        case .none:
            break
        }
    }

    // MARK: - Helpers
    private func makeViewModel() -> ReposTableViewModel {
        return ReposTableViewModel(
            section: ReposTableViewSection(section: 0),
            cells: state.repos.map { [weak self] in
                let userProfile = UserProfileCompactViewModel(
                    username: $0.owner.name,
                    profileImage: LoadableImage(
                        single: self?.interactor.authorProfileImage(from: $0.owner.avatarUrl) ?? Single<UIImage>.just(UIImage()),
                        defaultImage: UIImage(systemName: "person.circle.fill") ?? UIImage()
                    )
                )
                return ReposTableViewCellViewModel(
                    id: $0.id,
                    repoName: $0.name,
                    repoDescription: $0.description,
                    repoAuthor: userProfile,
                    repoStars: "\($0.stars) stars",
                    repoForks: "\($0.forks) forks"
                )
            }
        )
    }
}
