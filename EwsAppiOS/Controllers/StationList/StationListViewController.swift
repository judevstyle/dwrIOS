//
//  StationListViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 16/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import SwiftyXMLParser

class StationListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    let cellId = "cellStation"
    
    
    lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = .clear
        tableview.isScrollEnabled = true
        tableview.separatorStyle = .none
        tableview.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableview.layer.cornerRadius = 8
        return tableview
    }()
    
    
    
    var StatusType: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.getLastData()
            }
        }
    }
    
    
    
    var stations_last: [StationXLastDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "สรุปสถานการ์ณฝน")
        
        
        let leftbutton = UIBarButtonItem(image: UIImage(systemName:  "clear"), style: .done, target: self, action: #selector(handleClose))
        
        leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        
        tableview.register(CardStationViewCell.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(tableview)
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
    }
    
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
        
    }
    
    func getLastData() {
        
        self.startLoding()
        DispatchQueue.global(qos: .background).async {
            self.stations_last = LastDataModel.FetchLastData(type: self.StatusType!)
            
            DispatchQueue.main.async {
                print(self.stations_last.count)
                self.stopLoding()
                self.tableview.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations_last.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CardStationViewCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/4.0
    }
    
}
