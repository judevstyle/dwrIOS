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
    
    lazy var viewAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("ดูสถานการ์ณทั้งหมด", for: .normal)
        
        button.titleLabel?.font = .PrimaryRegular(size: 20)
        button.addTarget(self, action: #selector(handleAllEws), for: .touchUpInside)
        
        button.tintColor = .white
        return button
    }()
    
    
    let bgImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bg")
        image.contentMode = .scaleToFill
        
        return image
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
    
    var dashboards:[DashboardCardModel] = DashboardCardModel.dashboards()
    
    
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
        
        view.addSubview(bgImage)
        view.addSubview(tableview)
        view.addSubview(viewAllButton)
        
        
        bgImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 100, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        
        viewAllButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 16, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
        
        
        self.startLoding()
        DispatchQueue.global(qos: .background).async {
            self.dashboards = DashboardCardModel.getCountStatus()
            
            print(self.dashboards)
            DispatchQueue.main.async {
                self.stopLoding()
                self.tableview.reloadData()
            }
        }

        DispatchQueue.main.async {
            self.getCountStatus()
        }
        
    }
    
   @objc func handleAllEws()  {
         getLastData(type: "all")
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

    
    @objc func handleSlide(){
        present(menuSlide, animated: true, completion: nil)
        
    }
    
    
//    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
//        self.tableview.setConstraintConstant(constant: -95, forAttribute: .right)
//        self.viewAllButton.setConstraintConstant(constant: -95, forAttribute: .right)
//    }
//
//
//    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
//        self.tableview.setConstraintConstant(constant: -16, forAttribute: .right)
//        self.viewAllButton.setConstraintConstant(constant: -16, forAttribute: .right)
//    }
    
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
            
            switch indexPath.row {
            case 0:
                getLastData(type: "สถานการณ์ อพยพ")
            case 1:
                getLastData(type: "สถานการณ์ เตือนภัย")
            case 2:
                getLastData(type: "สถานการณ์ เฝ้าระวัง")
            case 3:
                getLastData(type: "สถานการณ์ ฝนตกเล็กน้อย")
            default:
                getLastData(type: "สถานการณ์ ฝนตกเล็กน้อย")
            }
            
        }else {
            delegateMainApp!.ToastLoading()
        }
        
        
    }
    
    func getLastData(type: String) {
        self.startLoding()
        DispatchQueue.global(qos: .background).async {
            var stations_last = LastDataModel.FetchLastData(type: type)
            
            DispatchQueue.main.async {
                if stations_last.count != 0 {
                    let rootVC = StationListViewController()
                    rootVC.stations_last = stations_last
                    let rootNC = UINavigationController(rootViewController: rootVC)
                    rootNC.modalPresentationStyle = .fullScreen
                    rootNC.modalTransitionStyle = .crossDissolve
                    self.present(rootNC, animated: true, completion: nil)
                    self.stopLoding()
                }else {
                    self.stopLoding()
                }
            }
        }
    }
    
    
    
    func ToastLoading() {
        delegateMainApp!.ToastLoading()
    }
}

