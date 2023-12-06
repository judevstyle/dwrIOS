//
//  DashBoardModel.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/5/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
public struct DashBoardModel: Codable, Hashable {
    
    public var type1: DashBoard?
    public var type2: DashBoard?
    public var type3: DashBoard?
    public var type9: DashBoard?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case type1 = "type1"
        case type2 = "type2"
        case type3 = "type3"
        case type9 = "type9"

    }
}

public struct DashBoard: Codable, Hashable {
    
    public var count_station: Int?
    public var count_bann: Int?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case count_station = "count_station"
        case count_bann = "count_bann"

    }
}
