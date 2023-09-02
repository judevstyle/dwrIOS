//
//  SelectionModel.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 9/2/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
public struct SelectionModel: Codable, Hashable {
    public var id: Int?
    public var name: String?
    public var value: Int?
    public var landmapId: String?
    public var valueString: String?
    public var tm:String?
    public var lat:Double?
    public var lng:Double?
    public var stn:String?
    public var stn_name:String?

    public init(id: Int?,
                name: String?,
                value: Int? = nil,
                landmapId: String? = nil,
                valueString: String? = nil,
                tm:String? = nil,
                lat:Double? = nil,
                lng:Double? = nil,
                stn:String? = nil,
                stn_name:String? = nil

    ) {
        self.id = id
        self.name = name
        self.value = value
        self.landmapId = landmapId
        self.valueString = valueString
        self.tm = tm
        self.lat = lat
        self.lng = lng
        self.stn = stn
        self.stn_name = stn_name

    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case value = "value"
        case landmapId = "landmapId"
        case valueString = "value_string"
        case tm = "tm"
        case lat = "lat"
        case lng = "lng"
        case stn = "stn"
        case stn_name = "stn_name"

    }
    
//    public init(from decoder: Decoder) throws {
//        try id       <- decoder["id"]
//        try name          <- decoder["name"]
//        try value          <- decoder["value"]
//        try landmapId          <- decoder["landmapId"]
//        try valueString          <- decoder["value_string"]
//
//    }
}

extension Decoder {
    public subscript(_ key: String) -> (Decoder, String) {
        return (self, key)
    }
}
