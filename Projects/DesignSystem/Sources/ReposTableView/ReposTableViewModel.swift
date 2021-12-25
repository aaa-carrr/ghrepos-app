import Foundation

public struct ReposTableViewModel {
    public let section: ReposTableViewSection
    public let cells: [ReposTableViewCellViewModel]
    
    public init(
        section: ReposTableViewSection,
        cells: [ReposTableViewCellViewModel]
    ) {
        self.section = section
        self.cells = cells
    }
}
