//
//  HomeView.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 26/05/21.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    
}

final class HomeView: UIView {
    
    private let identifier = String(describing: PhotoTableViewCell.self)
    
    private var photosModel: [PhotosModel]? { didSet { photosGalleryTable.reloadData() } }
    
    private let cellSpacing: CGFloat = .size(.nano)
    private let cellConstantHeight = CGFloat(150.0)
    
    var homeCoordinator: HomeCoordinator?
    
    private lazy var header: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .darkGray
        titleLabel.textColor = .white
        titleLabel.text = "UnsplashGallery"
        titleLabel.textAlignment = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var photosGalleryTable: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = cellSpacing
        flowLayout.minimumInteritemSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        
        collectionView.contentInset = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoTableViewCell.self, forCellWithReuseIdentifier: identifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setUpConstraints() {
        setupHeaderConstraint()
        setupPhotoGalleryConstraint()
    }
    
    private func setupHeaderConstraint() {
        addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            header.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            header.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            header.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
    }
    
    private func setupPhotoGalleryConstraint() {
        addSubview(photosGalleryTable)
        NSLayoutConstraint.activate([
            photosGalleryTable.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 0),
            photosGalleryTable.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            photosGalleryTable.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            photosGalleryTable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            photosGalleryTable.heightAnchor.constraint(greaterThanOrEqualToConstant: 96)
        ])
    }
    
    func updatePhotoGallery(photosModel: [PhotosModel]) {
        self.photosModel = photosModel
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.photosModel?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photosModel = photosModel?[indexPath.row] else { return UICollectionViewCell() }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? PhotoTableViewCell else { return UICollectionViewCell() }
        
        cell.model = PhotoTableViewCell.Model(
            id: photosModel.id ,
            name: photosModel.title,
            author: photosModel.author,
            imageUrl: photosModel.url
        )
        
        return cell
    }
}

extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photosModel = photosModel?[indexPath.row] else { return }
        
        homeCoordinator?.showDetails(photosModel)
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tableContentInset = CGFloat(8.0)
        let cellWidth = (self.frame.width - cellSpacing - tableContentInset) / 2
        return CGSize(width: cellWidth, height: cellConstantHeight)
    }
}
