//
//  APIService.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 13/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import Moya


enum APIService {
    case GetStations
    case GetLastData
    case GetEws07
    case GetCountStatus
    case GetWarnData
    case GetWarnReport
    case GetInfo
}

extension APIService: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        return URL(string: "\(baseURL)")!
    }
    
    var path: String {
        switch self {
        case .GetStations:
            return "/station.xml"
        case .GetLastData:
            return "/lastdata.xml"
        case .GetEws07:
            return "/ews07.xml"
        case .GetCountStatus:
            return "/count_status_vill.xml"
        case .GetWarnData:
            return "/warn.xml"
        case .GetWarnReport:
            return "/warn_report.xml"
        case .GetInfo:
            return "/info.xml"
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
