//
//  JsonModel.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/11/22.
//  Copyright © 2022 ssoft. All rights reserved.
//

import Foundation

struct ITunesSearchResults<T: Decodable>: Decodable {
    let results: [T]
}

struct Movie: Decodable
{
    let trackId: Int
    let trackName: String
    let trackGenre: String?
    let trackPrice: Double?
    let longDescription: String
}

// MARK: - ProductResponse
struct StationDataResponse: Decodable {
    var stn: String?
    var stnCover: Int?
    var name, tambon, amphoe, province: String?
    var dept, gdID, rtuID, ipAddress: String?
    var mornitorID, modemID, utmX, utmY: String?
    var mapX, mapY, latitude, longitude: String?
    var subBasin, mainBasin, region, projectID: String?
    var stnType, targetPoint1, targetPoint2, warningNetwork: String?
    var stnDesc, riskType, stnDate, temp: String?
    var rain, rain12H, rain24H, rain07H: String?
    var rainPer1, rainPer2, rainPer3, rainMax: String?
    var rainStatus: Int?
    var wl, wl07H, wlPer1, wlPer2: String?
    var wlPer3, wlMax: String?
    var wlStatus: Int?
    var soil1, soil07H, soilPer1, soilPer2: String?
    var soilPer3, soilMax: String?
    var soilStatus: Int?
    var soil2, api, apiPer1, apiPer2: String?
    var apiPer3, apiMax: String?
    var apiStatus: Int?
    var model, modelPer1, modelPer2, modelPer3: String?
    var modelMax: String?
    var modelStatus: Int?
    var apiF: String?
    var connectStatus: Int?
    var fixStatus: String?
    var showStatus: Int?
    var rain48H, rain72H, rain96H, rain120H: String?
    var rain144H, rain168H, showStaTime, siteComment: String?
    var tempPer1, tempPer2, tempPer3, tempMax: String?
    var tempStatus: Int?
    var k01, k02, k03, k04: String?
    var k05, k06, k07, k08: String?
    var k09, k10, k11, k12: String?
    var kMin, kMean, kMax, rec52X: String?
    var rec52Y, apiDaily, apiDailyF: String?
    var apiStatusDaily: Int?
    var diffTime, stnTemp, warningType, installDate: String?
    var signalType, rtuGrp: String?
    var rain24Status: Int?
    var warnRF, warnWl: String?
    var rain72Status: Int?
    var sRepair, villID, nameE, tambonE: String?
    var amphoeE, provinceE, deptE, subBasinE: String?
    var mainBasinE, targetPoint1E, targetPoint2E, warningNetworkE: String?
    var stnDescE, locationCode: String?
    var distance: Double?
    var count: Int?

    
    enum CodingKeys: String, CodingKey {
        case stn
        case stnCover = "stn_cover"
        case name, tambon, amphoe, province, dept
        case gdID = "gd_id"
        case rtuID = "rtu_id"
        case ipAddress = "ip_address"
        case mornitorID = "mornitor_id"
        case modemID = "modem_id"
        case utmX = "utm_x"
        case utmY = "utm_y"
        case mapX = "map_x"
        case mapY = "map_y"
        case latitude, longitude
        case subBasin = "sub_basin"
        case mainBasin = "main_basin"
        case region
        case projectID = "project_id"
        case stnType = "stn_type"
        case targetPoint1 = "target_point1"
        case targetPoint2 = "target_point2"
        case warningNetwork = "warning_network"
        case stnDesc = "stn_desc"
        case riskType = "risk_type"
        case stnDate = "stn_date"
        case temp, rain
        case rain12H = "rain12h"
        case rain24H = "rain24h"
        case rain07H = "rain07h"
        case rainPer1 = "rain_per1"
        case rainPer2 = "rain_per2"
        case rainPer3 = "rain_per3"
        case rainMax = "rain_max"
        case rainStatus = "rain_status"
        case wl
        case wl07H = "wl07h"
        case wlPer1 = "wl_per1"
        case wlPer2 = "wl_per2"
        case wlPer3 = "wl_per3"
        case wlMax = "wl_max"
        case wlStatus = "wl_status"
        case soil1
        case soil07H = "soil07h"
        case soilPer1 = "soil_per1"
        case soilPer2 = "soil_per2"
        case soilPer3 = "soil_per3"
        case soilMax = "soil_max"
        case soilStatus = "soil_status"
        case soil2, api
        case apiPer1 = "api_per1"
        case apiPer2 = "api_per2"
        case apiPer3 = "api_per3"
        case apiMax = "api_max"
        case apiStatus = "api_status"
        case model
        case modelPer1 = "model_per1"
        case modelPer2 = "model_per2"
        case modelPer3 = "model_per3"
        case modelMax = "model_max"
        case modelStatus = "model_status"
        case apiF = "api_f"
        case connectStatus = "connect_status"
        case fixStatus = "fix_status"
        case showStatus = "show_status"
        case rain48H = "rain48h"
        case rain72H = "rain72h"
        case rain96H = "rain96h"
        case rain120H = "rain120h"
        case rain144H = "rain144h"
        case rain168H = "rain168h"
        case showStaTime = "show_sta_time"
        case siteComment = "site_comment"
        case tempPer1 = "temp_per1"
        case tempPer2 = "temp_per2"
        case tempPer3 = "temp_per3"
        case tempMax = "temp_max"
        case tempStatus = "temp_status"
        case k01, k02, k03, k04, k05, k06, k07, k08, k09, k10, k11, k12
        case kMin = "k_min"
        case kMean = "k_mean"
        case kMax = "k_max"
        case rec52X = "rec52_x"
        case rec52Y = "rec52_y"
        case apiDaily = "api_daily"
        case apiDailyF = "api_daily_f"
        case apiStatusDaily = "api_status_daily"
        case diffTime = "diff_time"
        case stnTemp = "stn_temp"
        case warningType = "warning_type"
        case installDate = "install_date"
        case signalType = "signal_type"
        case rtuGrp = "rtu_grp"
        case rain24Status = "rain24_status"
        case warnRF = "warn_rf"
        case warnWl = "warn_wl"
        case rain72Status = "rain72_status"
        case sRepair = "s_repair"
        case villID = "vill_id"
        case nameE = "name_e"
        case tambonE = "tambon_e"
        case amphoeE = "amphoe_e"
        case provinceE = "province_e"
        case deptE = "dept_e"
        case subBasinE = "sub_basin_e"
        case mainBasinE = "main_basin_e"
        case targetPoint1E = "target_point1_e"
        case targetPoint2E = "target_point2_e"
        case warningNetworkE = "warning_network_e"
        case stnDescE = "stn_desc_e"
        case locationCode = "location_code"
        case distance, count
    }
}
