import UIKit
import RxSwift
import RxCocoa

public final class ReposViewController: StatefulViewController {
    // MARK: - Properties
    private let repoListView: ReposTableView
    private let scheduler: SchedulerType
    private let state: Observable<ReposViewControllerState>
    private let viewModelsRelay: PublishRelay<ReposTableViewModel> = PublishRelay<ReposTableViewModel>()
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Init
    public init(
        repoListView: ReposTableView,
        state: Observable<ReposViewControllerState>,
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
                self?.onAction?(.tappedRepo(atIndex: index))
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
                self?.onAction?(.requestedNewPage(atIndices: indices))
            }).disposed(by: disposeBag)
    }
    
    // MARK: - API
    public var onAction: ((ReposViewControllerAction) -> Void)?
}
