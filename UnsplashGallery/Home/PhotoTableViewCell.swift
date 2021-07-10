//
//  PhotoTableViewCell.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 29/05/21.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UICollectionViewCell {
    
    struct Model {
        var id: String
        var name: String
        var author: String
        var imageUrl: String
    }
    
    var model: Model? {
        didSet {
            nameLabel.text = model?.name
            
            guard let photoUrl = model?.imageUrl else { return }
            guard let url = URL(string: photoUrl) else { return }
            
            imageView.setAsyncImage(from: url)
        }
    }
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = false
        label.isAccessibilityElement = false
        
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.backgroundColor = UIColor(cgColor: CGColor(red: .zero, green: .zero, blue: .zero, alpha: 0.25))
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.removeFromSuperview()
        nameLabel.text = String()
    }
    
    private func setupConstraint() {
        backgroundColor = .lightGray
        
        setupContainerConstraints()
        setupImageConstraints()
        setupLabelConstraints()
    }
    
    private func setupContainerConstraints() {
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            container.leftAnchor.constraint(equalTo: leftAnchor, constant: .zero),
            container.rightAnchor.constraint(equalTo: rightAnchor, constant: .zero),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero)
        ])
    }
    
    private func setupLabelConstraints() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: .zero),
            nameLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: .zero),
            nameLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: .zero)
        ])
    }
    
    private func setupImageConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: .zero),
            imageView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: .zero),
            imageView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: .zero),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: .zero)
        ])
    }
}
