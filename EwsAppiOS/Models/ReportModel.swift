//
//  ReportModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import SwiftyXMLParser

struct ReportModel {
    var title: String?
    var address: String?
    var date: String?
    
    init(title: String?, address:String?, date: String?) {
        self.title = title
        self.address = address
        self.date = date
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
                    reports.append(ReportModel(title: "\(title[0])", address: "สถานี \(title[1])", date: "วันที่ 22 เดือน ตุลาคม พ.ศ. 2563 เวลา 19.57.00"))
                }
                
            }
        }
    
        return reports
    }
}
