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
        case stp
        case province
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
    
    
    static func getListItemSearchType(type: TypeSearch.Status, viewModel: SearchViewModel) {
        var list: [ItemSearchModel] = []
        
        switch type {
        case .main:
            viewModel.input.saveItem(item: ItemSearchModel(title: "ภาคตามภูมิศาสตร์\nประเทศไทย", type: .main))
            viewModel.input.saveItem(item: ItemSearchModel(title: "สำนักงานทรัพยากรน้ำ\nกรมทรัพยากรน้ำ", type: .main))
            break
        default:
            list = []
            break
        }
        
    }
    
}

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let cellId = "cellSearch"
    
    var viewModel: SearchProtocol!
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .default
        search.placeholder = " Search..."
        search.sizeToFit()
        search.isTranslucent = false
        search.delegate = self
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
        
        let leftbutton = UIBarButtonItem(image: UIImage(systemName:  "clear"), style: .done, target: self, action: #selector(handleClose))
        
        leftbutton.tintColor = .white
        navigationItem.leftBarButtonItem = leftbutton
        tableview.register(CardSearchItemViewCell.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(searchBar)
        searchBar.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(tableview)
        tableview.anchor(searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        searchBar.clearBackgroundColor()
        
        configure(SearchViewModel())
    }
    
    
    func configure(_ interface: SearchProtocol) {
        self.viewModel = interface
        bindToViewModel()
        self.list.removeAll()
        ItemSearchModel.getListItemSearchType(type: .main, viewModel: viewModel as! SearchViewModel)
    }
    
    fileprivate func RenderItemCell(item: ItemSearchModel) {
        DispatchQueue.main.async {
            self.typeSearch.status = item.type!
            self.list.append(item)
            self.tableview.reloadData()
            self.stopLoding()
            print(self.list.count)
        }
    }
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch typeSearch.status {
        case .main:
            return tableView.frame.size.height/2
        default:
            return 100
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CardSearchItemViewCell
        
        
        return cell
    }
    
    
}

extension SearchViewController {
    
    func bindToViewModel() {
        viewModel.output.RenderItemCell = RenderItemCell()
    }
    
    func RenderItemCell() -> ((ItemSearchModel) -> Void) {
        return {  [weak self] data in
            
            guard let weakSelf = self else { return }
            weakSelf.RenderItemCell(item: data)
        }
    }
}


protocol SearchProtocolInput {
    func saveItem(item: ItemSearchModel?)
}

protocol SearchProtocolOutput: class {
    var RenderItemCell: ((ItemSearchModel) -> Void)? {get set}
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
    var didError: (() -> Void)?
    
}


extension SearchViewModel: SearchProtocolInput {
    
    func saveItem(item: ItemSearchModel?) {
        guard let new_data = item,
            new_data != nil else {
                didError?()
                return
        }
        RenderItemCell?(new_data)
    }
}
