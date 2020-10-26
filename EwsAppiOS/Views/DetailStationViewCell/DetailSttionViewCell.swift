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
    
//    var pages: PageIntroControl? {
//        didSet {
//            guard let image = pages?.imageView else { return }
//            ImageIcon.image = UIImage(named: "\(image)")
//            titleTextLabel.text = "\(pages!.titleText)"
//            subTitleTextLabel.text = "\(pages!.subTitle)"
//        }
//    }
    

    
    func setupViewCell()  {
    
        backgroundColor = .red

       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
