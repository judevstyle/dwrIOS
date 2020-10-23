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
        view.backgroundColor = .whiteAlpha(alpha: 0.2)
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
        label.font = .PrimaryRegular(size: 40)
        label.textColor = .white
        label.text = "อพยพ"
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
        viewLine.backgroundColor = dashboard!.color
        
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
        
        viewLine.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: viewCard.bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 10, heightConstant: 0)
        
        
        titleLabel.anchor(viewCard.topAnchor, left: viewLine.rightAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        
        valueLabel.anchor(titleLabel.bottomAnchor, left: viewLine.rightAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        iconView.anchor(viewCard.topAnchor, left: titleLabel.rightAnchor, bottom: viewCard.bottomAnchor, right: viewCard.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        
        addSubview(viewCard)
        
        viewCard.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
