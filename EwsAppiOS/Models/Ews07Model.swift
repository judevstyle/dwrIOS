//
//  Ews07Model.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 28/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation

import Foundation
import SwiftyXMLParser



struct Ews07Model : Codable {
    
    let stn : String?
    let date : String?
    let rain : String?
    let rain12h : String?
    let rain07h : String?
    let rain1day : String?
    let rain2day : String?
    let rain3day : String?
    let rain4day : String?
    let rain5day : String?
    let rain6day : String?
    let rain7day : String?
    let stn_cover : String?
    
    init(stn: String,
         date:String,
         rain: String,
         rain12h: String,
         rain07h: String,
         rain1day: String,
         rain2day: String,
         rain3day: String,
         rain4day: String,
         rain5day: String,
         rain6day: String,
         rain7day: String,
         stn_cover: String
    ) {
        self.stn = stn
        self.date = date
        self.rain = rain
        self.rain12h = rain12h
        self.rain07h = rain07h
        self.rain1day = rain1day
        self.rain2day = rain2day
        self.rain3day = rain3day
        self.rain4day = rain4day
        self.rain5day = rain5day
        self.rain6day = rain6day
        self.rain7day = rain7day
        self.stn_cover = stn_cover
        
    }
    
    static func FetchEws07() -> [Ews07Model] {
        
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        let urlString = URL(string: "\(baseURL)/ews07.xml")
        
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        var list_ews07 = [Ews07Model]()
        
        
        if let count = xml["ews", "station"].all?.count {
            if count > 0 {
                for item_station in xml["ews", "station"].all! {
                    list_ews07.append(Ews07Model(
                        stn: item_station.attributes["stn"]!,
                        date: item_station.childElements[0].text ?? "",
                        rain: item_station.childElements[1].text ?? "0.0",
                        rain12h: item_station.childElements[2].text ?? "0.0",
                        rain07h: item_station.childElements[3].text ?? "0.0",
                        rain1day: item_station.childElements[4].text ?? "0.0",
                        rain2day: item_station.childElements[5].text ?? "0.0",
                        rain3day: item_station.childElements[6].text ?? "0.0",
                        rain4day: item_station.childElements[7].text ?? "0.0",
                        rain5day: item_station.childElements[8].text ?? "0.0",
                        rain6day: item_station.childElements[9].text ?? "0.0",
                        rain7day: item_station.childElements[10].text ?? "0.0",
                        stn_cover: item_station.childElements[11].text ?? "0")
                    )
                }
            }
        }
        
        return list_ews07
        
    }
}
