//
//  SearchViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 3/11/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import Foundation

class TypeSearch {
    enum Status {
        case main
        case region
        case dept
        case provinceRegion
        case provinceDept
        case stationDept
        case stationRegion
        case stationSearch
    }
    
    var status: Status
    
    init(status: Status) {
        self.status = status
    }
}


struct ItemSearchModel {
    
    let title : String?
    let type : TypeSearch.Status?
    
    init(title: String, type: TypeSearch.Status) {
        self.title = title
        self.type = type
    }
    
    
    static func getListItemSearchType(type: TypeSearch.Status, viewModel: SearchViewModel, selectItem: String?) {
        switch type {
        case .main:
            viewModel.input.saveItem(item: ItemSearchModel(title: "ภาคตามภูมิศาสตร์\nประเทศไทย", type: .main))
            viewModel.input.saveItem(item: ItemSearchModel(title: "สำนักงานทรัพยากรน้ำ\nกรมทรัพยากรน้ำ", type: .main))
            break
        case .region:
            for (item) in filterRegion() {
                viewModel.input.saveItem(item: item)
            }
        case .dept:
            for (item) in filterDept() {
                viewModel.input.saveItem(item: item)
            }
        case .provinceRegion:
            for (item) in filterProvinceRegion(selectRegion: selectItem!) {
                viewModel.input.saveItem(item: item)
            }
        case .provinceDept:
            for (item) in filterProvinceDept(selectDept: selectItem!) {
                viewModel.input.saveItem(item: item)
            }
            break
        case .stationDept:
            for (item) in filterStation(selectItem: selectItem!, type: .stationDept) {
                viewModel.input.saveItem(item: item)
            }
            break
        case .stationRegion:
            for (item) in filterStation(selectItem: selectItem!, type: .stationRegion) {
                viewModel.input.saveItem(item: item)
            }
            break
        case .stationSearch:
            viewModel.input.resetData(status: true)
            for (item) in filterStationSearch(selectItem: selectItem!, type: .stationSearch) {
                viewModel.input.saveItem(item: item)
            }
            break
        default:
            break
        }
    }
    
    static func filterRegion() -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listRegion:[String] = []
        
        for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
            if index == 0 {
                listRegion.append(item.region!)
                list.append(ItemSearchModel(title: item.region!, type: .region))
            }else {
                var isCheckRegion = false
                for region in listRegion {
                    if region == item.region {
                        isCheckRegion = true
                    }
                }
                if !isCheckRegion {
                    listRegion.append(item.region!)
                    list.append(ItemSearchModel(title: item.region!, type: .region))
                }
            }
        }
        
        return list
    }
    
    static func filterDept() -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listDept:[String] = []
        
        for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
            if index == 0 {
                listDept.append(item.dept!)
                list.append(ItemSearchModel(title: item.dept!, type: .dept))
            }else {
                var isCheckDept = false
                for dept in listDept {
                    if dept == item.dept {
                        isCheckDept = true
                    }
                }
                if !isCheckDept {
                    listDept.append(item.dept!)
                    list.append(ItemSearchModel(title: item.dept!, type: .dept))
                }
            }
        }
        
        return list
    }
    
    
    static func filterProvinceRegion(selectRegion: String) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listProvince:[String] = []
        
        for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
            
            if selectRegion == item.region {
                if index == 0 {
                    listProvince.append(item.province!)
                    list.append(ItemSearchModel(title: item.province!, type: .provinceRegion))
                }else {
                    var isCheckProvince = false
                    for province in listProvince {
                        if province == item.province {
                            isCheckProvince = true
                        }
                    }
                    if !isCheckProvince {
                        listProvince.append(item.province!)
                        list.append(ItemSearchModel(title: item.province!, type: .provinceRegion))
                    }
                }
            }
        }
        
        return list
    }
    
    
    static func filterProvinceDept(selectDept: String) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listProvince:[String] = []
        
        for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
            
            if selectDept == item.dept {
                if index == 0 {
                    listProvince.append(item.province!)
                    list.append(ItemSearchModel(title: item.province!, type: .provinceDept))
                }else {
                    var isCheckProvince = false
                    for province in listProvince {
                        if province == item.province {
                            isCheckProvince = true
                        }
                    }
                    if !isCheckProvince {
                        listProvince.append(item.province!)
                        list.append(ItemSearchModel(title: item.province!, type: .provinceDept))
                    }
                }
            }
        }
        
        return list
    }
    
    
    static func filterStation(selectItem: String, type: TypeSearch.Status) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listProvince:[String] = []
        
        for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
            
            if selectItem == item.province! {
                if index == 0 {
                    listProvince.append(item.title!)
                    list.append(ItemSearchModel(title: item.title!, type: type))
                }else {
                    var isCheckProvince = false
                    for province in listProvince {
                        if province == item.province {
                            isCheckProvince = true
                        }
                    }
                    if !isCheckProvince {
                        listProvince.append(item.title!)
                        list.append(ItemSearchModel(title: item.title!, type: type))
                    }
                }
            }
            
        }
        
        return list
    }
    
    
    static func filterStationSearch(selectItem: String, type: TypeSearch.Status) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
            
            if item.title!.contains(selectItem) {
                list.append(ItemSearchModel(title: item.title!, type: type))
            }
        }
        
