import XCTest
import Models
@testable import Reducers

final class RepoPullRequestListReducerTests: XCTestCase {
    func testRepoPullRequestListReducer_for_fetched() {
        let sut = RepoPullRequestListReducer()
        let state = RepoPullRequestListStateModel(
            repoAuthor: "",
            repoName: "",
            currentPage: 0,
            canFetchNewPage: true,
            pullRequests: []
        )

        let update = sut.reduce(state, action: .fetched)

        XCTAssertEqual(state, update.state)
        XCTAssertEqual(RepoPullRequestListReducerEffect.showLoading, update.effect)
    }

    func testRepoPullRequestListReducer_for_requestedNewPage() {
        let sut = RepoPullRequestListReducer()
        let state = RepoPullRequestListStateModel(
            repoAuthor: "",
            repoName: "",
            currentPage: 0,
            canFetchNewPage: true,
            pullRequests: []
        )

        let update = sut.reduce(state, action: .requestedNewPage)

        XCTAssertEqual(state, update.state)
        XCTAssertEqual(RepoPullRequestListReducerEffect.fetchPullRequest(0), update.effect)
    }

    func testRepoPullRequestListReducer_for_requestedNewPage_butItCantFetch() {
        let sut = RepoPullRequestListReducer()
        let state = RepoPullRequestListStateModel(
            repoAuthor: "",
            repoName: "",
            currentPage: 0,
            canFetchNewPage: false,
            pullRequests: []
        )

        let update = sut.reduce(state, action: .requestedNewPage)

        XCTAssertEqual(state, update.state)
        XCTAssertEqual(RepoPullRequestListReducerEffect.none, update.effect)
    }

    func testRepoPullRequestListReducer_for_tappedPullRequest() {
        let sut = RepoPullRequestListReducer()
        let pullReq = RepoPullRequestStateModel(
            id: 0,
            title: "",
            body: "",
            author: RepoPullRequestStateModel.AuthorStateModel(
                name: "",
                avatarUrl: ""
            ),
            url: "",
            dateOfCreation: ""
        )

        let state = RepoPullRequestListStateModel(
            repoAuthor: "",
            repoName: "",
            currentPage: 0,
            canFetchNewPage: true,
            pullRequests: [pullReq]
        )

        let update = sut.reduce(state, action: .tappedPullRequest(atIndex: 0))

        XCTAssertEqual(state, update.state)
        XCTAssertEqual(
            RepoPullRequestListReducerEffect.showPullRequest(pullReq),
            update.effect
        )
    }

    func testRepoPullRequestListReducer_for_pullRequestsLoaded() {
        let sut = RepoPullRequestListReducer()
        let pullReq = RepoPullRequestStateModel(
            id: 0,
            title: "",
            body: "",
            author: RepoPullRequestStateModel.AuthorStateModel(
                name: "",
                avatarUrl: ""
            ),
            url: "",
            dateOfCreation: ""
        )

        let pr = RepoPullRequest(
            id: 0,
            url: "",
            title: "",
            body: "",
            user: RepoPullRequest.PullRequestAuthor(
                login: "",
                avatarUrl: ""
            ),
            createdAt: ""
        )

        let state = RepoPullRequestListStateModel(
            repoAuthor: "",
            repoName: "",
            currentPage: 0,
            canFetchNewPage: true,
            pullRequests: []
        )

        let update = sut.reduce(
            state,
            action: .pullRequestsLoaded([pr])
        )

        let newState = RepoPullRequestListStateModel(
            repoAuthor: "",
            repoName: "",
            currentPage: 1,
            canFetchNewPage: false,
            pullRequests: [pullReq]
        )

        XCTAssertEqual(newState, update.state)
        XCTAssertEqual(
            RepoPullRequestListReducerEffect.update,
            update.effect
        )
    }
}
