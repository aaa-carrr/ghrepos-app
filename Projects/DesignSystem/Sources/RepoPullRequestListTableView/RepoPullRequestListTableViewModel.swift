import Foundation

public struct RepoPullRequestListTableViewModel {
    public let section: RepoPullRequestListTableViewSection
    public let cells: [RepoPullRequestListTableViewCellViewModel]

    public init(
        section: RepoPullRequestListTableViewSection,
        cells: [RepoPullRequestListTableViewCellViewModel]
    ) {
        self.section = section
        self.cells = cells
    }
}

