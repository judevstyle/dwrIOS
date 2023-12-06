//
//  DetailReportNVViewCell.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/5/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
import UIKit

class DetailReportNVViewCell: UICollectionViewCell {
    
    
    let viewMain: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.2)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let textDetail: UITextView = {
        let text = UITextView()
        text.text = "TEST"
        text.isScrollEnabled = true
        text.backgroundColor = .clear
        text.textColor = .white
        text.tintColor = .white
        text.font = .PrimaryLight(size: 16)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var report: ReportNVModel? {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    self?.setupValue()
                }
            }
        }
    
    
    func setupViewCell()  {
        backgroundColor = .AppPrimaryDark()
        
        addSubview(viewMain)
        viewMain.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        viewMain.addSubview(textDetail)
        textDetail.anchor(viewMain.topAnchor, left: viewMain.leftAnchor, bottom: viewMain.bottomAnchor, right: viewMain.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
    }
    
    func setupValue()  {
        
        textDetail.text = "\(report!.report_body!)"
        
    }
}
