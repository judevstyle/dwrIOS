//
//  CardStationViewCell.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 18/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//


import UIKit
import SkeletonView

class CardStationViewCell: UITableViewCell {
    
    
    lazy var viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.3)
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
        label.textColor = .blackAlpha(alpha: 0.6)
        
        let stringValue = "ต.หนองไผ่ อ.ด่านมะขามเตี้ย จ.กาญจนบุรี\nหมู่บ้านคลอบคลุมจำนวน 3 หมู่บ้าน"
        
        label.attributedText = self.withTextParagraph(text: stringValue, fonSize: 15)
        
        return label
    }()
    
    
    let rainLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.text = "ปริมาณน้ำฝน"
        label.textColor = .white
        
        label.font = .PrimaryLight(size: 17)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.text = "0"
        label.textColor = .white
        label.font = .PrimaryRegular(size: 40)
        label.textAlignment = .right
        return label
    }()
    
    lazy var valueUnitLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "มม."
        label.textColor = .white
        label.font = .PrimaryRegular(size: 16)
        label.textAlignment = .right
        return label
    }()
    
//    lazy var valueStack: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis  = .horizontal
//        stackView.distribution  = .fill
//        stackView.alignment = UIStackView.Alignment.bottom
//        stackView.spacing   = 0
//        stackView.addArrangedSubview(valueLabel)
//        stackView.addArrangedSubview(valueUnitLabel)
//        return stackView
//    }()
    
    let iconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "overcast")
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

        viewCard.addSubview(valueUnitLabel)
        viewCard.addSubview(valueLabel)
        
        titleLabel.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 5, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        addressLabel.anchor(titleLabel.bottomAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        iconView.anchor(addressLabel.bottomAnchor, left: viewCard.leftAnchor, bottom: viewCard.bottomAnchor, right: nil, topConstant: 5, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: frame.width/2, heightConstant: 0)
        
        rainLabel.anchor(addressLabel.bottomAnchor, left: iconView.rightAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 5, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        valueUnitLabel.anchor(nil, left: nil, bottom: viewCard.bottomAnchor, right: viewCard.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 18, rightConstant: 16, widthConstant: 25, heightConstant: 0)
        
        valueLabel.anchor(rainLabel.bottomAnchor, left: iconView.rightAnchor, bottom: viewCard.bottomAnchor, right: valueUnitLabel.leftAnchor, topConstant: 3, leftConstant: 5, bottomConstant: 8, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
    func setupValue() {
        
        
        titleLabel.text = "\(station!.title!)"
        addressLabel.attributedText = self.withTextParagraph(text: "\(station!.address!)", fonSize: 15)

        
        if station!.status == "สถานการณ์ ฝนตกเล็กน้อย" {
            rainLabel.text = "ปริมาณน้ำฝนสะสม"
            valueUnitLabel.text = "มม."
        }else {
            if station!.warning_type == "rain" {
                rainLabel.text = "ปริมาณน้ำฝนสะสม"
                valueUnitLabel.text = "มม."
            } else {
                rainLabel.text = "ระดับน้ำ"
                valueUnitLabel.text = "ม."
            }
        }
        
        valueLabel.text = "\(station!.value!)"
        
        switch station!.status! {
        case "สถานการณ์ อพยพ":
            iconView.image = UIImage(named: "rain_tornado")!
            viewCard.backgroundColor = UIColor.systemRed.withAlphaComponent(0.3)
            break
        case "สถานการณ์ เตือนภัย":
            iconView.image = UIImage(named: "rain_thunder")!
            viewCard.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
            break
        case "สถานการณ์ เฝ้าระวัง":
            iconView.image = UIImage(named: "rain")!
            viewCard.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
            break
        case "สถานการณ์ ฝนตกเล็กน้อย":
            iconView.image = UIImage(named: "overcast")!
            viewCard.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3)
            break
        default:
            iconView.image = UIImage(named: "overcast")!
            viewCard.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3)
        }
        
        
    }
    
    
}
