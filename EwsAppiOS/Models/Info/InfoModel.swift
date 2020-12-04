//
//  InfoModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 29/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import SwiftyXMLParser

struct Item: Codable {
    var name: String
    var detail: String
    
    init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

struct Section: Codable {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
    
    
    static func sectionsData() -> [Section] {
        
        
        var sections = [Section]()
        
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        let urlString = URL(string: "\(baseURL)/info.xml")
        
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        let titleDerivation: String = xml["ews", "ews01"].text!
        let detailDerivation1: String = xml["ews", "ews02"].text!
        let detailDerivation2: String = xml["ews", "ews03"].text!
        let titleObjective: String = xml["ews", "ews04"].text!
        let detailObjective: String = xml["ews", "ews05"].text!
        let titleDeveloper: String = xml["ews", "ews06"].text!
        let detailDeveloper: String = xml["ews", "ews07"].text!
        

        //ความเป็นมา
        sections.append(Section(name: titleDerivation, items: [
            Item(name: "", detail: detailDerivation1),
            Item(name: "", detail: detailDerivation2)
        ], collapsed: true))
        
        //วัตถุประสงค์
        sections.append(Section(name: titleObjective, items: [
            Item(name: "", detail: detailObjective)
        ], collapsed: true))
        
        //ผู้พัฒนา
        sections.append(Section(name: titleDeveloper, items: [
            Item(name: "", detail: detailDeveloper),
        ], collapsed: true))
        
        
        return  sections
        
    }
    
}


