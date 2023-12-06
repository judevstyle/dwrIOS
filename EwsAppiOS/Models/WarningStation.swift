//
//  WarningStation.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/5/23.
//  Copyright © 2023 ssoft. All rights reserved.
//


import Foundation
struct WarningStation: Decodable {
    var latitude: String?
    var longitude: String?
    var warn_rf_v: Double?
    var warn_wl_v: Double?
    var stn_cv: Int?
    var stn: String?
    var name: String?
    var province: String?
    var amphoe: String?
    var tambon: String?
    var dept: String?
    var sub_basin: String?
    var main_basin: String?
    var target_point1: String?
    var stn_desc: String?
    var warning_type: String?
    var stn_date: String?
    var temp: String?
    var rain: String?
    var rain12h: String?
    var rain24h: String?
    var rain07h: String?
    var soil1: String?
    var show_status: Int?
    var warn_rf: String?
    var warn_wl: String?
    var wl07h: String?
    var wl: String?

    var soil2: String?
    var rain48h: String?
    var rain72h: String?
    var rain96h: String?
    var rain120h: String?
    var rain144h: String?
    var rain168h: String?
    var stn_cover: Int?
    var warn_type: Int?
    var pm25: String?
    var status: String?
    var rain_value: Double?

    
    enum CodingKeys: String, CodingKey {
        case latitude =  "latitude"
        case longitude =  "longitude"
        case warn_rf_v =  "warn_rf_v"
        case warn_wl_v =  "warn_wl_v"
        case stn_cv =  "stn_cv"
        case stn =  "stn"
        case name =  "name"
        case province =  "province"
        case amphoe =  "amphoe"
        case tambon =  "tambon"
        case dept =  "dept"
        case sub_basin =  "sub_basin"
        case main_basin =  "main_basin"
        case target_point1 =  "target_point1"
        case stn_desc =  "stn_desc"
        case warning_type =  "warning_type"
        case stn_date =  "stn_date"
        case temp =  "temp"
        case rain =  "rain"
        case rain12h =  "rain12h"
        case rain24h =  "rain24h"
        case rain07h =  "rain07h"
        case soil1 =  "soil1"
        case show_status =  "show_status"
        case warn_rf =  "warn_rf"
        case warn_wl =  "warn_wl"
        case soil2 =  "soil2"
        case rain48h =  "rain48h"
        case rain72h =  "rain72h"
        case rain96h =  "rain96h"
        case rain120h =  "rain120h"
        case rain144h =  "rain144h"
        case rain168h =  "rain168h"
        case stn_cover =  "stn_cover"
        case warn_type =  "warn_type"
        case pm25 =  "pm25"
        case status =  "status"
        case rain_value =  "rain_value"

    }
}
