//
//  DetailMapStationViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 29/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class DetailMapStationViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    
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
    
    var station: StationXLastDataModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "รายงาน")
      
        tableview.register(ListCardStationViewCell.self, forCellReuseIdentifier: cellIdStation)
        tableview.register(ListCardRainViewCell.self, forCellReuseIdentifier: cellIdRain)
        
        view.addSubview(tableview)
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdStation, for: indexPath) as! ListCardStationViewCell
            
            if station != nil {
                cell.station = station!
            }
            
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdRain, for: indexPath) as! ListCardRainViewCell
            
            if station != nil {
                cell.ews07 = station!.ews07
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
    
    
    
    
}
