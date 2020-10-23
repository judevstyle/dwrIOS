//
//  MapStationViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 16/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils
import Moya
import AlamofireImage

class MapStationViewController: UIViewController, GMSMapViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let APIServiceProvider = MoyaProvider<APIService>()
    
    private var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    
    var markerCustom: GMSMarker?
    
    var marker: GMSMarker!
    
    let viewMain : UIView = {
        let view = UIView()
        
        return view
    }()
    
    
    let viewStatus: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    let cellId = "cellDashboard"
    
    
    lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = .clear
        tableview.isScrollEnabled = false
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        tableview.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableview.layer.cornerRadius = 8
        return tableview
    }()
    
    lazy var markerDefaultView: UIImageView = {
        let pin = UIImage(named: "pin-default")!.withRenderingMode(.alwaysOriginal)
        //        let size = CGSize(width: 25, height: 25)
        //        let aspectScaledToFitImage = pin.af_imageAspectScaled(toFit: size)
        return UIImageView(image: pin)
    }()
    
    
    lazy var markerBewareView: UIImageView = {
        let pin = UIImage(named: "pin-beware")!.withRenderingMode(.alwaysOriginal)
        //        let size = CGSize(width: 25, height: 25)
        //        let aspectScaledToFitImage = pin.af_imageAspectScaled(toFit: size)
        return UIImageView(image: pin)
    }()
    
    lazy var markerEvacuateView: UIImageView = {
        let pin = UIImage(named: "pin-evacuate")!.withRenderingMode(.alwaysOriginal)
        //        let size = CGSize(width: 25, height: 25)
        //        let aspectScaledToFitImage = pin.af_imageAspectScaled(toFit: size)
        return UIImageView(image: pin)
    }()
    
    lazy var markerWarningView: UIImageView = {
        let pin = UIImage(named: "pin-warning")!.withRenderingMode(.alwaysOriginal)
        //        let size = CGSize(width: 25, height: 25)
        //        let aspectScaledToFitImage = pin.af_imageAspectScaled(toFit: size)
        return UIImageView(image: pin)
    }()
    
    
    var dashboards = DashboardCardModel.dashboards()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.setTitleNavigation(title: "แผนที่")
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        
        let leftbutton = UIBarButtonItem(image: UIImage(systemName:  "clear"), style: .done, target: self, action: #selector(handleClose))
        
        leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        setupView()
    }
    
    
    func setupView() {
        
        //        view.addSubview(viewStatus)
        view.addSubview(viewMain)
        
        //        viewStatus.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        
        viewMain.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tableview.register(DashboardMapView.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(tableview)
        
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: -16, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 100, heightConstant: self.view.frame.height/2)
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loadMapView()
        
        self.startLoding()
        DispatchQueue.global(qos: .background).async {
            self.dashboards = DashboardCardModel.getCountStatus()
            
            DispatchQueue.main.async {
                self.stopLoding()
                self.tableview.reloadData()
            }
        }
        
        
    }
    
    // Set the status bar style to complement night-mode.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func loadMapView() {
        
        
        let camera = GMSCameraPosition.camera(withLatitude: AppDelegate.shareDelegate.currentLocation!.latitude, longitude: AppDelegate.shareDelegate.currentLocation!.longitude, zoom: 5.0)
        
        
        mapView = GMSMapView.map(withFrame: self.viewMain.frame, camera: camera)
        mapView.isMyLocationEnabled = true
        
        self.viewMain.addSubview(mapView)
        mapView.anchor(viewMain.topAnchor, left: viewMain.leftAnchor, bottom: viewMain.bottomAnchor, right: viewMain.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        self.mapView.delegate = self
        
        getMap()
    }
    
    
    func getMap() {
        
        
        DispatchQueue.global(qos: .background).async {
            for (index,item) in AppDelegate.shareDelegate.stations.enumerated() {
                
                if let lat = item.latitude!.toDouble() {
                    if let long = item.longitude!.toDouble() {
                        Thread.sleep(forTimeInterval: 0.0001)
                        DispatchQueue.main.async {
                            
                            self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: index, iconMarker: self.markerDefaultView)
                        }
                        
                    }
                }
            }
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: AppDelegate.shareDelegate.currentLocation!.latitude, longitude: AppDelegate.shareDelegate.currentLocation!.longitude, zoom: 5.0)
        self.mapView.animate(to: camera)
        
        
    }
    
    
    
    func handleAddMarker(coordinate: CLLocationCoordinate2D, index: Int, iconMarker: UIImageView){
        
        
        let position = coordinate
        marker = GMSMarker(position: position)
        marker.snippet = "\(index)"
        marker.isTappable = true
        marker.iconView = iconMarker
        marker.tracksViewChanges = true
        marker.map = self.mapView
        self.markerCustom = marker
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DashboardMapView
        
        cell.dashboard = dashboards[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/CGFloat(dashboards.count)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if AppDelegate.shareDelegate.stations != nil {
            
            let rootVC = StationListViewController()
            
            switch indexPath.row {
            case 0:
                rootVC.StatusType = "สถานการณ์ อพยพ"
            case 1:
                rootVC.StatusType = "สถานการณ์ เตือนภัย"
            case 2:
                rootVC.StatusType = "สถานการณ์ เฝ้าระวัง"
            case 3:
                rootVC.StatusType = "สถานการณ์ ฝนตกเล็กน้อย"
            default:
                rootVC.StatusType = "สถานการณ์ ฝนตกเล็กน้อย"
            }
            let rootNC = UINavigationController(rootViewController: rootVC)
            rootNC.modalPresentationStyle = .fullScreen
            rootNC.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                self.present(rootNC, animated: true, completion: nil)
            }
        }else {
            //            delegateMainApp!.ToastLoading()
        }
    }
    
    
}


