//
//  SearchViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 3/11/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import Foundation
import Moya
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
    var valuePosition : Int = 0

    init(title: String, type: TypeSearch.Status) {
        self.title = title
        self.type = type
    }
    
    
    static func getListItemSearchType(type: TypeSearch.Status, viewModel: SearchViewModel, selectItem: String?,data:Any?) {
        switch type {
        case .main:
            viewModel.input.saveItem(item: ItemSearchModel(title: "ภาคตามภูมิศาสตร์\nประเทศไทย", type: .main))
            viewModel.input.saveItem(item: ItemSearchModel(title: "สำนักงานทรัพยากรน้ำ\nกรมทรัพยากรน้ำ", type: .main))
            break
        case .region:
            for (item) in filterRegion(data: data as! [RegionModel]) {
                viewModel.input.saveItem(item: item)
            }
        case .dept:
            for (item) in filterDept(data: data as! [DepartModel]) {
                viewModel.input.saveItem(item: item)
            }
        case .provinceRegion:
            for (item) in filterProvinceRegion(selectRegion: selectItem!,data: data as! [String]) {
                viewModel.input.saveItem(item: item)
            }
        case .provinceDept:
            for (item) in filterProvinceDept(selectDept: selectItem!,data: data as! [String]) {
                viewModel.input.saveItem(item: item)
            }
            break
        case .stationDept:
            for (item) in filterStation(selectItem: selectItem!, type: .stationDept,data: data as! [WarningStation]) {
                viewModel.input.saveItem(item: item)
            }
            break
        case .stationRegion:
            for (item) in filterStation(selectItem: selectItem!, type: .stationRegion,data: data as! [WarningStation]) {
                viewModel.input.saveItem(item: item)
            }
            break
        case .stationSearch:
            viewModel.input.resetData(status: true)
            for (item) in filterStationSearch(selectItem: selectItem!, type: .stationSearch,data: data as! [String]) {
                viewModel.input.saveItem(item: item)
            }
            break
        default:
            break
        }
    }
    
    static func filterRegion(data:[RegionModel]) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listRegion:[String] = []
        
        
        for (index,item) in data.enumerated() {
            if index == 0 {
                listRegion.append(item.full_name!)
                list.append(ItemSearchModel(title: item.full_name!, type: .region))
            }else {
                
                    var isCheckRegion = false
                    for region in listRegion {
                        if region.trim() == item.full_name?.trim() {
                            isCheckRegion = true
                        }
                    }
                    if !isCheckRegion {
                        listRegion.append(item.full_name!)
                        list.append(ItemSearchModel(title: item.full_name!, type: .region))
                    }
                
               
            }
        }
        
        
        
//        for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
//            if index == 0 {
//                listRegion.append(item.region!)
//                list.append(ItemSearchModel(title: item.region!, type: .region))
//            }else {
//                
//                if item.region != " " || item.region != "" {
//                    var isCheckRegion = false
//                    for region in listRegion {
//                        if region.trim() == item.region?.trim() {
//                            isCheckRegion = true
//                        }
//                    }
//                    if !isCheckRegion {
//                        listRegion.append(item.region!)
//                        list.append(ItemSearchModel(title: item.region!, type: .region))
//                    }
//                }
//               
//            }
//        }
//        
        
        print("region \(list)")
        
        return list
    }
    
    static func filterDept(data:[DepartModel]) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listDept:[String] = []
        //print("filterDept --- \(AppDelegate.shareDelegate.last_data_search.count)")
        
        for (index,item) in data.enumerated() {
            if index == 0 {
                listDept.append(item.name!)
                list.append(ItemSearchModel(title: item.name!, type: .dept))
            }else {
                
                    var isCheckRegion = false
                    for region in listDept {
                        if region.trim() == item.name?.trim() {
                            isCheckRegion = true
                        }
                    }
                    if !isCheckRegion {
                        listDept.append(item.name!)
                        list.append(ItemSearchModel(title: item.name!, type: .dept))
                    }
                
               
            }
        }

