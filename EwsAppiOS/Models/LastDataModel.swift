//
//  LastDataModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 18/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import SwiftyXMLParser

struct LastDataModel : Codable {
    
    let stn : String?
    let warning_type : String?
    let date : String?
    let temp : String?
    let rain : String?
    let rain12h : Double?
    let rain07h : String?
    let rain24h : String?
    let wl : String?
    let wl07h : String?
    let soil : String?
    let status : String?
    let warn_rf : String?
    let warn_wl : String?
    let stn_cover : String?
    
    init(stn: String,
         warning_type:String,
         date:String,
         temp:String,
         rain:String,
         rain12h:Double,
         rain07h:String,
         rain24h:String,
         wl:String,
         wl07h:String,
         soil:String,
         status:String,
         warn_rf:String,
         warn_wl:String,
         stn_cover:String
    ) {
        self.stn = stn
        self.warning_type = warning_type
        self.date = date
        self.temp = temp
        self.rain = rain
        self.rain12h = rain12h
        self.rain07h = rain07h
        self.rain24h = rain24h
        self.wl = wl
        self.wl07h = wl07h
        self.soil = soil
        self.status = status
        self.warn_rf = warn_rf
        self.warn_wl = warn_wl
        self.stn_cover = stn_cover
        
    }
    
    
    static func SearchData() -> [StationXLastDataModel] {
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        
        var pathUrl:String = "/lastdata.xml"
        
        let urlString = URL(string: "\(baseURL)\(pathUrl)")
        
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        var last_data = [LastDataModel]()
        
        if let count = xml["ews", "station"].all?.count {
            if count > 0 {
                
                for item_station in xml["ews", "station"].all! {
                    
                    if item_station.childElements[10].name == "status" && item_station.childElements[10].text! != "กำลังเชื่อมต่อสัญญาน" && item_station.childElements[10].text! != "สถานการณ์ ปกติ" {
                        
                        let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                        last_data.append(
                            LastDataModel(
                                stn: item_station.attributes["stn"]!,
                                warning_type: item_station.childElements[0].text ?? "",
                                date: item_station.childElements[1].text ?? "",
                                temp: item_station.childElements[2].text ?? "",
                                rain: item_station.childElements[3].text ?? "",
                                rain12h: myDouble ?? 0.0,
                                rain07h: item_station.childElements[5].text ?? "",
                                rain24h: item_station.childElements[6].text ?? "",
                                wl: item_station.childElements[7].text ?? "",
                                wl07h: item_station.childElements[8].text ?? "",
                                soil: item_station.childElements[9].text ?? "",
                                status: item_station.childElements[10].text ?? "",
                                warn_rf: item_station.childElements[11].text ?? "",
                                warn_wl: item_station.childElements[12].text ?? "",
                                stn_cover: item_station.childElements[13].text ?? "")
                        )
                        
                    }
                }
                
            }
        }
        
        var list_ew07 = Ews07Model.FetchEws07()
        let sortedLast_data = last_data.sorted(by: {$1.rain12h! < $0.rain12h!})
        
        return StationXLastDataModel.mixSearchStationXLastData(last_data: sortedLast_data, list_ew07: list_ew07)
        
    }
    
