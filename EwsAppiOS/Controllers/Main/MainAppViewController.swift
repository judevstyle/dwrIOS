//
//  MainAppViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 18/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import SideMenu

protocol MainAppDelegateProtocol {
    func openr(name: String)
    func ToastLoading()
}

class MainAppViewController: UIViewController, MainAppDelegateProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0

        view.backgroundColor = .AppPrimary()
        
        let rootVC = DashboardViewController()
        rootVC.delegateMainApp = self
        let rootNC = UINavigationController(rootViewController: rootVC)
        self.view.addSubview(rootNC.view)
        
        self.addChild(rootNC)
        
        rootNC.didMove(toParent: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func openr(name: String) {
    
        let rootVC = StationListViewController()
        let rootNC = UINavigationController(rootViewController: rootVC)
               rootNC.modalPresentationStyle = .fullScreen
               rootNC.modalTransitionStyle = .crossDissolve
        self.present(rootNC, animated: false, completion: nil)
    }
    
       
    func ToastLoading() {
          ToastMsg(msg: "กำลังโหลด..")
      }
    
    override func viewWillAppear(_ animated: Bool) {
   
    }
    
    
    
}
