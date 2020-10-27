//
//  ReportModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation

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
        
        reports.append(ReportModel(title: "แจ้ง เฝ้าระวัง ด้วยระดับน้ำ ระดับน้ำสูง", address: "สถานี บ้านหูแร่ ต.ทุ่งตำเสา อ.เมือง จ.สงขลา", date: "วันที่ 22 เดือน ตุลาคม พ.ศ. 2563 เวลา 19.57.00"))
        reports.append(ReportModel(title: "แจ้ง เฝ้าระวัง ด้วยระดับน้ำ ระดับน้ำสูง", address: "สถานี บ้านหูแร่ ต.ทุ่งตำเสา อ.เมือง จ.สงขลา", date: "วันที่ 22 เดือน ตุลาคม พ.ศ. 2563 เวลา 19.57.00"))
        reports.append(ReportModel(title: "แจ้ง เฝ้าระวัง ด้วยระดับน้ำ ระดับน้ำสูง", address: "สถานี บ้านหูแร่ ต.ทุ่งตำเสา อ.เมือง จ.สงขลา", date: "วันที่ 22 เดือน ตุลาคม พ.ศ. 2563 เวลา 19.57.00"))
        reports.append(ReportModel(title: "แจ้ง เฝ้าระวัง ด้วยระดับน้ำ ระดับน้ำสูง", address: "สถานี บ้านหูแร่ ต.ทุ่งตำเสา อ.เมือง จ.สงขลา", date: "วันที่ 22 เดือน ตุลาคม พ.ศ. 2563 เวลา 19.57.00"))
        return reports
    }
}
