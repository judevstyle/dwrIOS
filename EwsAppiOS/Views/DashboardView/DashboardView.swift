//
//  DashboardView.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 9/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class DashboardView: UITableViewCell {
    

    lazy var viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.0)
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var viewLine: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .PrimaryRegular(size: 35)
        label.textColor = .white
        label.text = "อพยพ"
        return label
    }()
    
    
    
    let titleBannLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .PrimaryRegular(size: 14)
        label.textColor = .white
        label.text = "หมู่บ้าน"
        return label
    }()
    
    let titleStationLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .PrimaryRegular(size: 20)
        label.textColor = .white
        label.text = "สถานี"
        return label
    }()
    
    let valueBannLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .PrimaryRegular(size: 18)
        label.textColor = .white
        label.text = "0"

        return label
    }()
    
    
    
    let valueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.text = "0"
        label.textColor = .white
        label.font = .PrimaryRegular(size: 28)
        
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
    
     var dashboard: DashboardCardModel? {
           didSet {
               DispatchQueue.main.async { [weak self] in
                   self?.setupValue()
               }
           }
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupValue() {
        
        titleLabel.text = dashboard!.name
        valueLabel.text = dashboard!.value
        valueBannLabel.text = dashboard!.valueBann

        viewCard.backgroundColor = dashboard!.color.withAlphaComponent(0.3)
        viewLine.backgroundColor = dashboard!.color
        iconView.image = dashboard!.icon
        
    }
    
    
    func setupView()  {
        
        backgroundColor = .clear
        separatorInset = .zero
        layoutMargins = .zero
        
        selectionStyle = .none
        
        viewCard.addSubview(viewLine)
        viewCard.addSubview(titleLabel)
        viewCard.addSubview(valueLabel)
        viewCard.addSubview(iconView)
        viewCard.addSubview(titleStationLabel)
        
        viewCard.addSubview(valueBannLabel)
        viewCard.addSubview(titleBannLabel)

        viewLine.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: viewCard.bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 11, heightConstant: 0)
        
        
        titleLabel.anchor(viewCard.topAnchor, left: viewLine.rightAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        
        valueLabel.anchor(titleLabel.bottomAnchor, left: viewLine.rightAnchor, bottom: nil, right: nil, topConstant: -6, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        iconView.anchor(viewCard.topAnchor, left: titleLabel.rightAnchor, bottom: viewCard.bottomAnchor, right: viewCard.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        titleStationLabel.anchor(nil, left: valueLabel.rightAnchor, bottom: valueLabel.bottomAnchor, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        valueBannLabel.anchor(nil, left: titleStationLabel.rightAnchor, bottom: titleStationLabel.bottomAnchor, right: nil, topConstant: -6, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        titleBannLabel.anchor(nil, left: valueBannLabel.rightAnchor, bottom: valueBannLabel.bottomAnchor, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 2, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        addSubview(viewCard)
        
        viewCard.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
