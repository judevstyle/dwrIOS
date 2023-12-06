//
//  StationWarningResponse.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/5/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
struct StationWarningResponse: Decodable {
    var warning_station: Int?
    var data: [WarningStation]?

    
    enum CodingKeys: String, CodingKey {
        case warning_station = "warning_station"
        case data = "data"

    }
}

