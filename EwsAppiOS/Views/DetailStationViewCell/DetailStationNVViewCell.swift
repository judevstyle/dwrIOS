//
//  DetailStationNVViewCell.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/5/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
import UIKit

class DetailStationNVViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
    }
    
    let cellIdStation = "cellStation"
    let cellIdRain = "cellRain"
    
    lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = .clear
        tableview.isScrollEnabled = true
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableview.layer.cornerRadius = 8
        return tableview
    }()

    var station: WarningStation? {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    self?.setupValue()
                }
            }
        }
    
    func setupViewCell()  {
        backgroundColor = .AppPrimaryDark()
        
        tableview.register(ListCardStationNVViewCell.self, forCellReuseIdentifier: cellIdStation)
        tableview.register(ListCardRainNVViewCell.self, forCellReuseIdentifier: cellIdRain)
        
        addSubview(tableview)
        tableview.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdStation, for: indexPath) as! ListCardStationNVViewCell
            
            if station != nil {
                cell.station = station!
                       }
            
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdRain, for: indexPath) as! ListCardRainNVViewCell

            if station != nil {
                cell.ews07 = station!
                cell.indexPath = indexPath
            }
            
            return cell
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 170
        }else {
            return 90
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupValue() {
        
        tableview.reloadData()
        
    }
    
}
