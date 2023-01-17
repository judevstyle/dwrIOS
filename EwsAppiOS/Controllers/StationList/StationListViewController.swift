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
        tableview.showsVerticalScrollIndicator = false
        tableview.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableview.layer.cornerRadius = 8
        tableview.estimatedRowHeight = 40
        tableview.rowHeight = UITableView.automaticDimension
        return tableview
    }()
    
    var viewImageBg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "overcast")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.white.withAlphaComponent(0.1)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var last_data: [LastDataModel]? = []
    var stations_last: [StationXLastDataModel]? = []
    
    var viewModel: LastDataStationProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "สรุปสถานการณ์ฝน")
        
        
         let leftbutton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(handleClose))
                   leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        
        tableview.register(CardStationViewCell.self, forCellReuseIdentifier: cellId)
        
        
        view.addSubview(viewImageBg)
        viewImageBg.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(tableview)
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        configure(LastDataViewModel())
    }
    
    
    func configure(_ interface: LastDataStationProtocol) {
        self.viewModel = interface
        bindToViewModel()
        getLastData(last_data: last_data!)
    }
    
    fileprivate func showAlert(data: StationXLastDataModel) {
        print("---")
        DispatchQueue.main.async {
            self.stations_last!.append(data)
            self.tableview.reloadData()
            self.stopLoding()
        }
    }

    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations_last!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CardStationViewCell
        
        cell.station = self.stations_last?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = DetailStationViewController()
        rootVC.stations_last = self.stations_last
        rootVC.currentPage = indexPath.item
        let rootNC = UINavigationController(rootViewController: rootVC)
        rootNC.modalPresentationStyle = .overFullScreen
        rootNC.modalTransitionStyle = .crossDissolve
        present(rootNC, animated: true, completion: nil)
    }
    
    func getLastData(last_data: [LastDataModel]) {
           self.startLoding()
          self.stations_last!.removeAll()
           DispatchQueue.global(qos: .background).async {
            var list_ew07 = Ews07Model.FetchEws07()
            let sortedLast_data = last_data.sorted(by: {$1.value! < $0.value!})
            StationXLastDataModel.mixStationXLastDataV2(last_data: sortedLast_data, list_ew07: list_ew07, viewModel: self.viewModel as! LastDataViewModel)
           }
       }
    
}



extension StationListViewController {
    
     func bindToViewModel() {
           viewModel.output.showMessageAlert = showAlert()
       }
       
       func showAlert() -> ((StationXLastDataModel) -> Void) {
           return {  [weak self] data in

               guard let weakSelf = self else { return }
               weakSelf.showAlert(data: data)
           }
       }
}
