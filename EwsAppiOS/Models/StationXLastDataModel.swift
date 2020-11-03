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
    let latitude : String?
    let longitude : String?
    let status : String?
    
    init(stn: String,
         warning_type:String,
         title:String,
         address:String,
         rain:String,
         rain12h:Double,
         rain07h:String,
         rain24h:String,
         ews07: Ews07Model,
         latitude: String,
         longitude: String,
         status: String
        
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
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
    }
    
    static func mixStationXLastData(last_data:[LastDataModel], list_ew07:[Ews07Model], viewModel: LastDataViewModel) {
    
        for lastdata in last_data {
            for (index, station) in AppDelegate.shareDelegate.stations.enumerated() {
                if station.std! == lastdata.stn!  {
                    let myDouble = Double(lastdata.rain12h!)
                    viewModel.input.saveMessageData(data:  StationXLastDataModel(
                        stn: lastdata.stn!,
                        warning_type: lastdata.warning_type!,
                        title: station.name!,
                        address: "ต.\(station.tambon!) อ.\(station.amphoe!) จ.\(station.province!) \nหมู่บ้านครอบคลุมจำนวน \(station.stn_cover!) หมู่บ้าน",
                        rain: lastdata.rain!,
                        rain12h: myDouble ?? 0.0,
                        rain07h: lastdata.rain07h!,
                        rain24h: lastdata.rain24h!,
                        ews07: list_ew07[index],
                        latitude: station.latitude!,
                        longitude: station.longitude!,
                        status: lastdata.status!
                    ))
                    
                }
            }
        }
        
    }
    
    static func mixStationXLastDataV2(last_data:[LastDataModel], list_ew07:[Ews07Model], viewModel: LastDataViewModel){
        
        for lastdata in last_data {
            for (index, station) in AppDelegate.shareDelegate.stations.enumerated() {
                if station.std! == lastdata.stn!  {
                    let myDouble = Double(lastdata.rain12h!)

                    viewModel.input.saveMessageData(data:  StationXLastDataModel(
                        stn: lastdata.stn!,
                        warning_type: lastdata.warning_type!,
                        title: station.name!,
                        address: "ต.\(station.tambon!) อ.\(station.amphoe!) จ.\(station.province!) \nหมู่บ้านครอบคลุมจำนวน \(station.stn_cover!) หมู่บ้าน",
                        rain: lastdata.rain!,
                        rain12h: myDouble ?? 0.0,
                        rain07h: lastdata.rain07h!,
                        rain24h: lastdata.rain24h!,
                        ews07: list_ew07[index],
                        latitude: station.latitude!,
                        longitude: station.longitude!,
                        status: lastdata.status!
                    ))
                }
            }
        }
    }
    
    static func mixSearchStationXLastData(last_data:[LastDataModel], list_ew07:[Ews07Model]) -> [StationXLastDataModel]{
        var  stx: [StationXLastDataModel] = []
          for lastdata in last_data {
              for (index, station) in AppDelegate.shareDelegate.stations.enumerated() {
                  if station.std! == lastdata.stn!  {
                      let myDouble = Double(lastdata.rain12h!)
                    stx.append(StationXLastDataModel(
                        stn: lastdata.stn!,
                        warning_type: lastdata.warning_type!,
                        title: station.name!,
                        address: "ต.\(station.tambon!) อ.\(station.amphoe!) จ.\(station.province!) \nหมู่บ้านครอบคลุมจำนวน \(station.stn_cover!) หมู่บ้าน",
                        rain: lastdata.rain!,
                        rain12h: myDouble ?? 0.0,
                        rain07h: lastdata.rain07h!,
                        rain24h: lastdata.rain24h!,
                        ews07: list_ew07[index],
                        latitude: station.latitude!,
                        longitude: station.longitude!,
                        status: lastdata.status!
                    ))
                }
             }
          }
        return stx
      }
    
}
