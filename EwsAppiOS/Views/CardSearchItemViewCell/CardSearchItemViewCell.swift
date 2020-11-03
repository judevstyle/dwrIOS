//
//  CardSearchItemViewCell.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 3/11/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class CardSearchItemViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.3)
        view.layer.cornerRadius = 8
        return view
    }()
    
    
    
    func setupViewCell() {
        
        backgroundColor = .clear
        separatorInset = .zero
        layoutMargins = .zero
        selectionStyle = .none
        
        contentView.addSubview(viewCard)
        
        viewCard.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    
    
}
