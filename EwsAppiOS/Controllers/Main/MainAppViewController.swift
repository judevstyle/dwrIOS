//
//  MainAppViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 18/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import SideMenu
import CoreLocation

protocol MainAppDelegateProtocol {
    func openr(name: String)
    func ToastLoading()
}

class MainAppViewController: UIViewController, MainAppDelegateProtocol, CLLocationManagerDelegate {

     let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .AppPrimary()
        
        let rootVC = DashboardViewController()
        rootVC.delegateMainApp = self
        let rootNC = UINavigationController(rootViewController: rootVC)
        self.view.addSubview(rootNC.view)
        
        self.addChild(rootNC)
        
        rootNC.didMove(toParent: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidLoadStationsSuccess(_:)), name: .didLoadStationsSuccess, object: nil)
        
        self.startLoding()
        
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
          locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
              
              if CLLocationManager.locationServicesEnabled() {
                  locationManager.delegate = self
                  locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                  locationManager.startUpdatingLocation()
              }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        AppDelegate.shareDelegate.currentLocation = locValue
        locationManager.stopUpdatingLocation()
    }
    
    
    @objc func onDidLoadStationsSuccess(_ notification:Notification) {
        self.stopLoding()
//        print(AppDelegate.shareDelegate.stations.count)
//        print(AppDelegate.shareDelegate.last_data_search.count)
    }
    
}
