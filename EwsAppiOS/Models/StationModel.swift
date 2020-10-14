//
//  StationModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 13/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import SwiftyXMLParser

struct StationModel : Codable {
    
    let std : String?
    let name : String?
    let station_name : String?
    let tambon : String?
    let amphoe : String?
    let province : String?
    let dept : String?
    let basin : String?
    let region : String?
    let station_type: String?
    let stn_cover : String?
    let latitude : String?
    let longitude : String?
    
    
//    enum CodingKeys: String, CodingKey {
//        case std = "std"
//        case name = "name"
//        case station_name = "station_name"
//        case tambon = "tambon"
//        case amphoe = "amphoe"
//        case province = "province"
//        case dept = "dept"
//        case basin = "basin"
//        case region = "region"
//        case station_type = "station_type"
//        case stn_cover = "stn_cover"
//        case latitude = "latitude"
//        case longitude = "longitude"
//
//    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        std = try values.decodeIfPresent(String.self, forKey: .std)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        station_name = try values.decodeIfPresent(String.self, forKey: .station_name)
//        tambon = try values.decodeIfPresent(String.self, forKey: .tambon)
//        amphoe = try values.decodeIfPresent(String.self, forKey: .amphoe)
//        province = try values.decodeIfPresent(String.self, forKey: .province)
//        dept = try values.decodeIfPresent(String.self, forKey: .dept)
//        basin = try values.decodeIfPresent(String.self, forKey: .basin)
//        region = try values.decodeIfPresent(String.self, forKey: .region)
//        station_type = try values.decodeIfPresent(String.self, forKey: .station_type)
//        stn_cover = try values.decodeIfPresent(String.self, forKey: .stn_cover)
//        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
//        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
//
//    }
    
    init(std: String,
         name:String,
         station_name: String,
         tambon: String,
         amphoe: String,
         province: String,
         dept: String,
         basin: String,
         region: String,
         station_type: String,
         stn_cover: String,
         latitude: String,
         longitude: String
    ) {
        self.std = std
        self.name = name
        self.station_name = station_name
        self.tambon = tambon
        self.amphoe = amphoe
        self.province = province
        self.dept = dept
        self.basin = basin
        self.region = region
        self.station_type = station_type
        self.stn_cover = stn_cover
        self.latitude = latitude
        self.longitude = longitude

    }
    
    
    static func FetchStations() -> [StationModel] {
        
         var stations = [StationModel]()
        
              let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
             let urlString = URL(string: "\(baseURL)/station.xml")

            let xml = try! XML.parse(Data(contentsOf: urlString!))
            
            if let count = xml["ews", "station"].all?.count {
                if count > 0 {
                    for item_station in xml["ews", "station"].all! {

                        stations.append(
                            StationModel(
                                std: "",
                                name: "",
                                station_name: "",
                                tambon: "",
                                amphoe: "",
                                province: "",
                                dept: "",
                                basin: "",
                                region: "",
                                station_type: "",
                                stn_cover: "",
                                latitude: "",
                                longitude: ""
                            )
                        )
                        
                    }
                }
            
        }
//        print(stations)
        
        return stations
        
    }
    
 
    
}
