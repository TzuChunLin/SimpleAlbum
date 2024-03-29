//
//  BaseAPI.swift
//  RedShark
//
//  Created by TZU-CHUN LIN on 2021/6/11.
//

import UIKit
import Alamofire
import SwiftyJSON

#if DEBUG
class DebugSessionManager: Alamofire.SessionManager {
    override func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let now = Date()
        print("[\(formatter.string(from: now))] - API: \(url)")
        return super.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}
#endif

class BaseAPI{
    static private(set) var HEADERS: HTTPHeaders = ["cookie": "x-session-token=", "User-Agent": "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion); \(UIDevice.current.modelName)"]
    static private(set) var TIMEOUT: Double = 30
    var vc: UIViewController?
#if DEBUG
    static let sharedSessionManager: DebugSessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["User-Agent": "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion); \(UIDevice.current.modelName)"]
        configuration.timeoutIntervalForRequest = TIMEOUT
        return DebugSessionManager(configuration: configuration)
    }()
#else
    static let sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["User-Agent": "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion); \(UIDevice.current.modelName)"]
        configuration.timeoutIntervalForRequest = TIMEOUT
        return Alamofire.SessionManager(configuration: configuration)
    }()
#endif
    
    class func setRequestToken(token: String){
        if token == ""{
            HEADERS["cookie"] = ""
        }
        else{
            HEADERS["cookie"] = "x-session-token=" + token
        }
        
    }
    
    class func errorHandler(body: JSON, with Url: String = ""){
        //let success = body["success"].boolValue
        let msg = body["msg"].stringValue
        //let info = body["info"].stringValue
        let code = body["code"].intValue
       
    }
    
    class func request( url: String,
                        method: HTTPMethod = .post,
                        parameters: Parameters? = nil,
                        errorHandle: Bool = true,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: HTTPHeaders? = HEADERS,
                        callback: @escaping (JSON, Error?)->())
    {
        sharedSessionManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).response{ response in
            if let e = response.error{
                callback(JSON(e.localizedDescription), e)
            }
            else{
                var body = JSON(response.data ?? Data())
                if body == JSON.null{
                    let utf8Text = String(data: response.data ?? Data(), encoding: .utf8)
                    body = JSON(utf8Text ?? "")
                }
                if( errorHandle &&
                    body["code"].exists() &&
                    body["success"].exists() &&
                    !body["success"].boolValue){
                    /* callback
                     success: Bool
                     code: Int
                     msg: String
                     info: String
                     */
                    errorHandler(body: body, with: url)
                }
                callback(body, nil)
            }
        }
    }
}

class BaseAPI_URL{
    static var DOMAIN = ""
}


extension UIDevice {

    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
            case "iPod5,1":    return "iPod Touch (5 Gen)"
            case "iPod7,1":    return "iPod Touch 6"
            case "iPod9,1":    return "iPod Touch (7 Gen)"

            case "iPhone4,1":                return "iPhone 4s"
            case "iPhone5,1","iPhone5,2":    return "iPhone 5"
            case "iPhone5,3","iPhone5,4":    return "iPhone 5c"
            case "iPhone6,1","iPhone6,2":    return "iPhone 5s"
            case "iPhone7,2":                  return "iPhone 6"
            case "iPhone7,1":                  return "iPhone 6 Plus"
            case "iPhone8,1":                  return "iPhone 6s"
            case "iPhone8,2":                return "iPhone 6s Plus"
            case "iPhone8,4":                return "iPhone SE"
            case "iPhone9,1","iPhone9,3":    return "iPhone 7"
            case "iPhone9,2","iPhone9,4":    return "iPhone 7 Plus"
            case "iPhone10,1","iPhone10,4":    return "iPhone 8"
            case "iPhone10,2","iPhone10,5":    return "iPhone 8 Plus"
            case "iPhone10,3","iPhone10,6":    return "iPhone X"
            case "iPhone11,2":                return "iPhone XS"
            case "iPhone11,4","iPhone11,6":    return "iPhone XS Max"
            case "iPhone11,8":                return "iPhone XS"
            case "iPhone12,1":                return "iPhone 11"
            case "iPhone12,3":                return "iPhone 11 Pro"
            case "iPhone12,5":                return "iPhone 11 Pro Max"

            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":    return "iPad 2"
            case "iPad2,5", "iPad2,6", "iPad2,7":                return "iPad Mini"
            case "iPad3,1", "iPad3,2", "iPad3,3":                return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":                return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":                return "iPad Air"
            case "iPad4,4", "iPad4,5", "iPad4,6":                return "iPad Mini Retina"
            case "iPad4,7", "iPad4,8", "iPad4,9":                return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                            return "iPad Mini 4"
            case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
            case "iPad6,3", "iPad6,4":                            return "iPad Pro 9.7\""
            case "iPad6,7", "iPad6,8":                            return "iPad Pro 12.9\""
            case "iPad6,11", "iPad6,12":                        return "iPad (2017)"
            case "iPad7,1", "iPad7,2":                            return "iPad Pro (2 Gen)"
            case "iPad7,3", "iPad7,4":                            return "iPad Pro 10.5\""
            case "iPad7,5", "iPad7,6":                            return "iPad (6 Gen)"
            case "iPad7,11", "iPad7,12":                        return "iPad (7 Gen) 10.2\""
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":    return "iPad pro (3 Gen) 11\""
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":    return "iPad pro (3 Gen) 12.9\""
            case "iPad11,1", "iPad11,2":                        return "iPad Mini (5 Gen)"
            case "iPad11,3", "iPad11,4":                        return "iPad Air (3 Gen)"
            
            case "i386", "x86_64":    return "Simulator"
            
            default:  return identifier
        }
    }
}
