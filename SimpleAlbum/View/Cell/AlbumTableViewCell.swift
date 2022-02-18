//
//  AlbumTableViewCell.swift
//  SimpleAlbum
//
//  Created by Chris on 2022/2/16.
//

import UIKit
import Kingfisher

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    var albumModels: [AlbumModel] = []
    var onAlbumSelected: ((_ album:AlbumModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setAlbums(albums:[AlbumModel]) {
        self.albumModels = albums
        albumCollectionView.reloadData()
    }
    
}

extension AlbumTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idAlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        cell.thumbnailImageView.kf.setImage(with: URL(string: albumModels[indexPath.row].photoThumbnailUrl), placeholder: UIImage(named: ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albumModels[indexPath.row]
        onAlbumSelected?(album)
    }
}
