//
//  GetDistricRequest.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 9/3/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
public struct GetDistricRequest: Codable, Hashable {
    
    public var amphoe: String?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case amphoe = "amphoe"
    }
}
