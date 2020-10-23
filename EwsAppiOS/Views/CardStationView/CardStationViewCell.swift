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
    
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
        label.textColor = .blackAlpha(alpha: 0.8)
        
        let stringValue = "ต.หนองไผ่ อ.ด่านมะขามเตี้ย จ.กาญจนบุรี\nหมู่บ้านคลอบคลุมจำนวน 3 หมู่บ้าน"
        
        label.attributedText = self.withTextParagraph(text: stringValue, fonSize: 15)
        
        return label
    }()
    
    
    let rainLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.text = "ฝนสะสม 12 ชั่วโมง"
        label.textColor = .white

        label.font = .PrimaryLight(size: 17)
        label.textAlignment = .center

        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.text = "0"
        label.textColor = .white
        label.font = .PrimaryRegular(size: 40)
        label.textAlignment = .center
        return label
    }()
    
    let iconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clound")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
        var station: StationXLastDataModel? {
          didSet {
              DispatchQueue.main.async { [weak self] in
                  self?.setupValue()
              }
          }
      }


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
        viewCard.addSubview(rainLabel)
        viewCard.addSubview(valueLabel)

        
        titleLabel.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 5, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        addressLabel.anchor(titleLabel.bottomAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        iconView.anchor(addressLabel.bottomAnchor, left: viewCard.leftAnchor, bottom: viewCard.bottomAnchor, right: nil, topConstant: 5, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: frame.width/2, heightConstant: 0)
        
        rainLabel.anchor(addressLabel.bottomAnchor, left: iconView.rightAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 5, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        valueLabel.anchor(rainLabel.bottomAnchor, left: iconView.rightAnchor, bottom: viewCard.bottomAnchor, right: viewCard.rightAnchor, topConstant: 3, leftConstant: 5, bottomConstant: 8, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
    }
    
    func setupValue() {
        titleLabel.text = "\(station!.title!)"
        addressLabel.attributedText = self.withTextParagraph(text: "\(station!.address!)", fonSize: 15)
        
        let value = Int(Double("\(station!.rain12h!)")!)
        
        valueLabel.text = "\(value)"
    }

    
}
