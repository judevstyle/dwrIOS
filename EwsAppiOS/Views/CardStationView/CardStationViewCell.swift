//
//  CardStationViewCell.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 18/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class CardStationViewCell: UITableViewCell {
    
    
    lazy var viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.2)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .PrimaryRegular(size: 25)
        label.textColor = .white
        label.text = "บ้านหินแด้น"
        return label
    }()
    
    
    let addressLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
        label.textColor = .white
        
        let stringValue = "ต.หนองไผ่ อ.ด่านมะขามเตี้ย จ.กาญจนบุรี\nหมู่บ้านคลอบคลุมจำนวน 3 หมู่บ้าน"
        
        let attributedString = NSMutableAttributedString(string: stringValue)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.maximumLineHeight = 20.0
        
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        attributedString.addAttribute(
            .font,
            value: UIFont.PrimaryLight(size: 15),
            range: NSRange(location: 0, length: attributedString.length
        ))
        label.attributedText = attributedString
        
        return label
    }()
    
    
    let rainLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.text = "ฝนสะสม 12 ชั่วโมง"
        label.textColor = .white
        label.font = .PrimaryRegular(size: 21)
        
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.text = "0"
        label.textColor = .white
        label.font = .PrimaryRegular(size: 40)
        
        return label
    }()
    
    let iconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clound")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView()  {
        
        backgroundColor = .clear
        separatorInset = .zero
        layoutMargins = .zero
        
        selectionStyle = .none
        
        
        
        
        
        //
        //        iconView.anchor(addressLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: frame.width/2, heightConstant: 50)
        
        addSubview(viewCard)
        
        viewCard.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        viewCard.addSubview(titleLabel)
        viewCard.addSubview(addressLabel)
        viewCard.addSubview(iconView)
        
        
        titleLabel.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 5, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        addressLabel.anchor(titleLabel.bottomAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        iconView.anchor(addressLabel.bottomAnchor, left: viewCard.leftAnchor, bottom: viewCard.bottomAnchor, right: nil, topConstant: 3, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: frame.width/2, heightConstant: 0)
        
    }
    
    
    
}
