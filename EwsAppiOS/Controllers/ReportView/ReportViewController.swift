//
//  ReportViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import Moya
import SwiftyXMLParser

class ReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let APIServiceProvider = MoyaProvider<APIService>()
    
    let cellId = "cellReport"
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
        return tableview
    }()
    
    var reports_list: [ReportModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "รายงาน")
        
        
        let leftbutton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(handleClose))
        leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        tableview.register(CardReportViewCell.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(tableview)
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        
        //        self.tableview.estimatedRowHeight = tableview.frame.height/6
        
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
        getReportResponse()
    }
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func getReportResponse() {
        
        self.startLoding()
        
        APIServiceProvider.rx.request(.GetWarnReport).subscribe { event in
            switch event {
            case let .success(response):
                
                let xml = XML.parse(response.data)
                var reports = [ReportModel]()
                
                if let count = xml["ews", "station"].all?.count {
                    if count > 0 {
                        for item_report in xml["ews", "station"].all! {
                            let title = item_report.childElements[1].text!.subStringReport()
                            
                            let statusStr = title[0].subStringReportStatus()
                            
                            var status: TypeStatusWeather = .Caution
                            
                            var date: String = item_report.childElements[0].text!
                            
                            var body: String = item_report.childElements[3].text!
                            
                            
                            switch statusStr {
                            case "อพยพ":
                                status = .Evacuate
                            case "เตือนภัย":
                                status = .Caution
                            case "เฝ้าระวัง":
                                status = .Watchout
                            case "ฝนตกเล็กน้อย":
                                status = .Rain
                            default:
                                status = .Normal
                            }
                            
                            
                            reports.append(ReportModel(title: "\(title[0])", address: "สถานี \(title[1])", date: "\(date)", status: status, body: "\(body)"))
                        }
                        
                        self.reports_list = reports
                        self.tableview.reloadData()
                        self.stopLoding()
                    }
                }
                
            case let .error(error):
                self.stopLoding()
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CardReportViewCell
        
        cell.report = reports_list[indexPath.row]
        cell.noLabel.text = "\(indexPath.row+1)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = DetailReportViewController()
        rootVC.reports = self.reports_list
        rootVC.currentPage = indexPath.item
        let rootNC = UINavigationController(rootViewController: rootVC)
        rootNC.modalPresentationStyle = .overFullScreen
        rootNC.modalTransitionStyle = .crossDissolve
        present(rootNC, animated: true, completion: nil)
    }

    
    
}