    static func FetchMapLastData(type:String, viewModel: LastDataViewModel){
        
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        
        var pathUrl:String = "/lastdata.xml"
        
        //        switch type {
        //        case "all":
        //            pathUrl = "/warn.xml"
        //        default:
        //            pathUrl = "/lastdata.xml"
        //        }
        
        let urlString = URL(string: "\(baseURL)\(pathUrl)")
        
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        var last_data = [LastDataModel]()
        
        if let count = xml["ews", "station"].all?.count {
            if count > 0 {
                
                if type == "all" {
                    
                    for item_station in xml["ews", "station"].all! {
                        
                        if item_station.childElements[10].name == "status" && item_station.childElements[10].text! != "กำลังเชื่อมต่อสัญญาน" && item_station.childElements[10].text! != "สถานการณ์ ปกติ" {
                            
                            let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                            last_data.append(
                                LastDataModel(
                                    stn: item_station.attributes["stn"]!,
                                    warning_type: item_station.childElements[0].text ?? "",
                                    date: item_station.childElements[1].text ?? "",
                                    temp: item_station.childElements[2].text ?? "",
                                    rain: item_station.childElements[3].text ?? "",
                                    rain12h: myDouble ?? 0.0,
                                    rain07h: item_station.childElements[5].text ?? "",
                                    rain24h: item_station.childElements[6].text ?? "",
                                    wl: item_station.childElements[7].text ?? "",
                                    wl07h: item_station.childElements[8].text ?? "",
                                    soil: item_station.childElements[9].text ?? "",
                                    status: item_station.childElements[10].text ?? "",
                                    warn_rf: item_station.childElements[11].text ?? "",
                                    warn_wl: item_station.childElements[12].text ?? "",
                                    stn_cover: item_station.childElements[13].text ?? "")
                            )
                            
                        }
                    }
                }else {
                    for item_station in xml["ews", "station"].all! {
                        if item_station.childElements[10].name == "status" && item_station.childElements[10].text! == "\(type)"{
                            
                            let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                            last_data.append(
                                LastDataModel(
                                    stn: item_station.attributes["stn"]!,
                                    warning_type: item_station.childElements[0].text ?? "",
                                    date: item_station.childElements[1].text ?? "",
                                    temp: item_station.childElements[2].text ?? "",
                                    rain: item_station.childElements[3].text ?? "",
                                    rain12h: myDouble ?? 0.0,
                                    rain07h: item_station.childElements[5].text ?? "",
                                    rain24h: item_station.childElements[6].text ?? "",
                                    wl: item_station.childElements[7].text ?? "",
                                    wl07h: item_station.childElements[8].text ?? "",
                                    soil: item_station.childElements[9].text ?? "",
                                    status: item_station.childElements[10].text ?? "",
                                    warn_rf: item_station.childElements[11].text ?? "",
                                    warn_wl: item_station.childElements[12].text ?? "",
                                    stn_cover: item_station.childElements[13].text ?? "")
                            )
                        }
                    }
                }
                
            }
        }
        
        var list_ew07 = Ews07Model.FetchEws07()
        
        let sortedLast_data = last_data.sorted(by: {$1.rain12h! < $0.rain12h!})
        
        StationXLastDataModel.mixStationXLastData(last_data: sortedLast_data, list_ew07: list_ew07, viewModel: viewModel)
        
    }
    
    
    
    static func FetchLastDataV2(type:String) -> [LastDataModel]{
        
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        
        var pathUrl:String = "/lastdata.xml"
        
        switch type {
        case "all":
            pathUrl = "/warn.xml"
        default:
            pathUrl = "/lastdata.xml"
        }
        
        let urlString = URL(string: "\(baseURL)\(pathUrl)")
        
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        var last_data = [LastDataModel]()
        
        if let count = xml["ews", "station"].all?.count {
            if count > 0 {
                if type == "all" {
                    for item_station in xml["ews", "station"].all! {
                        
                        if item_station.childElements[10].name == "status" && item_station.childElements[10].text! != "กำลังเชื่อมต่อสัญญาน" && item_station.childElements[10].text! != "สถานการณ์ ปกติ" {
                            
                            let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                            last_data.append(
                                LastDataModel(
                                    stn: item_station.attributes["stn"]!,
                                    warning_type: item_station.childElements[0].text ?? "",
                                    date: item_station.childElements[1].text ?? "",
                                    temp: item_station.childElements[2].text ?? "",
                                    rain: item_station.childElements[3].text ?? "",
                                    rain12h: myDouble ?? 0.0,
                                    rain07h: item_station.childElements[5].text ?? "",
                                    rain24h: item_station.childElements[6].text ?? "",
                                    wl: item_station.childElements[7].text ?? "",
                                    wl07h: item_station.childElements[8].text ?? "",
                                    soil: item_station.childElements[9].text ?? "",
                                    status: item_station.childElements[10].text ?? "",
                                    warn_rf: item_station.childElements[11].text ?? "",
                                    warn_wl: item_station.childElements[12].text ?? "",
                                    stn_cover: item_station.childElements[13].text ?? "")
                            )
                            
                        }
                    }
                }else {
                    for item_station in xml["ews", "station"].all! {
                        if item_station.childElements[10].name == "status" && item_station.childElements[10].text! == "\(type)"{
                            let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                            last_data.append(
                                LastDataModel(
                                    stn: item_station.attributes["stn"]!,
                                    warning_type: item_station.childElements[0].text ?? "",
                                    date: item_station.childElements[1].text ?? "",
                                    temp: item_station.childElements[2].text ?? "",
                                    rain: item_station.childElements[3].text ?? "",
                                    rain12h: myDouble ?? 0.0,
                                    rain07h: item_station.childElements[5].text ?? "",
                                    rain24h: item_station.childElements[6].text ?? "",
                                    wl: item_station.childElements[7].text ?? "",
                                    wl07h: item_station.childElements[8].text ?? "",
                                    soil: item_station.childElements[9].text ?? "",
                                    status: item_station.childElements[10].text ?? "",
                                    warn_rf: item_station.childElements[11].text ?? "",
                                    warn_wl: item_station.childElements[12].text ?? "",
                                    stn_cover: item_station.childElements[13].text ?? "")
                            )
                        }
                    }
                }
                
            }
        }
        
        let sortedLast_data = last_data.sorted(by: {$1.rain12h! < $0.rain12h!})
        
        return sortedLast_data
    }
    
    
}
