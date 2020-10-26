//
//  DetailSttionViewCell.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class DetailStationViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
    }
    
    
    var page : PageDetailStationModel? {
        didSet {
            backgroundColor = page?.bgColor
        }
    }
    

    
    func setupViewCell()  {
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
