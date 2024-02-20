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
    case GetStation(tm:String)

    case GetProvince
    
    case GetDashboard
    case GetWarningStation(request:[String:String])
    case GetDepart
    case GetRegion
    case GetReport

    case GetWarningStationMap(request:[String:String])
    case GetWarningStationType(request:[String:String])
    case GetSearchStation(request:[String:String])

    case GetRadarService(type:String,radius:Int,lat:Double,lng:Double)
    case CreateNews(stn:String,stn_name:String,tambon:String,amphone:String,province:String,latitude:Double,longitude:Double,text_news:String,pic_news:String)
}

extension APIJsonService: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        return URL(string: "https://ews.dwr.go.th/ews")!
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
            return "/api/warning_radar_service.php"
        case .CreateNews:
            return "/api/news.php"
        case .GetDashboard:
            return "/api/dashbord.php"
        case .GetWarningStation:
            return "/api/warning.php"
        case .GetReport:
            return "/api/warning_reportv1.php"
        case .GetDepart:
            return "/api/depart_data.php"
        case .GetRegion:
            return "/api/region_data.php"
        case .GetWarningStationType:
            return "/api/warning_station_type.php"

        case .GetWarningStationMap:
            return "/api/warning_map_data.php"
            
        case .GetSearchStation:
            return "/api/autocomplete_station.php"

        case .GetStation:
            return "/api/station_data.php"

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
        case let .GetStation(tm):
            return .requestParameters(
                parameters: [ "tambon": tm], encoding: URLEncoding.queryString)
        case let .GetRadarService(type, radius, lat, lng):
            return .requestParameters(
                parameters: [ "type": type,"radius":radius,"lat":lat,"lng":lng], encoding: URLEncoding.queryString)
            
        case let .GetWarningStation(request):
            return .requestParameters(
                parameters: request, encoding: URLEncoding.queryString)
        case let .GetWarningStationMap(request):
            return .requestParameters(
                parameters: request, encoding: URLEncoding.queryString)
            
        case let .GetWarningStationType(request):
            return .requestParameters(
                parameters: request, encoding: URLEncoding.queryString)
            
        case let .GetSearchStation(request):
            return .requestParameters(
                parameters: request, encoding: URLEncoding.queryString)
            
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
           return .requestParameters(parameters: params, encoding:  URLEncoding.httpBody)
//            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)

        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        
        
        switch self {
        case let .CreateNews:
            return ["Content-type": "application/x-www-form-urlencoded"]
        default:
            return ["Content-type": "application/json"]
        }
        

        
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
