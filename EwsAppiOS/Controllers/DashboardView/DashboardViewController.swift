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
import Moya
import Toast_Swift

protocol DashboardDelegateProtocol {
    func ToastLoading()
}


class DashboardViewController: UIViewController, SideMenuNavigationControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, DashboardDelegateProtocol {
    
    
    var delegateMainApp: MainAppDelegateProtocol? = nil
    
    var ValueWarningStations:[String] = ["0","0","0","0"]
    var TitleWarningStations:[String] = ["อพยพ","เตือนภัย","เฝ้าระวัง","มีฝน"]
    
    let APIServiceProvider = MoyaProvider<APIService>()
    
    lazy var viewAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("ดูสถานการณ์ทั้งหมด", for: .normal)
        
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
        self.setTitleNavigation(title: "สรุปสถานการณ์ฝน")
        
        let leftbutton = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .done, target: self, action: #selector(handleSlide))
        
        leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        tableview.register(DashboardView.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(bgImage)
        view.addSubview(tableview)
        view.addSubview(viewAllButton)
        
        
        bgImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 100, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        
        viewAllButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 16, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
        
        
        //        self.startLoding()
        //        DispatchQueue.global(qos: .background).async {
        //            self.dashboards = DashboardCardModel.getCountStatus()
        //
        //
        //            DispatchQueue.main.async {
        //                self.tableview.reloadData()
        //            }
        //        }
        
        DispatchQueue.main.async {
            self.getCountStatus()
        }
        
    }
    
