//
//  MenuSideViewCell.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 9/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class MenuSideViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    
    lazy var btnMenu: UIImageView = {
        let btn = UIImageView()
        btn.image = UIImage(systemName: "pencil.circle")
        btn.contentMode = .scaleAspectFill

        btn.tintColor = .white
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView()  {
        
        selectionStyle = .none
        backgroundColor = .white
        
        preservesSuperviewLayoutMargins = false
        separatorInset = .zero
        layoutMargins = .zero
        
        
        addSubview(btnMenu)
        btnMenu.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
}
