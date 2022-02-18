//
//  UserTableViewCell.swift
//  SimpleAlbum
//
//  Created by Chris on 2022/2/16.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userCollectionView: UICollectionView!

    var userModels: [UserModel] = []
    var onUserSelected: ((_ user:UserModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUsers(users:[UserModel]) {
        self.userModels = users
        userCollectionView.reloadData()
    }
}

extension UserTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 100, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idUserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        cell.userNameLabel.text = userModels[indexPath.row].userName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = userModels[indexPath.row]
        onUserSelected?(user)
    }
}