//        print(list.count)
        return list
    }
    
    
    static func filterSelectStation(ListItem: [ItemSearchModel]) -> [StationXLastDataModel] {
        var ListitemStation:[StationXLastDataModel] = []
        for name in ListItem {
            for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
                if name.title! == item.title! {
                    ListitemStation.append(item)
                }
            }
        }
        return ListitemStation
    }
    
    
}

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let cellId = "cellSearch"
    
    var viewModel: SearchProtocol!
    
    var currentTypePage: TypeSearch.Status = .main
    var lastTypePage: TypeSearch.Status = .main
    var lastSelectRegion: String = ""
    var lastSelectDept: String = ""
    var lastSelectProvince: String = ""
    var lastSelectStation: String = ""
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .default
        search.placeholder = " Search..."
        search.sizeToFit()
        search.tintColor = .white
        search.isTranslucent = false
        search.delegate = self
        search.barStyle = .black
        return search
    }()
    
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
    
    var typeSearch:TypeSearch = TypeSearch(status: .region)
    var list: [ItemSearchModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "ค้นหา")
        
        let leftbutton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(handleCloseOrBack))
        leftbutton.tintColor = .white
        self.hideKeyboardWhenTappedAround()
        
        leftbutton.tintColor = .white
        navigationItem.leftBarButtonItem = leftbutton
        tableview.register(CardSearchItemViewCell.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(searchBar)
        searchBar.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(tableview)
        tableview.anchor(searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        searchBar.clearBackgroundColor()
       
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.PrimaryRegular(size: 18)]
        
        configure(SearchViewModel())
    }
    
    
    func configure(_ interface: SearchProtocol) {
        self.viewModel = interface
        bindToViewModel()
        self.list.removeAll()
        ItemSearchModel.getListItemSearchType(type: .main, viewModel: viewModel as! SearchViewModel, selectItem: nil)
    }
    
    
    fileprivate func RenderResetData(status: Bool){
        DispatchQueue.main.async {
//            print("Remove")
            if status {
                self.list.removeAll()
                self.tableview.reloadData()
            }
        }
    }
    
    fileprivate func RenderItemCell(item: ItemSearchModel) {
        DispatchQueue.main.async {
            self.typeSearch.status = item.type!
            self.currentTypePage = self.typeSearch.status
            
            switch self.currentTypePage {
            case .main:
                self.setTitleNavigation(title: "ค้นหา")
            case .dept:
                self.setTitleNavigation(title: "ค้นหาตามสำนักงาน")
            case .region:
                self.setTitleNavigation(title: "ค้นหาตามภาค")
            case .provinceDept, .provinceRegion:
                self.setTitleNavigation(title: "ค้นหาตามจังหวัด")
            case .stationRegion, .stationDept, .stationSearch:
                self.setTitleNavigation(title: "ค้นหาตามชื่อสถานี")
            default:
                self.setTitleNavigation(title: "ค้นหา")
            }
            self.list.append(item)
            self.tableview.reloadData()
            self.stopLoding()
        }
    }
    
    @objc func handleCloseOrBack(){
        switch currentTypePage {
        case .main:
            dismiss(animated: true, completion: nil)
            break
        case .dept, .region:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .main, viewModel: viewModel as! SearchViewModel, selectItem: nil)
            break
        case .provinceDept:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .dept, viewModel: viewModel as! SearchViewModel, selectItem: nil)
            break
        case .provinceRegion:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .region, viewModel: viewModel as! SearchViewModel, selectItem: nil)
            break
        case .stationRegion:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .provinceRegion, viewModel: viewModel as! SearchViewModel, selectItem: lastSelectRegion)
            break
        case .stationDept:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .provinceDept, viewModel: viewModel as! SearchViewModel, selectItem: lastSelectDept)
            break
        case .stationSearch:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .main, viewModel: viewModel as! SearchViewModel, selectItem: nil)
            break
        default:
            print("nil")
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .stationSearch, viewModel: viewModel as! SearchViewModel, selectItem: searchText)
        }else {
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .main, viewModel: viewModel as! SearchViewModel, selectItem: nil)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch typeSearch.status {
        case .main:
            return tableView.frame.size.height/2
        default:
            return 90
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CardSearchItemViewCell
        
        cell.item = self.list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.list[indexPath.row].type {
        case .main:
            self.list.removeAll()
            if indexPath.row == 0 {
                ItemSearchModel.getListItemSearchType(type: .region, viewModel: viewModel as! SearchViewModel, selectItem: nil)
                lastTypePage = .main
                currentTypePage = .region
            }else {
                ItemSearchModel.getListItemSearchType(type: .dept, viewModel: viewModel as! SearchViewModel, selectItem: nil)
                lastTypePage = .main
                currentTypePage = .dept
            }
            break
        case .region:
            var selectItem = self.list[indexPath.row].title
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .provinceRegion, viewModel: viewModel as! SearchViewModel, selectItem: selectItem)
            lastTypePage = .region
            currentTypePage = .provinceRegion
            lastSelectRegion = selectItem!
            break
        case .dept:
            var selectItem = self.list[indexPath.row].title
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .provinceDept, viewModel: viewModel as! SearchViewModel, selectItem: selectItem)
            lastTypePage = .dept
            currentTypePage = .provinceDept
            lastSelectDept = selectItem!
            break
        case .provinceDept:
            var selectItem = self.list[indexPath.row].title
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .stationDept, viewModel: viewModel as! SearchViewModel, selectItem: selectItem)
            lastTypePage = .provinceDept
            currentTypePage = .stationDept
            lastSelectProvince = selectItem!
            break
        case .provinceRegion:
            var selectItem = self.list[indexPath.row].title
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .stationRegion, viewModel: viewModel as! SearchViewModel, selectItem: selectItem)
            lastTypePage = .provinceRegion
            currentTypePage = .stationRegion
            lastSelectProvince = selectItem!
            break
        case .stationRegion, .stationDept, .stationSearch:
            self.startLoding()
            var selectItem: Int = 0
            DispatchQueue.global(qos: .background).async {
                let LisItemStation = ItemSearchModel.filterSelectStation(ListItem: self.list)
                DispatchQueue.main.async {
                    self.stopLoding()
                    for (index, item) in LisItemStation.enumerated() {
                        if  self.list[indexPath.row].title == item.title! {
                            selectItem = index
                        }
                    }
                    
                    let rootVC = DetailStationViewController()
                    rootVC.stations_last = LisItemStation
                    rootVC.currentPage = selectItem
                    let rootNC = UINavigationController(rootViewController: rootVC)
                    rootNC.modalPresentationStyle = .overFullScreen
                    rootNC.modalTransitionStyle = .crossDissolve
                    self.present(rootNC, animated: true, completion: nil)
                }
            }
            
            break
        default:
            print("nil")
        }
        
    }
    
}

