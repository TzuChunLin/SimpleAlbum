//
//  PhotosViewController.swift
//  SimpleAlbum
//
//  Created by Chris on 2022/2/18.
//

import UIKit

class PhotosViewController: UIViewController {
    var photoModels: [PhotoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idPhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.thumbnailImageView.kf.setImage(with: URL(string: photoModels[indexPath.row].photoUrl), placeholder: UIImage(named: ""))
        return cell
    }
}
