//
//  StationModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 13/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import SwiftyXMLParser
import Moya

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
    
    
    static let APIServiceProvider = MoyaProvider<APIService>()
    
    static func FetchStations() {
        var baseURL: URL {
            let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
            return URL(string: "\(baseURL)")!
        }
        print("url \(baseURL)")
        
        APIServiceProvider.request(.GetStations, completion: { [self] result in
            switch result {
            case .success(let response):
                do{
                    
                    var stations = [StationModel]()
                    
                    let xml = XML.parse(response.data)
                    if let count = xml["ews", "station"].all?.count {
                        if count > 0 {
                            for item_station in xml["ews", "station"].all! {
                                stations.append(
                                    StationModel(
                                        std: item_station.attributes["stn"]!,
                                        name: item_station.childElements[0].text ?? "",
                                        station_name: item_station.childElements[1].text ?? "",
                                        tambon: item_station.childElements[2].text ?? "",
                                        amphoe: item_station.childElements[3].text ?? "",
                                        province: item_station.childElements[4].text ?? "",
                                        dept: item_station.childElements[5].text ?? "",
                                        basin: item_station.childElements[6].text ?? "",
                                        region: item_station.childElements[7].text ?? "",
                                        station_type: item_station.childElements[8].text ?? "",
                                        stn_cover: item_station.childElements[9].text ?? "",
                                        latitude: item_station.childElements[10].text ?? "",
                                        longitude: item_station.childElements[11].text ?? ""
                                    )
                                )
                            }
                        }
                    }
                    print("shareDelegate.stations \(stations.count)")

                    AppDelegate.shareDelegate.stations = stations
                    LastDataModel.SearchData()
    
                } catch let parsingError {
                    print("Error", parsingError.localizedDescription)
                }
            case .failure(let error):
                print("Error: \(error.errorDescription ?? "")")
            }
        })
        
    }
    
    
    
}
