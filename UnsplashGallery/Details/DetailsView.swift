//
//  DetailsView.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 06/07/21.
//

import UIKit

final class DetailsView: UIView {
    
    private var model: PhotosModel? { didSet { configureViews() } }
    
    private var liked: Bool = false
    
    private let unlikedImage = UIImage(named:"unselected_favorite.png")
    private let likedImage = UIImage(named:"selected_favorite.png")
    
    private let likeButtonWidth = CGFloat(50)
    private let likeButtonHeight = CGFloat(50)
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: likeButtonWidth, height: likeButtonHeight)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.setImage(unlikedImage, for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(thumbsUpButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    @objc func thumbsUpButtonPressed() {
        if (liked) {
            likeButton.setImage(unlikedImage, for: .normal)
        } else {
            likeButton.setImage(likedImage, for: .normal)
        }
        
        liked.toggle()
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = false
        label.isAccessibilityElement = true
        
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = false
        label.isAccessibilityElement = true
        
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12.0)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        setupImageConstraint()
        setupTitleLabel()
        setupAuthorLabel()
        setupLikeButtonConstraint()
    }
    
    private func setupLikeButtonConstraint() {
        addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            likeButton.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: .zero),
//            likeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -.size(.small))
            likeButton.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: .size(.extraSmall)),
            likeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: .size(.small)),
            likeButton.heightAnchor.constraint(equalToConstant: likeButtonHeight),
            likeButton.widthAnchor.constraint(equalToConstant: likeButtonWidth)
        ])
    }
    
    private func setupImageConstraint() {
        addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .zero),
            photoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: .zero),
            photoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: .zero),
            photoImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: .size(.small)),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: .size(.small)),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -.size(.small))
        ])
    }
    
    private func setupAuthorLabel() {
        addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .size(.extraSmall)),
            authorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: .size(.small))
        ])
    }
    
    private func configureViews() {
        guard let photo = model else { return }
        
        guard let url = URL(string: photo.url) else { return }
        photoImageView.setAsyncImage(from: url)
        
        titleLabel.text = photo.title
        authorLabel.text = photo.author
    }
    
    func showImages(model: PhotosModel) {
        self.model = model
        
        guard let url = URL(string: model.url) else { return }
        photoImageView.setAsyncImage(from: url)
        
        titleLabel.text = model.title
        authorLabel.text = model.author
    }
}
