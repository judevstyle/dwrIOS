//
//  RegionResponse.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/5/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
struct RegionModel: Decodable {
    var name: String?
    var full_name: String?
    var provinces: [String]?

    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case full_name = "full_name"
        case provinces = "provinces"

    }
}

