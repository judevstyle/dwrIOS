//
//  DashboardMapView.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 22/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//


import UIKit

class DashboardMapView: UITableViewCell {
    
    lazy var viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.5)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .PrimaryRegular(size: 17)
        label.textColor = .red
        label.text = "อพยพ"
        label.textAlignment = .center
        return label
    }()
    
    
    let valueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.text = "0"
        label.textColor = .red
        label.textAlignment = .center
        label.font = .PrimaryRegular(size: 23)
        
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
        
        switch dashboard!.name {
        case "อพยพ":
            titleLabel.textColor = .red
            valueLabel.textColor = .red
        case "เตือนภัย":
            titleLabel.textColor = .yellow
            valueLabel.textColor = .yellow
        case "เฝ้าระวัง":
            titleLabel.textColor = .green
            valueLabel.textColor = .green
        case "มีฝน":
            titleLabel.textColor = .systemBlue
            valueLabel.textColor = .systemBlue
        default:
            titleLabel.textColor = .black
            valueLabel.textColor = .black
        }
        
    }
    
    
    func setupView()  {
        
        backgroundColor = .clear
        separatorInset = .zero
        layoutMargins = .zero
        
        selectionStyle = .none
        
        viewCard.addSubview(iconView)
        viewCard.addSubview(titleLabel)
        viewCard.addSubview(valueLabel)
        
        iconView.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 30)
        
        titleLabel.anchor(iconView.bottomAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        valueLabel.anchor(titleLabel.bottomAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: -3, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        addSubview(viewCard)
        
        viewCard.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