extension SearchViewController {
    
    func bindToViewModel() {
        viewModel.output.RenderItemCell = RenderItemCell()
        viewModel.output.RenderResetData = RenderResetData()
    }
    
    func RenderItemCell() -> ((ItemSearchModel) -> Void) {
        return {  [weak self] data in
            
            guard let weakSelf = self else { return }
            weakSelf.RenderItemCell(item: data)
        }
    }
    
    func RenderResetData() -> ((Bool) -> Void) {
        return {  [weak self] data in
            
            guard let weakSelf = self else { return }
            weakSelf.RenderResetData(status: data)
        }
    }
}


protocol SearchProtocolInput {
    func saveItem(item: ItemSearchModel?)
    func resetData(status: Bool?)
}

protocol SearchProtocolOutput: class {
    var RenderItemCell: ((ItemSearchModel) -> Void)? {get set}
    var RenderResetData: ((Bool) -> Void)? {get set}
    var didError: (() -> Void)? {get set}
}

protocol SearchProtocol: SearchProtocolInput, SearchProtocolOutput {
    var input : SearchProtocolInput { get }
    var output : SearchProtocolOutput { get }
}


//ViewModel
class SearchViewModel: SearchProtocol, SearchProtocolOutput {
    
    var input: SearchProtocolInput { return self }
    var output: SearchProtocolOutput { return self }
    
    //Data-Binding
    var RenderItemCell: ((ItemSearchModel) -> Void)?
    var RenderResetData: ((Bool) -> Void)?
    var didError: (() -> Void)?
    
}


extension SearchViewModel: SearchProtocolInput {
    func resetData(status: Bool?) {
        guard let item = status,
            item != false else {
                didError?()
                return
        }
       RenderResetData?(item)
    }
    
    
    
    func saveItem(item: ItemSearchModel?) {
        guard let new_data = item,
            new_data != nil else {
                didError?()
                return
        }
        RenderItemCell?(new_data)
    }
    
    
}
