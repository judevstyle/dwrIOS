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
    case UploadFile
    case GetTambon
    case GetAmphone
    case GetProvince
    case GetRadarService(type:String,radius:Int,lat:Double,lng:Double)
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .GetRadarService(type, radius, lat, lng):
            return .requestParameters(
                parameters: [ "type": type,"radius":radius,"lat":lat,"lng":lng], encoding: URLEncoding.queryString)
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