//        var ok = 0
//        for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
//            
//            
//            if index == 0 {
//                var model  = ItemSearchModel(title: item.dept!, type: .dept)
//                let fullNameArr = item.dept!.components(separatedBy: " ")
//                listDept.append(Int(fullNameArr[1].trim())!)
//
//
//                model.valuePosition = Int(fullNameArr[1].trim())!
//                list.append(model)
//            }else {
//                var isCheckDept = false
//            var model  = ItemSearchModel(title: item.dept!, type: .dept)
//            let fullNameArr = item.dept!.components(separatedBy: " ")
//
//                for dept in listDept {
//                    
//                    if dept == Int(fullNameArr[1].trim())! {
//                        isCheckDept = true
//                        break
//                    }
//                }
//                print("filterDept --- \(ok) || \(isCheckDept)")
//
//                if !isCheckDept {
//                    listDept.append(Int(fullNameArr[1].trim())!)
//                 
//                    model.valuePosition = Int(fullNameArr[1].trim())!
//
//                    list.append(model)
////                    list.append(ItemSearchModel(title: item.dept!, type: .dept))
//                    
//                }
//                ok += 1
//            }
//        }
//        list.sorted { $0.fileId > $1.fileID }
//        let sorted = list.sort()
//        let io = list.sorted (by: {$0.valuePosition < $1.valuePosition})
        
        return list
    }
    
    
    static func filterProvinceRegion(selectRegion: String,data:[String]) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listProvince:[String] = []
        
        for (index,item) in data.enumerated() {
            print("re \(item)")

//            if selectRegion == item.region {
                if index == 0 {
                    listProvince.append(item)
                    list.append(ItemSearchModel(title: item, type: .provinceRegion))
                }else {
                    var isCheckProvince = false
                    for province in listProvince {
                        if province == item {
                            isCheckProvince = true
                        }
                    }
                    if !isCheckProvince {
                        listProvince.append(item)
                        list.append(ItemSearchModel(title: item, type: .provinceRegion))
                    }
                }
//            }
        }
        
        return list
    }
    
    
    static func filterProvinceDept(selectDept: String,data:[String]) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listProvince:[String] = []
        
        for (index,item) in data.enumerated() {
            
            print("dep \(item)")
//            if selectDept == item.dept {
                if index == 0 {
                    listProvince.append(item)
                    list.append(ItemSearchModel(title: item, type: .provinceDept))
                }else {
                    var isCheckProvince = false
                    for province in listProvince {
                        if province == item {
                            isCheckProvince = true
                        }
                    }
                    if !isCheckProvince {
                        listProvince.append(item)
                        list.append(ItemSearchModel(title: item, type: .provinceDept))
                    }
                }
//            }
        }
        
        return list
    }
    
    
    static func filterStation(selectItem: String, type: TypeSearch.Status,data:[WarningStation]) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
        
        var listProvince:[String] = []
        
        for (index,item) in data.enumerated() {
            
//            if selectItem == item.province! {
                if index == 0 {
                    listProvince.append(item.name!)
                    list.append(ItemSearchModel(title: item.name!, type: type))
                }else {
//                    var isCheckProvince = false
//                    for province in listProvince {
//                        if province == item.province {
//                            isCheckProvince = true
//                        }
//                    }
//                    if !isCheckProvince {
                        listProvince.append(item.name!)
                        list.append(ItemSearchModel(title: item.name!, type: type))
//                    }
                }
//            }
            
        }
        
        return list
    }
    
    
    static func filterStationSearch(selectItem: String, type: TypeSearch.Status,data:[String]) -> [ItemSearchModel] {
        var list:[ItemSearchModel] = []
//        
//        for (index,item) in AppDelegate.shareDelegate.last_data_search.enumerated() {
//            
//            if item.title!.contains(selectItem) {
//                list.append(ItemSearchModel(title: item.title!, type: type))
//            }
//        }
        for (index,item) in data.enumerated() {
            
//            if item!.contains(selectItem) {
                list.append(ItemSearchModel(title: item, type: type))
//            }
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
    
    let apiServiceJsonProvider = MoyaProvider<APIJsonService>()

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
    
    var listWarning: [WarningStation] = []

    
    var listDepart: [DepartModel] = []
    var listRegion: [RegionModel] = []

    
    var listProvince: [String] = []

    
    
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

        getDepart()
        getRegion()
        
        
    }
    
    
    func configure(_ interface: SearchProtocol) {
        self.viewModel = interface
        bindToViewModel()
        self.list.removeAll()
        ItemSearchModel.getListItemSearchType(type: .main, viewModel: viewModel as! SearchViewModel, selectItem: nil, data: nil)
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
        //    self.stopLoding()
        }
    }
    
    @objc func handleCloseOrBack(){
        switch currentTypePage {
        case .main:
            dismiss(animated: true, completion: nil)
            break
        case .dept, .region:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .main, viewModel: viewModel as! SearchViewModel, selectItem: nil, data: nil)
            break
        case .provinceDept:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .dept, viewModel: viewModel as! SearchViewModel, selectItem: nil, data: self.listDepart)
            break
        case .provinceRegion:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .region, viewModel: viewModel as! SearchViewModel, selectItem: nil, data: self.listRegion)
            break
        case .stationRegion:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .provinceRegion, viewModel: viewModel as! SearchViewModel, selectItem: lastSelectRegion, data: self.listProvince)
            break
        case .stationDept:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .provinceDept, viewModel: viewModel as! SearchViewModel, selectItem: lastSelectDept, data: self.listProvince)
            break
        case .stationSearch:
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .main, viewModel: viewModel as! SearchViewModel, selectItem: nil, data: nil)
            break
        default:
            print("nil")
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.list.removeAll()
            
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(SearchViewController.reload), object: nil)
                self.perform(#selector(SearchViewController.reload), with: nil, afterDelay: 0.5)
//            ItemSearchModel.getListItemSearchType(type: .stationSearch, viewModel: viewModel as! SearchViewModel, selectItem: searchText, data: nil)
        }else {
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .main, viewModel: viewModel as! SearchViewModel, selectItem: nil, data: [])
        }
        
        
    }
    
    @objc func reload() {
        guard let searchText = searchBar.text else { return }
//        search(searchText)
        self.searchStation(txt: searchText)

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
                ItemSearchModel.getListItemSearchType(type: .region, viewModel: viewModel as! SearchViewModel, selectItem: nil, data: self.listRegion)
                lastTypePage = .main
                currentTypePage = .region
            }else {
                ItemSearchModel.getListItemSearchType(type: .dept, viewModel: viewModel as! SearchViewModel, selectItem: nil, data: self.listDepart)
                lastTypePage = .main
                currentTypePage = .dept
            }
            break
        case .region:
            print(" reaction ")
            var selectItem = self.list[indexPath.row].title
            self.list.removeAll()
            
            ItemSearchModel.getListItemSearchType(type: .provinceRegion, viewModel: viewModel as! SearchViewModel, selectItem: selectItem, data: self.listRegion[indexPath.row].provinces)
            self.listProvince = self.listRegion[indexPath.row].provinces ?? []

            lastTypePage = .region
            currentTypePage = .provinceRegion
            lastSelectRegion = selectItem!
            break
        case .dept:
            print(" deaction ")

            var selectItem = self.list[indexPath.row].title
            
            self.listProvince = self.listDepart[indexPath.row].provinces ?? []
            
            self.list.removeAll()
            ItemSearchModel.getListItemSearchType(type: .provinceDept, viewModel: viewModel as! SearchViewModel, selectItem: selectItem, data: self.listDepart[indexPath.row].provinces)
            lastTypePage = .dept
            currentTypePage = .provinceDept
            lastSelectDept = selectItem!
            break
            
        case .provinceDept:
            var selectItem = self.list[indexPath.row].title
            self.list.removeAll()
