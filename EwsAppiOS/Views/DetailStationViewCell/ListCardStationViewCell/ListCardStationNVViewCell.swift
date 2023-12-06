//
//  ListCardStationNVViewCell.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/5/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
import UIKit

class ListCardStationNVViewCell: UITableViewCell {
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .AppPrimaryDarkGray()
        view.layer.cornerRadius = 8
        return view
    }()
    
    let valueStation: UILabel = {
        let label = UILabel()
        
        let title = "ปริมาณฝนสะสม"
        let value = "\nN/A"
        let name = "\nบ้านแซะ"
        let address = "\nต.หนองไผ่ อ.ด่านมะขามเตี้ย จ.กาญจนบุรี\nหมู่บ้านคลอบคลุมจำนวน 3 หมู่บ้าน"
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedText.append(NSMutableAttributedString(string: value, attributes: [NSAttributedString.Key.font : UIFont.PrimaryRegular(size: 35), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        attributedText.append(NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.PrimaryRegular(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        attributedText.append(NSMutableAttributedString(string: address, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()
    
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "overcast")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var station: WarningStation? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.setupValue()
            }
        }
    }
    
    
    
    func setupViewCell() {
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .clear
        separatorInset = .zero
        layoutMargins = .zero
        selectionStyle = .none
        
        addSubview(viewCard)
        viewCard.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        viewCard.addSubview(valueStation)
        viewCard.addSubview(iconImage)
        valueStation.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: viewCard.bottomAnchor, right: viewCard.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 8, rightConstant: 70, widthConstant: 0, heightConstant: 0)
        
        
        iconImage.anchor(viewCard.topAnchor, left: nil, bottom: viewCard.bottomAnchor, right: viewCard.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 70, heightConstant: 0)
        
    }
    
    
    func setupValue() {
        
        setValueLabel()
        
    }
    
    
    func setValueLabel()  {
        let title = "ปริมาณฝนสะสม"
        
        var value = "\nN/A"
        
//        if station!.status == "สถานการณ์ ฝนตกเล็กน้อย" {
//            value = "\n\(station!.rain12h!)"
//        }else {
//            if station!.warning_type == "rain" {
//                value = "\n\(station!.warn_rf!)"
//            }else if station!.warning_type == "wl" {
//                value = "\n\(station!.warn_wl!)"
//            }
//        }
        
        
        if station!.show_status == 9 || station!.show_status == -999 || station!.show_status == 0 {
            value = "\n\(station!.rain12h!)"
        } else {
            value = "\n\(station!.rain_value!)"
        }
        
        
        
        let name = "\n\(station!.name!)"
        let address = "\nต.\(station!.tambon!) อ.\(station!.amphoe!) จ.\(station!.province!)\nหมู่บ้านครอบคลุมจำนวน \(station!.stn_cover ?? 0) หมู่บ้าน"
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedText.append(NSMutableAttributedString(string: value, attributes: [NSAttributedString.Key.font : UIFont.PrimaryRegular(size: 35), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        attributedText.append(NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.PrimaryRegular(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        attributedText.append(NSMutableAttributedString(string: address, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        valueStation.attributedText = attributedText
        valueStation.numberOfLines = 0
        
        switch station!.show_status! {
        case 3:
            iconImage.image = UIImage(named: "rain_tornado")!
            break
        case 2:
            iconImage.image = UIImage(named: "rain_thunder")!
            break
        case 1:
            iconImage.image = UIImage(named: "rain")!
            break
        case 9:
            iconImage.image = UIImage(named: "overcast")!
            break
        default:
            iconImage.image = UIImage(named: "overcast")!
        }
        
        
    }
}
