//
//  DashboardCardModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 22/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import UIKit
import SwiftyXMLParser

struct DashboardCardModel {
    var name: String
    var value: String
    var color: UIColor
    
    
    init(name: String, value: String, color: UIColor) {
        self.name = name
        self.value = value
        self.color = color
    }
    
    static func dashboards() -> [DashboardCardModel] {
        var dashboards = [DashboardCardModel]()
        
        dashboards.append(DashboardCardModel(name: "อพยพ", value: "0", color: .red))
        dashboards.append(DashboardCardModel(name: "เตือนภัย", value: "0", color: .yellow))
        dashboards.append(DashboardCardModel(name: "เฝ้าระวัง", value: "0", color: .green))
        dashboards.append(DashboardCardModel(name: "มีฝน", value: "0", color: .mediumBlue))
        
        
        return dashboards
    }
    
    static func getCountStatus() -> [DashboardCardModel] {
        var dashboards = [DashboardCardModel]()
        
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        let urlString = URL(string: "\(baseURL)/count_status_vill.xml")
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        let status3 = xml["ews"]["status1"]
        let status2 = xml["ews"]["status2"]
        let status1 = xml["ews"]["status3"]
        let status4 = xml["ews"]["status9"]
        
        dashboards.append(DashboardCardModel(name: "อพยพ", value: status1.text!, color: .red))
        dashboards.append(DashboardCardModel(name: "เตือนภัย", value: status2.text!, color: .yellow))
        dashboards.append(DashboardCardModel(name: "เฝ้าระวัง", value: status3.text!, color: .green))
        dashboards.append(DashboardCardModel(name: "มีฝน", value: status4.text!, color: .mediumBlue))
        
        return dashboards
    }
    
    
}
