//
//  AlbumViewController.swift
//  SimpleAlbum
//
//  Created by Chris on 2022/2/16.
//

import UIKit

class AlbumViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let albumViewModel = AlbumViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindAlbumViewModel()
    }
    
    func bindAlbumViewModel() {
        albumViewModel.getUsers()
        albumViewModel.getAlbums()
        albumViewModel.getPhotos()
        albumViewModel.onUsersRequestEnd = { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }

}
