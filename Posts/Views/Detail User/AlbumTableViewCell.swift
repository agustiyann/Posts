//
//  AlbumTableViewCell.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import UIKit
import Kingfisher

class AlbumTableViewCell: UITableViewCell {
    
    static let identifier = "AlbumTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AlbumTableViewCell", bundle: nil)
    }
    let viewModel = AlbumViewModel(useCase: DetailUserUseCase())
    
    weak var navController: UINavigationController?

    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .systemBackground
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 120, height: 120)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        collectionView.collectionViewLayout = flowLayout
        collectionView.dataSource = self
        collectionView.delegate = self

        let cellNib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "collectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(album: AlbumModel, navController: UINavigationController) {
        self.navController = navController
        albumTitleLabel.text = album.title
        
        bindViewModel()
        viewModel.didLoadAlbums(albumID: album.id)
    }
    
    private func bindViewModel() {
        viewModel.didReceivePhotos = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.didReceiveErrorPhotos = { message in
            print(message)
        }
    }
    
}

extension AlbumTableViewCell: UICollectionViewDelegate,
                              UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.listPhotos.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? PhotoCollectionViewCell {
            let photo = viewModel.listPhotos[indexPath.row]
            let url = URL(string: photo.thumbnailURL)
            cell.photoImage.kf.setImage(with: url)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailPhotoViewController()
        vc.photo = viewModel.listPhotos[indexPath.row]
        navController?.pushViewController(vc, animated: true)
    }
}
