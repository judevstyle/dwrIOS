//
//  ReportNVModel.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/5/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation


public struct ReportNVModel: Codable, Hashable {
    
    public var report_body: String?
    public var report_date: String?
    public var report_signature: String?
    public var report_title: String?
    public var stn_id: String?
    public var warning_type: String?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case report_body = "report_body"
        case report_date = "report_date"
        case report_signature = "report_signature"
        case report_title = "report_title"
        case stn_id = "stn_id"
        case warning_type = "warning_type"

    }
}
