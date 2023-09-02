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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.PrimaryRegular(size: 25)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    
    var item: ItemSearchModel? {
        didSet {
            setupValueCell()
        }
    }
    
    func setupViewCell() {
        
        backgroundColor = .clear
        separatorInset = .zero
        layoutMargins = .zero
        selectionStyle = .none
        
        contentView.addSubview(viewCard)
        
        viewCard.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        viewCard.addSubview(titleLabel)
        titleLabel.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: viewCard.bottomAnchor, right: viewCard.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
    }
    
    
    func setupValueCell() {
        titleLabel.text = "\(item!.title!)"
        switch item!.type! {
        case .dept :
            let aString = "\(item!.title!)"
            let newString = aString.replacingOccurrences(of: "สทภ", with: "สทน")
            titleLabel.text = newString

            break
        case .main:
            titleLabel.numberOfLines = 2
            titleLabel.font = UIFont.PrimaryRegular(size: 25)
            break
        case .region:
            titleLabel.numberOfLines = 1
            titleLabel.font = UIFont.PrimaryRegular(size: 20)
            switch item!.title {
            case "C":
                titleLabel.text = "ภาคกลาง"
                break
            case "W":
                titleLabel.text = "ภาคตะวันตก"
                break
            case "E":
                titleLabel.text = "ภาคตะวันออก"
                break
            case "NE":
                titleLabel.text = "ภาคตะวันออกเฉียงเหนือ"
                break
            case "S":
                titleLabel.text = "ภาคใต้"
                break
            case "N":
                titleLabel.text = "ภาคเหนือ"
                break
            default:
                titleLabel.text = "ภาคกลาง"
                break
            }
            break
        default:
            titleLabel.numberOfLines = 1
            titleLabel.font = UIFont.PrimaryRegular(size: 20)
        }
    }
    
    
}
