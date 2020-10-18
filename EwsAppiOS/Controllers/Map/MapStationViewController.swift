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

class MapStationViewController: UIViewController, GMSMapViewDelegate {
    
    let APIServiceProvider = MoyaProvider<APIService>()

    private var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    
    var markerCustom: GMSMarker?
    var markerView: UIImageView?
    
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
   
    }
    
    @objc func handleClose(){
           dismiss(animated: true, completion: nil)
       }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: AppDelegate.shareDelegate.currentLocation!.latitude, longitude: AppDelegate.shareDelegate.currentLocation!.longitude, zoom: 12.0)
        
        mapView = GMSMapView.map(withFrame: self.viewMain.frame, camera: camera)
        mapView.mapType = .hybrid
        mapView.isMyLocationEnabled = true
        
        self.viewMain.addSubview(mapView)
        mapView.anchor(viewMain.topAnchor, left: viewMain.leftAnchor, bottom: viewMain.bottomAnchor, right: viewMain.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.mapView.delegate = self
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView,
                                                 clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm,
                                           renderer: renderer)
        
        // Register self to listen to GMSMapViewDelegate events.
        clusterManager.setMapDelegate(self)
        
//        let pin = UIImage(named: "pin")!.withRenderingMode(.alwaysOriginal)
//        let size = CGSize(width: 45, height: 45)
//        let aspectScaledToFitImage = pin.af_imageAspectScaled(toFit: size)
//        markerView = UIImageView(image: aspectScaledToFitImage)
        
        
        
    }
    
    
    
//
//
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        //        print("sssss", marker.snippet!)
//        let actionSheet = MDCActionSheetController(title: "คลินิค \(self.listClinic[Int("\(marker.snippet!)")!].u_name_clinic!)",
//            message: "")
//
//
//        let actionOne = MDCActionSheetAction(title: "รายละเอียด",
//                                             image: UIImage(named: "eye"),
//                                             handler:  { _ in
//                                                let detailVC = DetailClinicViewController()
//                                                detailVC.clinicData = self.listClinic[Int("\(marker.snippet!)")!]
//                                                detailVC.listServices = self.listClinic[Int("\(marker.snippet!)")!].service_day ?? []
//                                                detailVC.listDoctor = self.listClinic[Int("\(marker.snippet!)")!].doctor ?? []
//                                                detailVC.hidesBottomBarWhenPushed = true
//                                                self.navigationController?.pushViewController(detailVC, animated: true)
//
//        })
//
//        actionSheet.addAction(actionOne)
//
//        actionSheet.titleFont = UIFont.KanitMedium(size: 21)
//        actionSheet.actionFont = UIFont.KanitRegular(size: 17)
//        actionSheet.actionTextColor = UIColor.gray
//        actionSheet.imageRenderingMode = .alwaysTemplate
//        actionSheet.actionTintColor = .gray
//
//
//        present(actionSheet, animated: true, completion: nil)
//
//        return true
//    }
    
    
}
