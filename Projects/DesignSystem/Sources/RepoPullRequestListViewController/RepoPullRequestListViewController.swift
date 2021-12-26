import UIKit
import RxSwift
import RxCocoa

public final class RepoPullRequestListViewController: StatefulViewController {
    // MARK: - Properties
    private let repoListView: RepoPullRequestListTableView
    private let scheduler: SchedulerType
    private let state: Observable<RepoPullRequestListViewControllerState>
    private let viewModelsRelay: PublishRelay<RepoPullRequestListTableViewModel> = PublishRelay<RepoPullRequestListTableViewModel>()
    private var disposeBag: DisposeBag = DisposeBag()

    // MARK: - Init
    public init(
        repoListView: RepoPullRequestListTableView,
        state: Observable<RepoPullRequestListViewControllerState>,
        scheduler: SchedulerType = MainScheduler.instance
    ) {
        self.repoListView = repoListView
        self.state = state
        self.scheduler = scheduler
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    public override func loadView() {
        view = repoListView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpRepoListViewBindings()
        setUpStateBinding()
        onAction?(.fetched)
        title = "Pull Requests"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Bindings
    private func setUpStateBinding() {
        state
            .subscribe(on: scheduler)
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .show(let viewModel):
                    self?.viewModelsRelay.accept(viewModel)
                    self?.dismissFeedback()
                    self?.repoListView.refreshControl?.endRefreshing()
                case .loading:
                    self?.showFeedback(.loading)
                case .error:
                    self?.showFeedback(
                        .error,
                        onAction: { [weak self] in
                            self?.onAction?(.fetched)
                            return .dismiss
                        })
                }
            }).disposed(by: disposeBag)
    }

    private func setUpRepoListViewBindings() {
        repoListView.bind(viewModelsRelay.asObservable())

        repoListView
            .rx
            .itemSelected
            .subscribe(on: scheduler)
            .subscribe(onNext: { [weak self] index in
                self?.onAction?(.tappedPullRequest(atIndex: index))
            }).disposed(by: disposeBag)

        repoListView
            .refreshControl?
            .rx
            .controlEvent(.valueChanged)
            .subscribe(on: scheduler)
            .subscribe(onNext: { [weak self] _ in
                self?.onAction?(.fetched)
            }).disposed(by: disposeBag)

        repoListView
            .rx
            .prefetchRows
            .subscribe(on: scheduler)
            .subscribe(onNext: { [weak self] indices in
                indices.forEach { index in
                    if let numberOfRepos = self?.repoListView.numberOfRows(inSection: 0),
                       index.row >= numberOfRepos - 1 {
                        self?.onAction?(.requestedNewPage)
                    }
                }
            }).disposed(by: disposeBag)
    }

    // MARK: - API
    public var onAction: ((RepoPullRequestListViewControllerAction) -> Void)?
}
