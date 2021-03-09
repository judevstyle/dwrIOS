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
    
    var menu: MenuSlideModel? {
        didSet {
            if menu?.index == 0 {
                btnMenu.image = menu?.icon?.withRenderingMode(.alwaysOriginal)
            }else {
                btnMenu.image = menu?.icon?.withRenderingMode(.alwaysTemplate)
                btnMenu.tintColor = .white
            }
        }
    }
    
    func setupView()  {
        
        selectionStyle = .none
        backgroundColor = .AppPrimary()
        preservesSuperviewLayoutMargins = false
        separatorInset = .zero
        layoutMargins = .zero
        
        addSubview(btnMenu)
        btnMenu.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
}
