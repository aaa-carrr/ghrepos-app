import UIKit
import RxSwift
import RxCocoa

public final class UserProfileCompactView: UIView {
    // MARK: - Properties
    @AutoLayout private var profileImageView: LoadableImageView
    @AutoLayout private var usernameLabel: UILabel
    @AutoLayout private var stackView: UIStackView
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setUp() {
        setUpViews()
        layoutViews()
        layoutConstraints()
    }
    
    private func setUpViews() {
        setUpStackView()
        setUpUsername()
        setUpProfileImage()
    }
    
    private func setUpStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
    }
    
    private func setUpUsername() {
        usernameLabel.textColor = .label
        usernameLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.minimumScaleFactor = 0.75
        usernameLabel.numberOfLines = 2
    }
    
    private func setUpProfileImage() {
        profileImageView.tintColor = .systemGray
    }
    
    private func layoutViews() {
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(usernameLabel)
        addSubview(stackView)
    }
    
    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    // MARK: - API
    func update(with viewModel: UserProfileCompactViewModel) {
        usernameLabel.text = viewModel.username
        profileImageView.setUp(with: viewModel.profileImage)
    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI
struct UserProfileCompactViewRepresentable: UIViewRepresentable {
    typealias UIViewType = UserProfileCompactView
    func makeUIView(context: Context) -> UserProfileCompactView {
        let view = UserProfileCompactView()
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
        let viewModel = UserProfileCompactViewModel(
            username: "Username",
            profileImage: loadableImage
        )
        view.update(with: viewModel)
        return view
    }
    
    func updateUIView(_ uiView: UserProfileCompactView, context: Context) {
    }
}

struct UserProfileCompactViewPreview: PreviewProvider {
    static var previews: some View {
        UserProfileCompactViewRepresentable()
            .frame(width: 80, height: 80, alignment: .center)
    }
}
#endif
