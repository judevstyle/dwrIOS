//
//  InfoViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 29/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import Moya
import SwiftyXMLParser


class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
//    var sections = sectionsData
    var sections: [Section] = []
    
    let APIServiceProvider = MoyaProvider<APIService>()
    
    let cellId = "cellInfo"
    let headerId = "headerInfo"
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = .clear
        tableview.isScrollEnabled = true
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
//        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        tableview.layer.cornerRadius = 8
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "Info")
        
        
         let leftbutton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(handleClose))
                   leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        tableView.register(CollapsibleTableViewHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.register(CollapsibleTableViewCell.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(tableView)
        tableView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        // Auto resizing the height of the cell
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        getResponseInfo()
        
    }
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func getResponseInfo() {
        self.startLoding()
        
        APIServiceProvider.rx.request(.GetInfo).subscribe { event in
            switch event {
            case let .success(response):
                
                let xml = try! XML.parse(response.data)
                
                let titleDerivation: String = xml["ews", "ews01"].text!
                let detailDerivation1: String = xml["ews", "ews02"].text!
                let detailDerivation2: String = xml["ews", "ews03"].text!
                let titleObjective: String = xml["ews", "ews04"].text!
                let detailObjective: String = xml["ews", "ews05"].text!
                let titleDeveloper: String = xml["ews", "ews06"].text!
                let detailDeveloper: String = xml["ews", "ews07"].text!
                

                //ความเป็นมา
                self.sections.append(Section(name: titleDerivation, items: [
                    Item(name: "", detail: detailDerivation1),
                    Item(name: "", detail: detailDerivation2)
                ], collapsed: true))
                
                //วัตถุประสงค์
                self.sections.append(Section(name: titleObjective, items: [
                    Item(name: "", detail: detailObjective)
                ], collapsed: true))
                
                //ผู้พัฒนา
                self.sections.append(Section(name: titleDeveloper, items: [
                    Item(name: "", detail: detailDeveloper),
                ], collapsed: true))
                
                self.tableView.reloadData()
                self.stopLoding()
                break
            case let .error(error):
                self.stopLoding()
                print(error)
            }
            
        }
    }
    
}


extension InfoViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CollapsibleTableViewCell ??
            CollapsibleTableViewCell(style: .default, reuseIdentifier: cellId)
        
        let item: Item = sections[indexPath.section].items[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.detailLabel.text = item.detail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: headerId)
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
}

//
// MARK: - Section Header Delegate
//
extension InfoViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}
