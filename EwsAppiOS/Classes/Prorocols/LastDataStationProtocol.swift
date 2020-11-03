//
//  LastDataStationProtocol.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 2/11/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation

protocol LastDataStationProtocolInput {
    func saveMessageData(data: StationXLastDataModel?)
}

protocol LastDataStationProtocolOutput: class {
    var showMessageAlert: ((StationXLastDataModel) -> Void)? {get set}
    var didError: (() -> Void)? {get set}
}

protocol LastDataStationProtocol: LastDataStationProtocolInput, LastDataStationProtocolOutput {
    var input : LastDataStationProtocolInput { get }
    var output : LastDataStationProtocolOutput { get }
}
