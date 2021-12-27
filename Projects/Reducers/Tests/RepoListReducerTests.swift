import XCTest
import Models
@testable import Reducers

final class RepoListReducerTests: XCTestCase {
    func testRepoListReducer_for_fetchedAction() {
        let sut = RepoListReducer()
        let state = RepoListStateModel(
            currentPage: 1,
            lastFetchedPage: 0,
            isFetching: false,
            numberOfPages: 0,
            repos: []
        )

        let update = sut.reduce(
            state,
            action: .fetched
        )

        XCTAssertEqual(state, update.state)
        XCTAssertEqual(RepoListReducerEffect.fetchRepos(page: 1), update.effect)
    }

    func testRepoListReducer_for_requestedNewPage() {
        let sut = RepoListReducer()
        let state = RepoListStateModel(
            currentPage: 1,
            lastFetchedPage: 1,
            isFetching: false,
            numberOfPages: 3,
            repos: []
        )

        let update = sut.reduce(
            state,
            action: .requestedNewPage
        )

        XCTAssertEqual(state, update.state)
        XCTAssertEqual(RepoListReducerEffect.fetchRepos(page: 1), update.effect)
    }

    func testRepoListReducer_for_tappedRepo() {
        let sut = RepoListReducer()
        let repo = RepoStateModel(
            id: 0,
            name: "",
            description: "",
            owner: RepoStateModel.OwnerStateModel(
                name: "",
                avatarUrl: ""
            ),
            stars: 0,
            forks: 0
        )

        let state = RepoListStateModel(
            currentPage: 1,
            lastFetchedPage: 1,
            isFetching: false,
            numberOfPages: 3,
            repos: [repo]
        )

        let update = sut.reduce(
            state,
            action: .tappedRepo(atIndex: 0)
        )

        XCTAssertEqual(state, update.state)
        XCTAssertEqual(RepoListReducerEffect.showRepo(repo), update.effect)
    }

    func testRepoListReducer_for_reposLoaded() {
        let sut = RepoListReducer()
        let repo = RepoStateModel(
            id: 0,
            name: "",
            description: "",
            owner: RepoStateModel.OwnerStateModel(
                name: "",
                avatarUrl: ""
            ),
            stars: 0,
            forks: 0
        )

        let state = RepoListStateModel(
            currentPage: 1,
            lastFetchedPage: 1,
            isFetching: false,
            numberOfPages: 3,
            repos: []
        )

        let newState = RepoListStateModel(
            currentPage: 2,
            lastFetchedPage: 1,
            isFetching: false,
            numberOfPages: 3,
            repos: [repo]
        )

        let loadedRepos = RepoList(
            totalCount: 90,
            items: [
                RepoList.Repo(
                    id: 0,
                    name: "",
                    owner: RepoList.Repo.RepoOwner(
                        login: "",
                        avatarUrl: ""
                    ),
                    description: "",
                    stargazersCount: 0,
                    forks: 0
                )
            ]
        )

        let update = sut.reduce(
            state,
            action: .reposLoaded(loadedRepos)
        )

        XCTAssertEqual(newState, update.state)
        XCTAssertEqual(RepoListReducerEffect.update, update.effect)
    }
}
