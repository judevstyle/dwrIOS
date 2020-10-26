//
//  SettingViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    
    
    let viewMain: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.2)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true 
        
        return view
    }()
    
    let iconSetting1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "headphones")
        image.tintColor = .white
        
        return image
    }()
    
    
    let labelSetting1: UILabel = {
        let label = UILabel()
        label.text = "Notification"
        label.font = UIFont.PrimaryRegular(size: 18)
        label.textColor = .white
        return label
    }()
    
    
    lazy var switchOnOff: UISwitch = {
        let switchOnOff = UISwitch()
        switchOnOff.isOn = false
        switchOnOff.translatesAutoresizingMaskIntoConstraints = false
        switchOnOff.addTarget(self, action: #selector(switchButton), for: .valueChanged)
        return switchOnOff
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "สรุปสถานการ์ณฝน")
        
        
        let leftbutton = UIBarButtonItem(image: UIImage(systemName:  "clear"), style: .done, target: self, action: #selector(handleClose))
        
        leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        
        view.addSubview(viewMain)
        viewMain.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        
        viewMain.addSubview(iconSetting1)
        viewMain.addSubview(labelSetting1)
        viewMain.addSubview(switchOnOff)
        
        iconSetting1.anchor(viewMain.topAnchor, left: viewMain.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        
        labelSetting1.anchor(viewMain.topAnchor, left: iconSetting1.rightAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 35)
        
        switchOnOff.anchor(viewMain.topAnchor, left: nil, bottom: nil, right: viewMain.leftAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 100, heightConstant: 100)
    }
    
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func switchButton(){
          dismiss(animated: true, completion: nil)
          
      }
    
    
}
