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
    let pm25: String?
    let status : String?
    let warn_rf : Double?
    let warn_wl : Double?
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
         pm25: String,
         status:String,
         warn_rf:Double,
         warn_wl:Double,
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
        self.pm25 = pm25
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
                    
                    
                    let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                    let rainDouble = Double(item_station.childElements[12].text ?? "0.0")
                    let wlDouble = Double(item_station.childElements[13].text ?? "0.0")
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
                            pm25: item_station.childElements[10].text ?? "",
                            status: item_station.childElements[11].text ?? "",
                            warn_rf: rainDouble ?? 0.0,
                            warn_wl: wlDouble ?? 0.0,
                            stn_cover: item_station.childElements[14].text ?? "")
                    )
                    
                }
                
            }
        }
        
        var list_ew07 = Ews07Model.FetchEws07()
//        let sortedLast_data = last_data.sorted(by: {$1.rain12h! < $0.rain12h!})
        
        return StationXLastDataModel.mixSearchStationXLastData(last_data: last_data, list_ew07: list_ew07)
        
    }
    
    static func FetchMapLastData(type:String, viewModel: LastDataViewModel){
        
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        
        switch type {
        case "all":
            getMethodAllMap(viewModel: viewModel)
        case "สถานการณ์ ฝนตกเล็กน้อย":
            getMethodMap(pathUrl: "/lastdata.xml", type: type, viewModel: viewModel)
        default:
            getMethodMap(pathUrl: "/warn.xml", type: type, viewModel: viewModel)
        }
        
        
    }
    
    static func getMethodAllMap(viewModel: LastDataViewModel) {
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        
        
        var pathUrlWarn:String = "/warn.xml"
        
        let urlStringWarn = URL(string: "\(baseURL)\(pathUrlWarn)")
        
        let xmlWarn = try! XML.parse(Data(contentsOf: urlStringWarn!))
        
        
        var last_data = [LastDataModel]()
        
        
        if let count = xmlWarn["ews", "station"].all?.count {
            if count > 0 {
                
                for item_station in xmlWarn["ews", "station"].all! {
                    if (item_station.childElements[11].name == "status"
                        ){
                        
                        let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                        let rainDouble = Double(item_station.childElements[12].text ?? "0.0")
                        let wlDouble = Double(item_station.childElements[13].text ?? "0.0")
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
                                pm25: item_station.childElements[10].text ?? "",
                                status: item_station.childElements[11].text ?? "",
                                warn_rf: rainDouble ?? 0.0,
                                warn_wl: wlDouble ?? 0.0,
                                stn_cover: item_station.childElements[14].text ?? "")
                        )
                    }
                }
            }
        }

        
        
        
        var pathUrlLastData:String = "/lastdata.xml"
        
        let urlStringLastData = URL(string: "\(baseURL)\(pathUrlLastData)")
        
        let xmlLastData = try! XML.parse(Data(contentsOf: urlStringLastData!))
        
        
        
        if let count = xmlLastData["ews", "station"].all?.count {
            if count > 0 {
                
                for item_station in xmlLastData["ews", "station"].all! {
                    if (item_station.childElements[11].name == "status" &&  item_station.childElements[11].text! == "สถานการณ์ ฝนตกเล็กน้อย"
//                        item_station.childElements[11].text! != "สถานการณ์ เตือนภัย" &&
//                        item_station.childElements[11].text! != "สถานการณ์ เฝ้าระวัง" &&
//                        item_station.childElements[11].text! != "กำลังเชื่อมต่อสัญญาน"
                        ){
                        
                        let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                        let rainDouble = Double(item_station.childElements[12].text ?? "0.0")
                        let wlDouble = Double(item_station.childElements[13].text ?? "0.0")
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
                                pm25: item_station.childElements[10].text ?? "",
                                status: item_station.childElements[11].text ?? "",
                                warn_rf: rainDouble ?? 0.0,
                                warn_wl: wlDouble ?? 0.0,
                                stn_cover: item_station.childElements[14].text ?? "")
                        )
                    }
                }
            }
        }
        
        
        
        var list_ew07 = Ews07Model.FetchEws07()
//        print(last_data.count)
        
        StationXLastDataModel.mixStationXLastData(last_data: last_data, list_ew07: list_ew07, viewModel: viewModel)
    }
    
    static func getMethodMap(pathUrl:String,type:String, viewModel: LastDataViewModel) {
        
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        
        
        let urlString = URL(string: "\(baseURL)\(pathUrl)")
        
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        var last_data = [LastDataModel]()
        
        if let count = xml["ews", "station"].all?.count {
            if count > 0 {
                
                for item_station in xml["ews", "station"].all! {
                    if item_station.childElements[11].name == "status" && item_station.childElements[11].text! == "\(type)"{
                        
                        let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                        let rainDouble = Double(item_station.childElements[12].text ?? "0.0")
                        let wlDouble = Double(item_station.childElements[13].text ?? "0.0")
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
                                pm25: item_station.childElements[10].text ?? "",
                                status: item_station.childElements[11].text ?? "",
                                warn_rf: rainDouble ?? 0.0,
                                warn_wl: wlDouble ?? 0.0,
                                stn_cover: item_station.childElements[14].text ?? "")
                        )
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
        case "สถานการณ์ ฝนตกเล็กน้อย":
            pathUrl = "/lastdata.xml"
        default:
            pathUrl = "/warn.xml"
        }
        
        let urlString = URL(string: "\(baseURL)\(pathUrl)")
        
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        var last_data = [LastDataModel]()
        
        if let count = xml["ews", "station"].all?.count {
            if count > 0 {
                if type == "all" {
                    for item_station in xml["ews", "station"].all! {
                        
                        if item_station.childElements[11].name == "status" && item_station.childElements[11].text! != "กำลังเชื่อมต่อสัญญาน" && item_station.childElements[11].text! != "สถานการณ์ ปกติ" {
                            
                            let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                            let rainDouble = Double(item_station.childElements[12].text ?? "0.0")
                            let wlDouble = Double(item_station.childElements[13].text ?? "0.0")
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
                                    pm25: item_station.childElements[10].text ?? "",
                                    status: item_station.childElements[11].text ?? "",
                                    warn_rf: rainDouble ?? 0.0,
                                    warn_wl: wlDouble ?? 0.0,
                                    stn_cover: item_station.childElements[14].text ?? "")
                            )
                            
                        }
                    }
                }else {
                    for item_station in xml["ews", "station"].all! {
                        if item_station.childElements[11].name == "status" && item_station.childElements[11].text! == "\(type)"{
                            let myDouble = Double(item_station.childElements[4].text ?? "0.0")
                            let rainDouble = Double(item_station.childElements[12].text ?? "0.0")
                            let wlDouble = Double(item_station.childElements[13].text ?? "0.0")
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
                                    pm25: item_station.childElements[10].text ?? "",
                                    status: item_station.childElements[11].text ?? "",
                                    warn_rf: rainDouble ?? 0.0,
                                    warn_wl: wlDouble ?? 0.0,
                                    stn_cover: item_station.childElements[14].text ?? "")
                            )
                        }
                    }
                }
                
            }
        }
        //
        //        var sortedLast_data = last_data.sorted(by: {$1.rain12h! < $0.rain12h!})
        //
        switch type {
        case "สถานการณ์ ฝนตกเล็กน้อย":
            return last_data.sorted(by: {$1.rain12h! < $0.rain12h!})
        default:
            return last_data.sorted(by: {$1.warn_rf! < $0.warn_rf!})
        }
    }
    
    
}
