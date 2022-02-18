//
//  AlbumAPI.swift
//  SimpleAlbum
//
//  Created by Chris on 2022/2/16.
//

import UIKit
import SwiftyJSON
import Alamofire

class AlbumURL: BaseAPI_URL {
    static var getUsersURL: String{ return "https://jsonplaceholder.typicode.com/users"}
    static var getAlbumsURL: String{ return "https://jsonplaceholder.typicode.com/albums"}
    static var getPhotosURL: String{ return "https://jsonplaceholder.typicode.com/photos"}
}

class AlbumAPI: BaseAPI {
    class func getUsers(callback: @escaping (JSON, Error?)->()){
        AlbumAPI.request(url: AlbumURL.getUsersURL, method: .get, errorHandle: false, headers: HEADERS) { json, error in
            callback(json, error)
        }
    }
    
    class func getAlbums(callback: @escaping (JSON, Error?)->()){
        AlbumAPI.request(url: AlbumURL.getAlbumsURL, method: .get, errorHandle: false, headers: HEADERS) { json, error in
            callback(json, error)
        }
    }
    
    class func getPhotos(callback: @escaping (JSON, Error?)->()){
        AlbumAPI.request(url: AlbumURL.getPhotosURL, method: .get, errorHandle: false, headers: HEADERS) { json, error in
            callback(json, error)
        }
    }
}
