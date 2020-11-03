//
//  CardReportViewCell.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 28/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class CardReportViewCell: UITableViewCell {
    
    lazy var viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.3)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 28/2
        view.layer.masksToBounds = true
        return view
    }()
    
    let noLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = .PrimaryRegular(size: 17)
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .PrimaryRegular(size:17)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.text = "แจ้งเฝ้าระวัง ด้วยระดับน้ำ ระดับน้ำสูง"
        label.minimumScaleFactor = 0.4
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
//        label.addCharactersSpacing(spacing: 0.6, txt: "แจ้ง เฝ้าระวัง ด้วยระดับน้ำ ระดับน้ำสูง")
        return label
    }()
    
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .PrimaryLight(size: 15)
        label.textAlignment = .center
        label.text = "สถานี บ้านหูเเร่ ต.ทุ่งตำเสา อ.เมือง จ.สงขลา /n สถานี บ้านหูเเร่ ต.ทุ่งตำเสา อ.เมือง จ.สงขลา"
        
        return label
    }()
    
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.font = .PrimaryLight(size: 13)
        label.text = "วันที่ 22 เดือน ตุลาคม พ.ศ. 2563 เวลา 19.57.00"
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    var report: ReportModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.setupValue()
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        backgroundColor = .clear
        separatorInset = .zero
        layoutMargins = .zero
        selectionStyle = .none
        
        contentView.addSubview(viewCard)
        
        viewCard.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        viewCard.addSubview(circleView)
        circleView.anchor(viewCard.topAnchor, left: viewCard.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 28, heightConstant: 28)
        
        circleView.addSubview(noLabel)
        noLabel.anchor(circleView.topAnchor, left: circleView.leftAnchor, bottom: circleView.bottomAnchor, right: circleView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        viewCard.addSubview(titleLabel)
        titleLabel.anchor(nil, left: circleView.rightAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        titleLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        
        
        viewCard.addSubview(addressLabel)
        addressLabel.anchor(circleView.bottomAnchor, left: viewCard.leftAnchor, bottom: nil, right: viewCard.rightAnchor, topConstant: 3, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        viewCard.addSubview(dateLabel)
        dateLabel.anchor(addressLabel.bottomAnchor, left: viewCard.leftAnchor, bottom: viewCard.bottomAnchor, right: viewCard.rightAnchor, topConstant: 3, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: 0, heightConstant: 0)
    }
    
    func setupValue()  {
        titleLabel.text = "\(report!.title!)"
        addressLabel.text = "\(report!.address!)"
        
        UIView.animate(withDuration: 0.2) {
            self.contentView.layoutIfNeeded()
        }
        
        self.setNeedsDisplay()
        self.setNeedsLayout()
        
    }
    
}
