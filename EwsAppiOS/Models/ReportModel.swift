//
//  ReportModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import SwiftyXMLParser



enum TypeStatusWeather {
    case Evacuate //อพยพ
    case Caution //เตือนภัย
    case Watchout //เฝ้าระวัง
    case Rain //ฝนตกเล็กน้อย
    case Connecting //กำลังเชื่อมต่อสัญญาน
    case Normal //ปกติ
}

struct ReportModel {
    var title: String?
    var address: String?
    var date: String?
    var status: TypeStatusWeather?
    var body: String?
    
    init(title: String?, address:String?, date: String?, status: TypeStatusWeather?, body: String?) {
        self.title = title
        self.address = address
        self.date = date
        self.status = status
        self.body = body
    }
    
    static func reports() -> [ReportModel] {
        var reports = [ReportModel]()
        
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        let urlString = URL(string: "\(baseURL)/warn_report.xml")
        
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        if let count = xml["ews", "station"].all?.count {
            if count > 0 {
                for item_report in xml["ews", "station"].all! {
                    let title = item_report.childElements[1].text!.subStringReport()
                    
                    let statusStr = title[0].subStringReportStatus()
                    
                    var status: TypeStatusWeather = .Caution
                    
                    var date: String = item_report.childElements[0].text!
                    
                    var body: String = item_report.childElements[3].text!
                    
                    switch statusStr {
                    case "อพยพ":
                        status = .Evacuate
                    case "เตือนภัย":
                        status = .Caution
                    case "เฝ้าระวัง":
                        status = .Watchout
                    case "ฝนตกเล็กน้อย":
                        status = .Rain
                    default:
                        status = .Normal
                    }
                    
                    reports.append(ReportModel(title: "\(title[0])", address: "สถานี \(title[1])", date: "\(date)", status: status, body: "\(body)"))
                }
                
            }
        }
        
        return reports
    }
}
