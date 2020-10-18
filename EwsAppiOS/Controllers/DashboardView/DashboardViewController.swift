//
//  DashboardViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 18/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import SideMenu
import SwiftyXMLParser

protocol DashboardDelegateProtocol {
    func ToastLoading()
}


class DashboardViewController: UIViewController, SideMenuNavigationControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, DashboardDelegateProtocol {
    
    
    var delegateMainApp: MainAppDelegateProtocol? = nil
    
    var ValueWarningStations:[String] = ["0","0","0","0"]
    var TitleWarningStations:[String] = ["อพยพ","เตือนภัย","เฝ้าระวัง","มีฝน"]
    
    let viewAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("ดูสถานการ์ณทั้งหมด", for: .normal)
        
        button.titleLabel?.font = .PrimaryRegular(size: 20)
        
        button.tintColor = .white
        return button
    }()
    
    
    let cellId = "cellDashboard"
    
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
    
    
    
    lazy var  menuSlide: SideMenuNavigationController = {
        let rootVc = MenuSlideViewController()
        rootVc.delegateDashboard = self
        let menu = SideMenuNavigationController(rootViewController: rootVc)
        menu.leftSide = true
        menu.delegate = self
        menu.menuWidth = 75
        return menu
    }()
    
    
    var topConstraint = NSLayoutConstraint()
    
    var dashboards = DashboardCardModel.dashboards()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "สรุปสถานการ์ณฝน")
        
        let leftbutton = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(handleSlide))
        
        leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        tableview.register(DashboardView.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(tableview)
        view.addSubview(viewAllButton)
        
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 100, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        
        viewAllButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 16, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
        setupView()
        
        DispatchQueue.main.async {
            self.getCountStatus()
        }
        
    }
    
    
    func getCountStatus() {
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        let urlString = URL(string: "\(baseURL)/count_status_vill.xml")
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        let status3 = xml["ews"]["status1"]
        let status2 = xml["ews"]["status2"]
        let status1 = xml["ews"]["status3"]
        let status4 = xml["ews"]["status9"]
        
        dashboards[0].value = status1.text ?? ""
        dashboards[1].value = status2.text ?? ""
        dashboards[2].value = status3.text ?? ""
        dashboards[3].value = status4.text ?? ""
        
        self.tableview.reloadData()
    }
    
    
    func setupView() {
        
    }
    
    @objc func handleSlide(){
        present(menuSlide, animated: true, completion: nil)
        
    }
    
    
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
        
        self.tableview.setConstraintConstant(constant: -95, forAttribute: .right)
        self.viewAllButton.setConstraintConstant(constant: -95, forAttribute: .right)
    }
    
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.tableview.setConstraintConstant(constant: -16, forAttribute: .right)
        self.viewAllButton.setConstraintConstant(constant: -16, forAttribute: .right)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DashboardView
        
        cell.dashboard = dashboards[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/CGFloat(dashboards.count)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if AppDelegate.shareDelegate.stations != nil {
            
            let rootVC = StationListViewController()
            
            switch indexPath.row {
            case 0:
                rootVC.StatusType = "สถานการณ์ อพยพ"
            case 1:
                rootVC.StatusType = "สถานการณ์ เตือนภัย"
            case 2:
                rootVC.StatusType = "สถานการณ์ เฝ้าระวัง"
            case 3:
                rootVC.StatusType = "สถานการณ์ ฝนตกเล็กน้อย"
            default:
                rootVC.StatusType = "สถานการณ์ ฝนตกเล็กน้อย"
            }
            let rootNC = UINavigationController(rootViewController: rootVC)
            rootNC.modalPresentationStyle = .fullScreen
            rootNC.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                self.present(rootNC, animated: true, completion: nil)
            }
        }else {
            delegateMainApp!.ToastLoading()
        }
        
        
    }
    
    
    func ToastLoading() {
        delegateMainApp!.ToastLoading()
    }
}



