//
//  MainVCCell.swift
//  CodeaddictTask
//
//  Created by Mateusz Zacharski on 14/01/2021.
//

import UIKit

class MainVCCell: UICollectionViewCell {
    
    static let reuseID = "MainVCCell"
    var imageTask: URLSessionDataTask?

    
    let avatarImageView = CTAvatarImageView(cornerRadius: .smooth)
    let repoTitleLabel = CTTitleLabel(textAlignment: .left, fontSize: 17, weight: .semibold)
    let starImageView = CTSmallImageView(image: .star)
    let starCountLabel = CTBodyLabel(textAlignment: .left)
    let forwardImageView = CTSmallImageView(image: .forward)
        
    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(repo: Repo) {
        imageTask = NetworkManager.shared.downloadImageTask(from: repo.owner.avatarUrl, completed: { (image) in
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        })
        imageTask?.resume()

        repoTitleLabel.text = repo.name
        starCountLabel.text = "\(repo.stargazersCount)"
    }
    
    private func configure() {
        addSubviews(avatarImageView, repoTitleLabel, starImageView, starCountLabel, forwardImageView)
        layer.cornerRadius = 13
        backgroundColor = .systemGray6
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            starImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            starImageView.heightAnchor.constraint(equalToConstant: 14),
            starImageView.widthAnchor.constraint(equalToConstant: 14),
            starImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -26),
            
            starCountLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            starCountLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4),
            starCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -44),
            starCountLabel.heightAnchor.constraint(equalToConstant: 22),
            
            repoTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            repoTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -44),
            repoTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            repoTitleLabel.bottomAnchor.constraint(equalTo: starCountLabel.topAnchor),
            
            forwardImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            forwardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            forwardImageView.heightAnchor.constraint(equalToConstant: 13),
            forwardImageView.widthAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.15, delay: 0, options: .allowUserInteraction, animations: {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.transform = .identity
            }
        })
    }
    
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        avatarImageView.image = Images.placeholder
    }
}
