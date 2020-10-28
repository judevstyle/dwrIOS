//
//  ListCardStationViewCell.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class ListCardStationViewCell: UITableViewCell {
    
    
    
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
    
    var station: StationXLastDataModel? {
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
        
        if ((station!.rain12h) != nil) {
            value = "\n\(String(format: "%.2f", station!.rain12h!))"
        }
        let name = "\n\(station!.title!)"
        let address = "\n\(station!.address!)"
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedText.append(NSMutableAttributedString(string: value, attributes: [NSAttributedString.Key.font : UIFont.PrimaryRegular(size: 35), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        attributedText.append(NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.PrimaryRegular(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        attributedText.append(NSMutableAttributedString(string: address, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
         valueStation.attributedText = attributedText
        valueStation.numberOfLines = 0
    }
}
