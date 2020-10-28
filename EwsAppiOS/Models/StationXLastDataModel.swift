//
//  StationXLastDataModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 19/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import SwiftyXMLParser

struct StationXLastDataModel : Codable {
    
    let stn : String?
    let warning_type : String?
    let title: String?
    let address: String?
    let rain : String?
    let rain12h : Double?
    let rain07h : String?
    let rain24h : String?
    let ews07: Ews07Model?
    
    init(stn: String,
         warning_type:String,
         title:String,
         address:String,
         rain:String,
         rain12h:Double,
         rain07h:String,
         rain24h:String,
         ews07: Ews07Model
    ) {
        self.stn = stn
        self.warning_type = warning_type
        self.title = title
        self.address = address
        self.rain = rain
        self.rain12h = rain12h
        self.rain07h = rain07h
        self.rain24h = rain24h
        self.ews07 = ews07
    }
    
    
    static func mixStationXLastData(last_data:[LastDataModel], list_ew07:[Ews07Model]) -> [StationXLastDataModel] {
        
        var stationxlast_data = [StationXLastDataModel]()
        
        for lastdata in last_data {
            for (index, station) in AppDelegate.shareDelegate.stations.enumerated() {
                if station.std! == lastdata.stn!  {
                    let myDouble = Double(lastdata.rain12h!)
                    stationxlast_data.append(
                        StationXLastDataModel(
                            stn: lastdata.stn!,
                            warning_type: lastdata.warning_type!,
                            title: station.name!,
                            address: "ต.\(station.tambon!) อ.\(station.amphoe!) จ.\(station.province!) \nหมู่บ้านครอบคลุมจำนวน \(station.stn_cover!) หมู่บ้าน",
                            rain: lastdata.rain!,
                            rain12h: myDouble ?? 0.0,
                            rain07h: lastdata.rain07h!,
                            rain24h: lastdata.rain24h!,
                            ews07: list_ew07[index]
                        )
                    )
                }
            }
        }
        
        let sortedArray = stationxlast_data.sorted(by: {$1.rain12h! < $0.rain12h!})
        
        return sortedArray
        
    }
    
}
