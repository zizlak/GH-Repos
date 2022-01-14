//
//  RepoCell.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import UIKit

class RepoCell: UITableViewCell {
    
    //MARK: - Interface
    
    let avatarView = UIImageView()
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    
    //MARK: - Properties
    
    static let reuseID = String(describing: RepoCell.self)
    private let padding = Constants.standartPadding
    private let imageSize = Constants.cellImageWidth
    
    var viewModel: RepoCellViewModelProtocol? {
        didSet { configureUI() }
    }
    
    
    //MARK: - LifeCycle Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupAvatarView()
        setupNameLabel()
        setupDescriptionLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.image = Constants.defaultAvatar
    }
    
    
    //MARK: - Methods
    
    private func setupCell() {
        self.backgroundColor = Colors.backGround
    }
    
    private func setupAvatarView() {
        addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.layer.cornerRadius = Constants.cellImageWidth / 4
        avatarView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: padding),
            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarView.widthAnchor.constraint(equalToConstant: imageSize),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
        ])
        avatarView.image = Constants.defaultAvatar
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        nameLabel.textColor = Colors.tint
        nameLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = Colors.text
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: padding),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -padding)
        ])
    }
    
    //MARK: - configureUI
    private func configureUI() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        
        viewModel.avatar.bind { [weak self] image in
            self?.avatarView.image = image
        }
    }
}
