//
//  Extension+AlbumViewController.swift
//  SimpleAlbum
//
//  Created by Chris on 2022/2/18.
//

import UIKit

extension AlbumViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0 {
            return 100
        }else{
            let height = UIScreen.main.bounds.size.height - 120 - 44
            return CGFloat(height)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "idUserTableViewCell") as? UserTableViewCell else {
                return UITableViewCell()
            }
            cell.setUsers(users: albumViewModel.userModels)
            cell.onUserSelected = { [weak self] user in
                self?.albumViewModel.getUserAlbums(user: user)
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "idAlbumTableViewCell") as? AlbumTableViewCell else {
                return UITableViewCell()
            }
            cell.setAlbums(albums: albumViewModel.selectedAlbums)
            cell.onAlbumSelected = {[weak self] album in
                self?.albumViewModel.getSelectedPhotos(album: album)
                guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idPhotosVC") as? PhotosViewController else{
                    return
                }
                vc.photoModels = self?.albumViewModel.selectedPhotos ?? []
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
    }
}