//            ItemSearchModel.getListItemSearchType(type: .stationDept, viewModel: viewModel as! SearchViewModel, selectItem: selectItem, data: nil)
            
            getStation(selectItem: selectItem!, types: .stationDept)
            
            lastTypePage = .provinceDept
            currentTypePage = .stationDept
            lastSelectProvince = selectItem!
            break
        case .provinceRegion:
            var selectItem = self.list[indexPath.row].title
            self.list.removeAll()
//            ItemSearchModel.getListItemSearchType(type: .stationRegion, viewModel: viewModel as! SearchViewModel, selectItem: selectItem, data: nil)
            getStation(selectItem: selectItem!, types: .stationRegion)

            lastTypePage = .provinceRegion
            currentTypePage = .stationRegion
            lastSelectProvince = selectItem!
            break
        case .stationRegion, .stationDept:
//            self.startLoding()
            var selectItem: Int = 0
            DispatchQueue.global(qos: .background).async {
//                let LisItemStation = ItemSearchModel.filterSelectStation(ListItem: self.list)
                DispatchQueue.main.async {
//                    self.stopLoding()
//                    for (index, item) in LisItemStation.enumerated() {
//                        if  self.list[indexPath.row].title == item.title! {
//                            selectItem = index
//                        }
//                    }
                    
                    
                    let rootVC = DetailStationNVViewController()
                    rootVC.stations_last = self.listWarning
                    rootVC.currentPage =  indexPath.row //selectItem
                    let rootNC = UINavigationController(rootViewController: rootVC)
                    rootNC.modalPresentationStyle = .overFullScreen
                    rootNC.modalTransitionStyle = .crossDissolve
                    self.present(rootNC, animated: true, completion: nil)
                }
            }
            
            break
        case  .stationSearch:
