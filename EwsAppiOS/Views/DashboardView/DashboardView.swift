//
//  DashboardView.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 9/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class DashboardView: UIView {

    var color: UIColor?
    var title: UILabel?
    var value: UILabel?
    var icon: UIImage?
    
    lazy var viewLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = color
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
    
    init(linecolor: UIColor) {
        super.init(frame: .zero)
        
        color = linecolor
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupView()  {
        backgroundColor = .whiteAlpha(alpha: 0.5)
        layer.cornerRadius = 8
        
        
        addSubview(viewLine)
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(iconView)
        
        viewLine.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 10, heightConstant: 0)
        
        
        
        titleLabel.anchor(topAnchor, left: viewLine.rightAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        
        valueLabel.anchor(titleLabel.bottomAnchor, left: viewLine.rightAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        iconView.anchor(topAnchor, left: titleLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
    }
}