    @objc func handleAllEws()  {
        getDataByType(type: "all")
    }
    
    
    func getCountStatus() {
        APIServiceProvider.rx.request(.GetCountStatus).subscribe { event in
            switch event {
            case let .success(response):
                let xml = XML.parse(response.data)
                let status3 = xml["ews"]["status1"]
                let status2 = xml["ews"]["status2"]
                let status1 = xml["ews"]["status3"]
                let status4 = xml["ews"]["status9"]
                
                self.dashboards[0].value = status1.text ?? "0"
                self.dashboards[1].value = status2.text ?? "0"
                self.dashboards[2].value = status3.text ?? "0"
                self.dashboards[3].value = status4.text ?? "0"
                self.tableview.reloadData()
                
            case let .error(error):
                self.dashboards[0].value = "0"
                self.dashboards[1].value = "0"
                self.dashboards[2].value = "0"
                self.dashboards[3].value = "0"
            }
        }
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
                getLastData(type: "สถานการณ์ อพยพ", index: indexPath.row)
            case 1:
                getLastData(type: "สถานการณ์ เตือนภัย", index: indexPath.row)
            case 2:
                getLastData(type: "สถานการณ์ เฝ้าระวัง", index: indexPath.row)
            case 3:
                getLastData(type: "สถานการณ์ ฝนตกเล็กน้อย", index: indexPath.row)
            default:
                getLastData(type: "สถานการณ์ ฝนตกเล็กน้อย", index: indexPath.row)
            }
            
        }else {
            delegateMainApp!.ToastLoading()
        }
        
    }
    
    func getLastData(type: String, index: Int) {
        
        if dashboards[index].value.toDouble() != 0 {
            getDataByType(type: type)
        }else {
            ToastAlert(text: "ไม่มีข้อมูล", duration: 1.5)
        }
        
    }
    
    
    func getDataByType(type: String){
        
        if type == "สถานการณ์ ฝนตกเล็กน้อย" {
            self.startLoding()
            APIServiceProvider.rx.request(.GetLastData).subscribe { event in
                switch event {
                case let .success(response):
                    var last_data = [LastDataModel]()
                    let xml = XML.parse(response.data)
                    
                    if let count = xml["ews", "station"].all?.count {
                        if count > 0 {
                            if let lisXml = xml["ews", "station"].all {
                                for item_station in lisXml {
                                    if item_station.childElements[11].name == "status" && item_station.childElements[11].text! == "\(type)"{
                                        let myDouble = Double(item_station.childElements[4].text ?? "0.0") ?? 0.0
                                        let rainDouble = Double(item_station.childElements[12].text ?? "0.0") ?? 0.0
                                        let wlDouble = Double(item_station.childElements[13].text ?? "0.0") ?? 0.0
                                        
                                        var valueTitle:Double = 0
                                        if item_station.childElements[11].text == "สถานการณ์ ฝนตกเล็กน้อย" {
                                            valueTitle = myDouble
                                        }else {
                                            if item_station.childElements[0].text == "rain" {
                                                valueTitle = rainDouble
                                            } else {
                                                valueTitle = wlDouble
                                            }
                                        }
                                        
                                        last_data.append(
                                            LastDataModel(
                                                stn: item_station.attributes["stn"]!,
                                                warning_type: item_station.childElements[0].text ?? "",
                                                date: item_station.childElements[1].text ?? "",
                                                temp: item_station.childElements[2].text ?? "",
                                                rain: item_station.childElements[3].text ?? "",
                                                rain12h: myDouble,
                                                rain07h: item_station.childElements[5].text ?? "",
                                                rain24h: item_station.childElements[6].text ?? "",
                                                wl: item_station.childElements[7].text ?? "",
                                                wl07h: item_station.childElements[8].text ?? "",
                                                soil: item_station.childElements[9].text ?? "",
                                                pm25: item_station.childElements[10].text ?? "",
                                                status: item_station.childElements[11].text ?? "",
                                                warn_rf: rainDouble,
                                                warn_wl: wlDouble,
                                                stn_cover: item_station.childElements[14].text ?? "",
                                                value: valueTitle
                                            )
                                        )
                                    }
                                }
                            }
                            self.stopLoding()
                            if last_data.count > 0 {
                                self.goToStationList(stations_last: last_data)
                            }else{
                                self.ToastAlert(text: "ไม่มีข้อมูล", duration: 1.5)
                            }
                        }
                        
                    }
                    break
                case let .error(error):
                    print(error)
                    self.stopLoding()
                }
            }
        }else {
            self.startLoding()
            APIServiceProvider.rx.request(.GetWarnData).subscribe { event in
                switch event {
                case let .success(response):
                    var last_data = [LastDataModel]()
                    let xml = XML.parse(response.data)
                    if type == "all" {
                        let all = xml["ews", "station"].all
                        if all?.count != nil {
                            if let lisXml = xml["ews", "station"].all {
                                for item_station in lisXml {
                                    if item_station.childElements[11].name == "status" && item_station.childElements[11].text! != "กำลังเชื่อมต่อสัญญาน" && item_station.childElements[11].text! != "สถานการณ์ ปกติ" {
                                        
                                        let myDouble = Double(item_station.childElements[4].text ?? "0.0") ?? 0.0
                                        let rainDouble = Double(item_station.childElements[12].text ?? "0.0") ?? 0.0
                                        let wlDouble = Double(item_station.childElements[13].text ?? "0.0") ?? 0.0
                                        
                                        var valueTitle:Double = 0
                                        if item_station.childElements[11].text == "สถานการณ์ ฝนตกเล็กน้อย" {
                                            valueTitle = myDouble
                                        }else {
                                            if item_station.childElements[0].text == "rain" {
                                                valueTitle = rainDouble
                                            } else {
                                                valueTitle = wlDouble
                                            }
                                        }
                                        
                                        last_data.append(
                                            LastDataModel(
                                                stn: item_station.attributes["stn"]!,
                                                warning_type: item_station.childElements[0].text ?? "",
                                                date: item_station.childElements[1].text ?? "",
                                                temp: item_station.childElements[2].text ?? "",
                                                rain: item_station.childElements[3].text ?? "",
                                                rain12h: myDouble,
                                                rain07h: item_station.childElements[5].text ?? "",
                                                rain24h: item_station.childElements[6].text ?? "",
                                                wl: item_station.childElements[7].text ?? "",
                                                wl07h: item_station.childElements[8].text ?? "",
                                                soil: item_station.childElements[9].text ?? "",
                                                pm25: item_station.childElements[10].text ?? "",
                                                status: item_station.childElements[11].text ?? "",
                                                warn_rf: rainDouble,
                                                warn_wl: wlDouble,
                                                stn_cover: item_station.childElements[14].text ?? "",
                                                value: valueTitle
                                            )
                                        )
                                        
                                    }
                                }
                            }
                        }
                        
                        self.stopLoding()
                        if last_data.count > 0 {
                            self.goToStationList(stations_last: last_data)
                        }else{
                            self.ToastAlert(text: "ไม่มีข้อมูล", duration: 1.5)
                        }
                    }else {
                        
                        if let lisXml = xml["ews", "station"].all {
                            for item_station in lisXml {
                                if item_station.childElements[11].name == "status" && item_station.childElements[11].text! == "\(type)"{
                                    let myDouble = Double(item_station.childElements[4].text ?? "0.0") ?? 0.0
                                    let rainDouble = Double(item_station.childElements[12].text ?? "0.0") ?? 0.0
                                    let wlDouble = Double(item_station.childElements[13].text ?? "0.0") ?? 0.0
                                    
                                    var valueTitle:Double = 0.0
                                    if item_station.childElements[11].text == "สถานการณ์ ฝนตกเล็กน้อย" {
                                        valueTitle = myDouble
                                    }else {
                                        if item_station.childElements[0].text == "rain" {
                                            valueTitle = rainDouble
                                        }else {
                                            valueTitle = wlDouble
                                        }
                                    }
                                    
                                    last_data.append(
                                        LastDataModel(
                                            stn: item_station.attributes["stn"]!,
                                            warning_type: item_station.childElements[0].text ?? "",
                                            date: item_station.childElements[1].text ?? "",
                                            temp: item_station.childElements[2].text ?? "",
                                            rain: item_station.childElements[3].text ?? "",
                                            rain12h: myDouble,
                                            rain07h: item_station.childElements[5].text ?? "",
                                            rain24h: item_station.childElements[6].text ?? "",
                                            wl: item_station.childElements[7].text ?? "",
                                            wl07h: item_station.childElements[8].text ?? "",
                                            soil: item_station.childElements[9].text ?? "",
                                            pm25: item_station.childElements[10].text ?? "",
                                            status: item_station.childElements[11].text ?? "",
                                            warn_rf: rainDouble,
                                            warn_wl: wlDouble,
                                            stn_cover: item_station.childElements[14].text ?? "",
                                            value: valueTitle
                                        )
                                    )
                                }
                            }
                        }
                        self.stopLoding()
                        if last_data.count > 0 {
                            self.goToStationList(stations_last: last_data)
                        }else {
                            self.ToastAlert(text: "ไม่มีข้อมูล", duration: 1.5)
                        }
                    }
                    
                    break
                case let .error(error):
                    self.stopLoding()
                    print(error)
                }
            }
        }
    }
    
    
    func goToStationList(stations_last: [LastDataModel]) {
        let rootVC = StationListViewController()
        rootVC.last_data = stations_last
        let rootNC = UINavigationController(rootViewController: rootVC)
        rootNC.modalPresentationStyle = .fullScreen
        rootNC.modalTransitionStyle = .crossDissolve
        self.present(rootNC, animated: true, completion: nil)
    }
    
    func ToastLoading() {
        delegateMainApp!.ToastLoading()
    }
}

