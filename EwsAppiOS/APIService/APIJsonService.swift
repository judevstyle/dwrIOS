//
//  APIJsonService.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/11/22.
//  Copyright © 2022 ssoft. All rights reserved.
//

import Foundation
import Moya


enum APIJsonService {
    case UploadFile(image: UIImage, fileName: String?)
    case GetTambon(am:String)
    case GetAmphone(pv:String)
    case GetProvince
    case GetRadarService(type:String,radius:Int,lat:Double,lng:Double)
    case CreateNews(stn:String,stn_name:String,tambon:String,amphone:String,province:String,latitude:Double,longitude:Double,text_news:String,pic_news:String)
}

extension APIJsonService: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        return URL(string: "http://ews.dwr.go.th/ews")!
    }
    
    var path: String {
        switch self {
        case .UploadFile:
            return "/upload_file_service.php"
        case .GetTambon:
            return "/api/tambon_data.php"
        case .GetAmphone:
            return "/api/amphoe_data.php"
        case .GetProvince:
            return "/api/province_data.php"
        case .GetRadarService:
            return "/warning_radar_service.php"
        case .CreateNews:
            return "/api/news.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .CreateNews :
            return .post
        case .UploadFile :
            return .post
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .GetAmphone(pv):
            return .requestParameters(
                parameters: [ "province": pv], encoding: URLEncoding.queryString)
        case let .GetTambon(am):
            return .requestParameters(
                parameters: [ "amphoe": am], encoding: URLEncoding.queryString)
        case let .GetRadarService(type, radius, lat, lng):
            return .requestParameters(
                parameters: [ "type": type,"radius":radius,"lat":lat,"lng":lng], encoding: URLEncoding.queryString)
            
        case let .UploadFile(image, fileName):
            let imageData = image.jpegData(compressionQuality: 1.0)
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData!), name: "fileToUpload", fileName: fileName ?? "", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        case let .CreateNews(stn, stn_name, tambon, amphone, province, latitude, longitude, text_news, pic_news):
            var params: [String: Any] = [:]
            params["stn"] = stn
            params["stn_name"] = stn_name
            params["tambon"] = tambon
            params["amphone"] = amphone
            params["province"] = province
            params["latitude"] = latitude
            params["longitude"] = longitude
            params["text_news"] = text_news
            params["pic_news"] = pic_news

           return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
        
    }
    
    var authorizationType: AuthorizationType? {
        return .custom("")
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
