//
//  PageDetailStationModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import UIKit

struct PageDetailStationModel {
    let titleText: String
    let bgColor: UIColor
    
    
    init(titleText:String, color: UIColor) {
        self.titleText = titleText
        self.bgColor = color
    }
    
    static func page() -> [PageDetailStationModel] {
        var pages = [PageDetailStationModel]()
        
        
        pages.append(PageDetailStationModel(titleText: "001", color: .blue))
        pages.append(PageDetailStationModel(titleText: "001", color: .white))
        pages.append(PageDetailStationModel(titleText: "001", color: .red))

        
        return pages
    }
    
}
