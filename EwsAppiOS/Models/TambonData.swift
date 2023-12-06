//
//  TambonData.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 9/3/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation

struct TambonData: Decodable {
    var name: String?
    var stn: String?
    var tambon: String?
    var tambon_e: String?
    var latitude: String?
    var longitude: String?

    var stn_name: String?

    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case stn = "stn"
        case stn_name = "stn_name"

        case tambon = "tambon"
        case tambon_e = "tambon_e"
        case latitude = "latitude"
        case longitude = "longitude"

    }
}

