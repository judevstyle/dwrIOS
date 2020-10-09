//
//  IntroViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 9/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import SideMenu

class IntroViewController: UIViewController {
    
    
    
    
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
              
        
        stackView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 100, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        
        viewAllButton.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 16, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
        setupView()
            

    }
    
    
    
    func setupView() {
        dView.titleLabel.text = "อพยพ"
         d2View.titleLabel.text = "เตือนภัย"
         d3View.titleLabel.text = "เฝ้าระวัง"
         d4View.titleLabel.text = "มีฝน"
    }
    
    @objc func handleSlide(){
        let menu = SideMenuNavigationController(rootViewController: MainViewController())
        menu.leftSide = true
        menu.menuWidth = 75
        
//      dView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 95, widthConstant: 0, heightConstant: 100)
        
        present(menu, animated: true, completion: nil)
        
    }


}
