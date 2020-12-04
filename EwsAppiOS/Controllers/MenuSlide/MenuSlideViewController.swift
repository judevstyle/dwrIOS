//
//  MenuSlideViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 18/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class MenuSlideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellSideMenu"
    
    
    var delegateDashboard: DashboardDelegateProtocol? = nil
    
    lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = .clear
        tableview.isScrollEnabled = false
        tableview.separatorStyle = .none
        
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        tableview.register(MenuSideViewCell.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(tableview)
        
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 75, heightConstant: 0)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    var mene_list = MenuSlideModel.menus()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mene_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuSideViewCell
        
        cell.menu = mene_list[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if AppDelegate.shareDelegate.stations != nil {
            switch indexPath.row {
            case 2:
                if  AppDelegate.shareDelegate.last_data_search != nil && AppDelegate.shareDelegate.stations != nil  {
                      openMenuView(controller: SearchViewController())
                }else {
                     delegateDashboard!.ToastLoading()
                }
                break
            case 3:
                if AppDelegate.shareDelegate.stations != nil {
                openMenuView(controller: MapStationViewController())
                }else {
                    delegateDashboard!.ToastLoading()
                }
                break
            case 4:
                openMenuView(controller: ReportViewController())
                break
            case 5:
                openMenuView(controller: SettingViewController())
                break
            case 6:
                openMenuView(controller: InfoViewController())
                break
            default:
                break
            }
//        }else {
//            delegateDashboard!.ToastLoading()
//        }
    }
    
    
    func openMenuView(controller: UIViewController){
        var rootVC: UIViewController! = controller
        DispatchQueue.main.async {
            let rootNC = UINavigationController(rootViewController: rootVC)
            rootNC.modalPresentationStyle = .fullScreen
            rootNC.modalTransitionStyle = .crossDissolve
            self.present(rootNC, animated: true, completion: nil)
        }
        
    }
}
