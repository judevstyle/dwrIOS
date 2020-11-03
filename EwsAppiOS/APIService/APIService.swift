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
}

extension APIService: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
//        print(baseURL)
        return URL(string: "\(baseURL)")!
    }
    
    var path: String {
        switch self {
        case .GetStations:
            return "/station.xml"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .GetStations:
            return .get
        default:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .GetStations:
            return .requestPlain
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
