//
//  LastDataViewModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 2/11/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import Foundation
import UIKit

class LastDataViewModel: LastDataStationProtocol, LastDataStationProtocolOutput {
    
    var input: LastDataStationProtocolInput { return self }
    var output: LastDataStationProtocolOutput { return self }
    
    //Data-Binding
    var showMessageAlert: ((StationXLastDataModel) -> Void)?
    var didError: (() -> Void)?
    
}


extension LastDataViewModel: LastDataStationProtocolInput {
    
    func saveMessageData(data: StationXLastDataModel?) {
        guard let new_data = data,
            new_data != nil else {
                didError?()
                return
        }
        showMessageAlert?(new_data)
    }
}
