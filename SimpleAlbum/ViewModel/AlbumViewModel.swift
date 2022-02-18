//
//  AlbumViewModel.swift
//  SimpleAlbum
//
//  Created by Chris on 2022/2/16.
//

import UIKit
import SwiftyJSON

class AlbumViewModel {
    // models
    var userModels: [UserModel] = []
    var albumsModels: [AlbumModel] = []
    var photoModels: [PhotoModel] = []
    var selectedAlbums : [AlbumModel] = []
    var selectedPhotos : [PhotoModel] = []

    // on completion outputs
    var onUsersRequestEnd: (() -> Void)?
    
    func getUsers() {
        AlbumAPI.getUsers { [weak self](json, error) in
            for user in json.arrayValue{
                let userModel = UserModel.init(userID: user["id"].stringValue, userName: user["username"].stringValue)
                self?.userModels.append(userModel)
            }
            self?.onUsersRequestEnd?()
        }
    }
    
    func getAlbums() {
        AlbumAPI.getAlbums { [weak self](json, error) in
            for album in json.arrayValue{
                let albumsModel = AlbumModel.init(albumID: album["id"].stringValue, albumTitle: album["title"].stringValue, userId: album["userId"].stringValue, photoThumbnailUrl: "")
                self?.albumsModels.append(albumsModel)
            }
        }
    }
    
    func getPhotos() {
        AlbumAPI.getPhotos { [weak self](json, error) in
            for photo in json.arrayValue{
                let photoModel = PhotoModel.init(albumID: photo["albumId"].stringValue, photoId: photo["id"].stringValue, photoUrl: photo["url"].stringValue, photoThumbnailUrl: photo["thumbnailUrl"].stringValue)
                self?.photoModels.append(photoModel)
            }
        }
    }
    
    func getUserAlbums(user:UserModel) {
        selectedAlbums = albumsModels.filter({$0.userId == user.userID})
        for i in 0...selectedAlbums.count - 1 {
            let selectedPhotos = photoModels.filter({$0.albumID == selectedAlbums[i].albumID})
            if selectedPhotos.count > 0 {
                selectedAlbums[i].photoThumbnailUrl = selectedPhotos[0].photoThumbnailUrl
            }
        }
    }
    
    func getSelectedPhotos(album: AlbumModel) {
        selectedPhotos = photoModels.filter({$0.albumID == album.albumID})
    }
}
