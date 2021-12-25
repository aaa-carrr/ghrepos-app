import UIKit
import RxSwift

final class ReposTableViewDiffableDataSource: UITableViewDiffableDataSource<ReposTableViewSection, ReposTableViewCellViewModel> {
    private let bindable: Observable<ReposTableViewModel>
    private let tableView: ReposTableView
    private let scheduler: MainScheduler
    private var disposeBag: DisposeBag = DisposeBag()
    
    init(
        tableView: ReposTableView,
        bindable: Observable<ReposTableViewModel>,
        scheduler: MainScheduler = MainScheduler.instance
    ) {
        self.tableView = tableView
        self.bindable = bindable
        self.scheduler = scheduler
        super.init(
            tableView: tableView
        ) { tableView, indexPath, viewModel in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReposTableViewCell.identifier,
                for: indexPath
            ) as? ReposTableViewCell else {
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
                    var snapshot = NSDiffableDataSourceSnapshot<ReposTableViewSection, ReposTableViewCellViewModel>()
                    snapshot.appendSections([viewModel.section])
                    snapshot.appendItems(viewModel.cells, toSection: viewModel.section)
                    self?.apply(snapshot, animatingDifferences: true)
                }
            }.disposed(by: disposeBag)
    }
}