//            self.startLoding()
            var selectItem: Int = 0
//            DispatchQueue.global(qos: .background).async {
            guard let searchText = searchBar.text else { return }

                self.getStation(txt: searchText, position: indexPath.row)
//                let LisItemStation = ItemSearchModel.filterSelectStation(ListItem: self.list)
//                DispatchQueue.main.async {
////                    self.stopLoding()
////                    for (index, item) in LisItemStation.enumerated() {
////                        if  self.list[indexPath.row].title == item.title! {
////                            selectItem = index
////                        }
////                    }
//                    
//                    
//                    let rootVC = DetailStationNVViewController()
//                    rootVC.stations_last = self.listWarning
//                    rootVC.currentPage =  indexPath.row //selectItem
//                    let rootNC = UINavigationController(rootViewController: rootVC)
//                    rootNC.modalPresentationStyle = .overFullScreen
//                    rootNC.modalTransitionStyle = .crossDissolve
//                    self.present(rootNC, animated: true, completion: nil)
//                }
//            }
            
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
    
    
    func getStation(selectItem:String,types:TypeSearch.Status){
        
        self.startLoding()
        self.listWarning =  []

        
        var request:[String:String] =   [String:String]()
        
        request.updateValue(selectItem, forKey: "txt")
        

        apiServiceJsonProvider.rx.request(.GetWarningStationType(request: request)).subscribe { event in

            switch event {
            case let .success(response):
                print("ddd -- \(response)")
                
                do {
                    let result = try JSONDecoder().decode(StationWarningResponse.self, from: response.data)
                    
                    
                    self.listWarning = result.data ?? []
                    ItemSearchModel.getListItemSearchType(type: types, viewModel: self.viewModel as! SearchViewModel, selectItem: selectItem, data: self.listWarning)
                    self.stopLoding()

                
                } catch { print("err --- \(error)") }
                self.stopLoding()


            case let .failure(error):
                self.stopLoding()

              print("ddd")
            }
        
        }
        
        
    }
    
    
    func searchStation(txt:String){
        
        self.startLoding()
        self.listWarning =  []

        
        var request:[String:String] =   [String:String]()
        
        request.updateValue(txt, forKey: "txt")
        

        apiServiceJsonProvider.rx.request(.GetSearchStation(request: request)).subscribe { event in

            switch event {
            case let .success(response):
                print("dddaa -- \(response)")
                
                self.stopLoding()
                do {
                    let result = try JSONDecoder().decode([String].self, from: response.data)
                    
                    
                    //self.listWarning = result.data ?? []
                    ItemSearchModel.getListItemSearchType(type: .stationSearch, viewModel: self.viewModel as! SearchViewModel, selectItem: txt, data: result ?? [])
//                    ItemSearchModel.getListItemSearchType(type: types, viewModel: self.viewModel as! SearchViewModel, selectItem: selectItem, data: self.listWarning)
//                    
                
                } catch { print("err --- \(error)") }
                

            case let .failure(error):
                self.stopLoding()

              print("ddd")
            }
        
        }
        
        
    }
    
    
    func getStation(txt:String,position:Int){
        
        self.startLoding()

        
        var request:[String:String] =   [String:String]()
        
        request.updateValue(txt, forKey: "search")
        

        apiServiceJsonProvider.rx.request(.GetWarningStationType(request: request)).subscribe { event in

            switch event {
            case let .success(response):
                print("dddGetWarningStationType -- \(response)")
                
                self.stopLoding()
                do {
                    let result = try JSONDecoder().decode(StationWarningResponse.self, from: response.data)
                    
                    
                 
                    DispatchQueue.main.async {
    //                    self.stopLoding()
    //                    for (index, item) in LisItemStation.enumerated() {
    //                        if  self.list[indexPath.row].title == item.title! {
    //                            selectItem = index
    //                        }
    //                    }
                        
                        
                        let rootVC = DetailStationNVViewController()
                        rootVC.stations_last = result.data
                        rootVC.currentPage =  position //selectItem
                        let rootNC = UINavigationController(rootViewController: rootVC)
                        rootNC.modalPresentationStyle = .overFullScreen
                        rootNC.modalTransitionStyle = .crossDissolve
                        self.present(rootNC, animated: true, completion: nil)
                    }
                    
                    
                
                } catch { print("err --- \(error)") }
                

            case let .failure(error):
                self.stopLoding()

              print("ddd")
            }
        
        }
        
        
    }
    
    
    
    func getDepart(){
        
        self.startLoding()
        apiServiceJsonProvider.rx.request(.GetDepart).subscribe { event in

            switch event {
            case let .success(response):
                print("dddk -- \(response)")
                
                do {
                    let result = try JSONDecoder().decode([DepartModel].self, from: response.data)
                    
                    
                    self.listDepart = result
                    //self.startLoding()
                    self.stopLoding()
                } catch { print("err --- \(error)") }
//                self.stopLoding()


            case let .failure(error):
//                self.stopLoding()

              print("ddd")
            }
        
        }
        
        
    }
    func getRegion(){
        
//        self.startLoding()
        apiServiceJsonProvider.rx.request(.GetRegion).subscribe { event in

            switch event {
            case let .success(response):
                print("ddds -- \(response)")
                
                do {
                    let result = try JSONDecoder().decode([RegionModel].self, from: response.data)
                    
                    
                    self.listRegion = result
//                    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(SearchViewController.ttt), object: nil)
//                        self.perform(#selector(SearchViewController.ttt), with: nil, afterDelay: 5000)
//                    
                                //    self.stopLoding()

                } catch { print("err --- \(error)") }
                

            case let .failure(error):
//                self.stopLoding()

              print("ddd")
            }
        
        }
        
        
    }
    
    @objc func ttt(){
       // self.stopLoding()
        print("ttt")

        
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
