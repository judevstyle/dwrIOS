//
//  IntroViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 9/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import SideMenu
import SwiftyXMLParser

class IntroViewController: UIViewController, SideMenuNavigationControllerDelegate, UINavigationControllerDelegate {
    
    let  dView: DashboardView = {
        let view = DashboardView(linecolor: .red)
        
        
        return view
    }()
    
    let  d2View: DashboardView = {
        let view = DashboardView(linecolor: .yellow)
        
        
        return view
    }()
    
    
    let  d3View: DashboardView = {
        let view = DashboardView(linecolor: .green)
        
        
        return view
    }()
    
    
    let  d4View: DashboardView = {
        let view = DashboardView(linecolor: .blue)
        
        
        return view
    }()
    
    var stackView = UIStackView()
    
    let viewAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("ดูสถานการ์ณทั้งหมด", for: .normal)
        
        button.titleLabel?.font = .PrimaryRegular(size: 20)
        
        button.tintColor = .white
        return button
    }()
    
    
    
    lazy var  menuSlide: SideMenuNavigationController = {
        let menu = SideMenuNavigationController(rootViewController: MainViewController())
        menu.leftSide = true
        menu.delegate = self
        menu.menuWidth = 75
        return menu
    }()
    
    
    var topConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "สรุปสถานการ์ณฝน")
        
        let leftbutton = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(handleSlide))
        
        leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        
        stackView = UIStackView(arrangedSubviews: [dView, d2View,d3View,d4View])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        view.addSubview(stackView)
        view.addSubview(viewAllButton)
        
        
        
        
        stackView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 100, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        
        viewAllButton.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 16, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
        setupView()
        
        DispatchQueue.main.async {
            self.getCountStatus()
        }
        
    }
    
    
    func getCountStatus() {
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        let urlString = URL(string: "\(baseURL)/count_status_vill.xml")
        let xml = try! XML.parse(Data(contentsOf: urlString!))
        
        let status1 = xml["ews"]["status1"]
        let status2 = xml["ews"]["status2"]
        let status3 = xml["ews"]["status3"]
        let status4 = xml["ews"]["status9"]
        
        dView.valueLabel.text = "\(status1.text!)"
        d2View.valueLabel.text = "\(status2.text!)"
        d3View.valueLabel.text = "\(status3.text!)"
        d4View.valueLabel.text = "\(status4.text!)"
    }
    
    
    func setupView() {
        dView.titleLabel.text = "อพยพ"
        d2View.titleLabel.text = "เตือนภัย"
        d3View.titleLabel.text = "เฝ้าระวัง"
        d4View.titleLabel.text = "มีฝน"
    }
    
    @objc func handleSlide(){
        
        present(menuSlide, animated: true, completion: nil)
        
    }
    
    
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
        
        self.stackView.setConstraintConstant(constant: -90, forAttribute: .right)
  
        
    }
    
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
         self.stackView.setConstraintConstant(constant: -16, forAttribute: .right)
    }
    
    
}
