import UIKit
import RxSwift

final class RepoPullRequestListDiffableDataSource: UITableViewDiffableDataSource<RepoPullRequestListTableViewSection, RepoPullRequestListTableViewCellViewModel> {
    private let bindable: Observable<RepoPullRequestListTableViewModel>
    private let tableView: RepoPullRequestListTableView
    private let scheduler: SchedulerType
    private var disposeBag: DisposeBag = DisposeBag()

    init(
        tableView: RepoPullRequestListTableView,
        bindable: Observable<RepoPullRequestListTableViewModel>,
        scheduler: SchedulerType = MainScheduler.instance
    ) {
        self.tableView = tableView
        self.bindable = bindable
        self.scheduler = scheduler
        super.init(
            tableView: tableView
        ) { tableView, indexPath, viewModel in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RepoPullRequestListTableViewCell.identifier,
                for: indexPath
            ) as? RepoPullRequestListTableViewCell else {
                return UITableViewCell()
            }

            cell.update(with: viewModel)
            return cell
        }
        setUp()
    }

    private func setUp() {
        defaultRowAnimation = .fade
        bindable
            .observe(on: scheduler)
            .subscribe { [weak self] event in
                if let viewModel = event.element {
                    var snapshot = NSDiffableDataSourceSnapshot<RepoPullRequestListTableViewSection, RepoPullRequestListTableViewCellViewModel>()
                    snapshot.appendSections([viewModel.section])
                    snapshot.appendItems(viewModel.cells, toSection: viewModel.section)
                    self?.apply(snapshot, animatingDifferences: true)
                }
            }.disposed(by: disposeBag)
    }
}
