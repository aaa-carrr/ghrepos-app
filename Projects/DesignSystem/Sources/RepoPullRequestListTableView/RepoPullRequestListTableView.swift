import UIKit
import RxSwift
import RxCocoa

public final class RepoPullRequestListTableView: UITableView {
    // MARK: - Properties
    private var disposeBag: DisposeBag = DisposeBag()
    private let scheduler: SchedulerType

    private var diffableDataSource: RepoPullRequestListDiffableDataSource?

    // MARK: - Init
    public init(scheduler: SchedulerType = MainScheduler.instance) {
        self.scheduler = scheduler
        super.init(frame: .zero, style: .grouped)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Configuration
    private func setUp() {
        register(
            RepoPullRequestListTableViewCell.self,
            forCellReuseIdentifier: RepoPullRequestListTableViewCell.identifier
        )

        backgroundColor = .systemBackground
        refreshControl = UIRefreshControl()
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 130
    }

    // MARK: - API
    public func bind(_ viewModel: Observable<RepoPullRequestListTableViewModel>) {
        diffableDataSource = RepoPullRequestListDiffableDataSource(
            tableView: self,
            bindable: viewModel,
            scheduler: scheduler
        )

        dataSource = diffableDataSource
    }
}
