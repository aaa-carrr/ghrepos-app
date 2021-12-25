import UIKit

final class ReposTableViewCellContentView: UIView {
    // MARK: - Properties
    @AutoLayout private var contentStackView: UIStackView
    @AutoLayout private var repoInfoStackView: UIStackView
    
    @AutoLayout private var repoNameDescriptionContentView: UIView
    @AutoLayout private var repoNameLabel: UILabel
    @AutoLayout private var repoDescriptionLabel: UILabel
    
    @AutoLayout private var repoStarsForksStackView: UIStackView
    @AutoLayout private var repoStarsLabel: UILabel
    @AutoLayout private var repoForksLabel: UILabel
    
    @AutoLayout private var repoAuthor: UserProfileCompactView
    
    @AutoLayout private var separatorView: UIView

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Layout
    private func setUp() {
        backgroundColor = .systemBackground
        setUpViews()
        layoutViews()
        layoutConstraints()
    }
    
    private func layoutViews() {
        repoStarsForksStackView.addArrangedSubview(repoStarsLabel)
        repoStarsForksStackView.addArrangedSubview(repoForksLabel)
        
        repoNameDescriptionContentView.addSubview(repoNameLabel)
        repoNameDescriptionContentView.addSubview(repoDescriptionLabel)
        
        repoInfoStackView.addArrangedSubview(repoNameDescriptionContentView)
        repoInfoStackView.addArrangedSubview(repoStarsForksStackView)
        
        contentStackView.addArrangedSubview(repoInfoStackView)
        contentStackView.addArrangedSubview(repoAuthor)
        
        addSubview(contentStackView)
        addSubview(separatorView)
    }
    
    // MARK: - View Configuration
    private func setUpViews() {
        setUpContentStackView()
        setUpRepoInfoStackView()
        setUpRepoStarsForksStackView()
        setUpRepoNameLabel()
        setUpRepoDescriptionLabel()
        setUpRepoStarsLabel()
        setUpRepoForksLabel()
        setUpSeparatorView()
    }
    
    private func setUpContentStackView() {
        contentStackView.axis = .horizontal
        contentStackView.distribution = .fill
        contentStackView.alignment = .fill
        contentStackView.spacing = 12
    }
    
    private func setUpRepoInfoStackView() {
        repoInfoStackView.axis = .vertical
        repoInfoStackView.distribution = .fill
        repoInfoStackView.alignment = .fill
        repoInfoStackView.spacing = 4
    }
    
    private func setUpRepoStarsForksStackView() {
        repoStarsForksStackView.axis = .horizontal
        repoStarsForksStackView.distribution = .fill
        repoStarsForksStackView.alignment = .fill
        repoStarsForksStackView.spacing = 20
    }
    
    private func setUpRepoNameLabel() {
        repoNameLabel.textColor = .label
        repoNameLabel.font = .preferredFont(forTextStyle: .headline)
        repoNameLabel.numberOfLines = 2
    }
    
    private func setUpRepoDescriptionLabel() {
        repoDescriptionLabel.textColor = .secondaryLabel
        repoDescriptionLabel.font = .preferredFont(forTextStyle: .body)
        repoDescriptionLabel.numberOfLines = 4
    }
    
    private func setUpRepoStarsLabel() {
        repoStarsLabel.textColor = .label
        repoStarsLabel.font = .preferredFont(forTextStyle: .headline)
    }
    
    private func setUpRepoForksLabel() {
        repoForksLabel.textColor = .label
        repoForksLabel.font = .preferredFont(forTextStyle: .headline)
    }
    
    private func setUpSeparatorView() {
        separatorView.backgroundColor = .label
    }
    
    // MARK: - Constraints
    private func layoutConstraints() {
        NSLayoutConstraint.activate(
            [
                contentStackView.topAnchor.constraint(equalTo: topAnchor),
                contentStackView.widthAnchor.constraint(equalTo: widthAnchor),
                contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
                contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                separatorView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
                separatorView.widthAnchor.constraint(equalTo: widthAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: 2)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                repoAuthor.heightAnchor.constraint(equalToConstant: 100),
                repoAuthor.widthAnchor.constraint(equalToConstant: 80)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                repoNameLabel.topAnchor.constraint(equalTo: repoNameDescriptionContentView.topAnchor),
                repoNameLabel.leadingAnchor.constraint(equalTo: repoNameDescriptionContentView.leadingAnchor),
                repoNameLabel.trailingAnchor.constraint(equalTo: repoNameDescriptionContentView.trailingAnchor),
                repoNameLabel.heightAnchor.constraint(equalToConstant: 20)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                repoDescriptionLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 4),
                repoDescriptionLabel.leadingAnchor.constraint(equalTo: repoNameDescriptionContentView.leadingAnchor),
                repoDescriptionLabel.trailingAnchor.constraint(equalTo: repoNameDescriptionContentView.trailingAnchor),
                repoDescriptionLabel.heightAnchor.constraint(equalToConstant: 44)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                repoNameDescriptionContentView.heightAnchor.constraint(equalToConstant: 64)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                repoInfoStackView.heightAnchor.constraint(equalToConstant: 100)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                repoStarsLabel.heightAnchor.constraint(equalToConstant: 20)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                repoForksLabel.heightAnchor.constraint(equalToConstant: 20)
            ]
        )
    }
    
    // MARK: - API
    func update(with viewModel: ReposTableViewCellViewModel) {
        repoNameLabel.text = viewModel.repoName
        repoDescriptionLabel.text = viewModel.repoDescription
        repoAuthor.update(with: viewModel.repoAuthor)
        repoStarsLabel.text = viewModel.repoStars
        repoForksLabel.text = viewModel.repoForks
    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI
import RxSwift

struct ReposTableViewCellContentViewRepresentable: UIViewRepresentable {
    typealias UIViewType = ReposTableViewCellContentView
    func makeUIView(context: Context) -> ReposTableViewCellContentView {
        let view = ReposTableViewCellContentView()
        
        let loadableImage = LoadableImage(
            single: Single<UIImage>.create { single in
                single(
                    .success(
                        UIImage(systemName: "person.circle.fill") ?? UIImage()
                    )
                )
                return Disposables.create { }
            },
            defaultImage: UIImage()
        )
        
        let repoAuthor = UserProfileCompactViewModel(
            username: "aaa-carrr",
            profileImage: loadableImage
        )
        
        let viewModel = ReposTableViewCellViewModel(
            id: 1,
            repoName: "Repository",
            repoDescription: "Repo description with some text to describe what it does. Repo description with some text to describe what it does. Repo description with some text to describe what it does. Repo description with some text to describe what it does",
            repoAuthor: repoAuthor,
            repoStars: "34 stars",
            repoForks: "6 forks"
        )
        
        view.update(with: viewModel)
        return view
    }
    
    func updateUIView(_ uiView: ReposTableViewCellContentView, context: Context) {
    }
}

struct ReposTableViewCellPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            ReposTableViewCellContentViewRepresentable()
                .frame(height: 100, alignment: .center)
            ReposTableViewCellContentViewRepresentable()
                .frame(height: 100, alignment: .center)
            ReposTableViewCellContentViewRepresentable()
                .frame(height: 100, alignment: .center)
            ReposTableViewCellContentViewRepresentable()
                .frame(height: 100, alignment: .center)
            ReposTableViewCellContentViewRepresentable()
                .frame(height: 100, alignment: .center)
            ReposTableViewCellContentViewRepresentable()
                .frame(height: 100, alignment: .center)
        }.environment(\.colorScheme, .light)
    }
}
#endif
