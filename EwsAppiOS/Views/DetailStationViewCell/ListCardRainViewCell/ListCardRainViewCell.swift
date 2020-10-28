//
//  ListCardRainViewCell.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class ListCardRainViewCell: UITableViewCell {
    
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ฝน 24 ชั่วโมง"
        label.font = .PrimaryLight(size: 23)
        label.textColor = .white
        return label
    }()
    
    var ews07: Ews07Model? {
        didSet {
            
        }
    }
    
    var indexPath: IndexPath? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.setupValue()
            }
        }
    }
    
    let valueLabel: UILabel = {
        let label = UILabel()
        
        
        let value = "00.00"
        let unit = "\nมม."
        
        let attributedText = NSMutableAttributedString(string: value, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 38), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedText.append(NSMutableAttributedString(string: unit, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.65
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    func setupViewCell() {
        
        backgroundColor = .clear
        separatorInset = .zero
        layoutMargins = .zero
        
        selectionStyle = .none
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubview(viewCard)
        viewCard.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        titleLabel.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: viewCard.bottomAnchor, right: nil, topConstant: 8, leftConstant: 16, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        valueLabel.anchor(viewCard.topAnchor, left: nil, bottom: viewCard.bottomAnchor, right: viewCard.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
    }
    
    func setupValue()  {
        
        titleLabel.text = "ฝนตก \(indexPath!.row * 24) ชั่วโมง"
        switch indexPath?.row {
        case 1:
            setValueLabel(value: ews07!.rain1day!)
        case 2:
            setValueLabel(value: ews07!.rain2day!)
        case 3:
            setValueLabel(value: ews07!.rain3day!)
        case 4:
            setValueLabel(value: ews07!.rain4day!)
        case 5:
            setValueLabel(value: ews07!.rain5day!)
        case 6:
            setValueLabel(value: ews07!.rain6day!)
        case 7:
            setValueLabel(value: ews07!.rain7day!)
        default:
            setValueLabel(value: "0.00")
        }
    }
    
    func setValueLabel(value: String) {
        let doubleValue = Double(value)
        let value = String(format: "%.2f", doubleValue!)
        let unit = "\nมม."
        
        let attributedText = NSMutableAttributedString(string: value, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 38), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedText.append(NSMutableAttributedString(string: unit, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.65
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        valueLabel.attributedText = attributedText
        valueLabel.textAlignment = .center
        
    }
}
