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
import SwiftyXMLParser


class MapStationViewController: UIViewController, GMSMapViewDelegate, UITableViewDataSource, UITableViewDelegate {
    let apiServiceJsonProvider = MoyaProvider<APIJsonService>()

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
        let size = CGSize(width: 20, height: 20)
        let aspectScaledToFitImage = pin.af_imageAspectScaled(toFit: size)
        return UIImageView(image: pin)
    }()
    
    lazy var markerWhiteView: UIImageView = {
          let pin = UIImage(named: "pin-all")!.withRenderingMode(.alwaysOriginal)
              let size = CGSize(width: 17, height: 17)
              let aspectScaledToFitImage = pin.af_imageAspectScaled(toFit: size)
              return UIImageView(image: aspectScaledToFitImage)
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
        let size = CGSize(width: 25, height: 25)
        let aspectScaledToFitImage = pin.af_imageAspectScaled(toFit: size)
        return UIImageView(image: pin)
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .PrimaryLight(size: 25)
        label.textColor = .blackAlpha(alpha: 0.7)
        label.text = "บ้านหินแด้น"
        return label
    }()
    
    let Pm25Label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .PrimaryLight(size: 15)
        label.textColor = .blackAlpha(alpha: 0.7)
        label.text = "PM 2.5 = 00"
        return label
    }()
    
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
        label.textColor = .blackAlpha(alpha: 0.7)
        
        let stringValue = "ต.หนองไผ่ อ.ด่านมะขามเตี้ย จ.กาญจนบุรี\nหมู่บ้านคลอบคลุมจำนวน 3 หมู่บ้าน"
        
        let attributedString = NSMutableAttributedString(string: stringValue)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.maximumLineHeight = 17.0
        
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        attributedString.addAttribute(
            .font,
            value: UIFont.PrimaryLight(size: CGFloat(15)),
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        
        label.attributedText = attributedString
        
        return label
    }()
    
    
    let rainLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.text = "ปริมาณฝนสะสม"
        label.textColor = .blackAlpha(alpha: 0.7)
        
        label.font = .PrimaryLight(size: 17)
        label.textAlignment = .center
        
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textColor = .blackAlpha(alpha: 0.7)
        
        var stringValue = "0"
        
        let attributedString = NSMutableAttributedString(string: stringValue)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.maximumLineHeight = 50
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        attributedString.addAttribute(
            .font,
            value: UIFont.PrimaryRegular(size: CGFloat(35)),
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.blackAlpha(alpha: 0.7),
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        
        label.attributedText = attributedString
        
        label.textAlignment = .right
        
        return label
    }()
    
    
    lazy var valueUnitLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "มม."
        label.textColor = .blackAlpha(alpha: 0.7)
        label.font = .PrimaryRegular(size: 16)
        label.textAlignment = .right
        return label
    }()
    
    lazy var viewRecenty: UIView = {
        let view = UIView()
        
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    let iconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "overcast")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    
    let textRecenty: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .blackAlpha(alpha: 0.7)
        label.text = "ดูฝนย้อนหลัง 7 วัน"
        label.font = .PrimaryLight(size: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    var dashboards = DashboardCardModel.dashboardsMap()
    
    var listMarker: [StationXLastDataModel] = []
    var selectedStation: StationXLastDataModel? = nil
    
    var viewModel: LastDataStationProtocol!
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.setTitleNavigation(title: "แผนที่")
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        
        let leftbutton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(handleClose))
        leftbutton.tintColor = .white
        
        leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        setupView()
    }
    
    
    func setupView() {
        
        //        view.addSubview(viewStatus)
        view.addSubview(viewMain)
        
        viewMain.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tableview.register(DashboardMapView.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(tableview)
        
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: -16, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 100, heightConstant: self.view.frame.height/1.5)
        loadMapView()
        getDashboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.global(qos: .background).async {
//            self.getCountStatus()
//            DispatchQueue.main.async {
//                self.tableview.reloadData()
//            }
        }
    }
    
    
    
    
    func getDashboard(){
        
            self.startLoding()
            apiServiceJsonProvider.rx.request(.GetDashboard).subscribe { event in

                switch event {
                case let .success(response):
                    print("ddds -- \(response)")
                    
                    do {
                        let result = try JSONDecoder().decode(DashBoardModel.self, from: response.data)
                        
                        self.dashboards[0].value = "\(result.type3?.count_bann ?? 0)"
                        self.dashboards[1].value = "\(result.type2?.count_bann ?? 0)"
                        self.dashboards[2].value = "\(result.type1?.count_bann ?? 0)"
                        self.dashboards[3].value = "\(result.type9?.count_bann ?? 0)"
                        self.tableview.reloadData()
                        
                        
                        if ((result.type1?.count_station ?? 0)+(result.type2?.count_station ?? 0)+(result.type3?.count_station ?? 0)
                        ) < 1 {
                            let alert = UIAlertController(title: "ไม่มีการเตือนภัย", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                            
                        }
                        
                        self.getWarning(type: "6")
                        
                        
                        
                       // self.listRegion = result
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
    
    func getWarning(type:String){
        
        var request:[String:String] =   [String:String]()
        
        
        
        
        
        switch type {
            
        case "1" :
            request.updateValue("3", forKey: "status")
            break
        case "2" :
            request.updateValue("2", forKey: "status")
            break
        case "3" :
            request.updateValue("1", forKey: "status")
            break
        case "4" :
            request.updateValue("9", forKey: "status")
            break
        case "5" :
            request.updateValue("1", forKey: "show")
            break
        default :
            request.updateValue("2", forKey: "show")
            break
        }
        
            self.startLoding()
        apiServiceJsonProvider.rx.request(.GetWarningStationMap(request: request)).subscribe { event in

                switch event {
                case let .success(response):
                    print("ddds -- \(response)")
                    
                    do {
                        let result = try JSONDecoder().decode(StationWarningResponse.self, from: response.data)
                        LastDataModel.setMethodAllWarnMap(viewModel: self.viewModel as! LastDataViewModel,stations: result.data ?? [])

                        
                        
//                        LastDataModel.FetchMapLastData(type: type, viewModel: self.viewModel as! LastDataViewModel)

                        
                        self.stopLoding()
                        
                        
                        
                       // self.listRegion = result
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
    
    
//    func getCountStatus() {
//        
//        APIServiceProvider.rx.request(.GetCountStatus).subscribe { event in
//            switch event {
//            case let .success(response):
//                
//                let xml = XML.parse(response.data)
//                let status3 = xml["ews"]["status1"]
//                let status2 = xml["ews"]["status2"]
//                let status1 = xml["ews"]["status3"]
//                let status4 = xml["ews"]["status9"]
//                
//                self.dashboards[0].value = status1.text ?? "0"
//                self.dashboards[1].value = status2.text ?? "0"
//                self.dashboards[2].value = status3.text ?? "0"
//                self.dashboards[3].value = status4.text ?? "0"
////                self.tableview.reloadData()
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
//                    if Int(self.dashboards[0].value ?? "0")! == 0 && Int(self.dashboards[1].value ?? "0")! == 0 && Int(self.dashboards[2].value ?? "0")! == 0 {
//                        
//                        let alert = UIAlertController(title: "ไม่มีการเตือนภัย", message: "", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                        self.present(alert, animated: true)
//                    }
//                    
//                   
//                }
//                
//            case let .failure(error):
//                self.dashboards[0].value = "0"
//                self.dashboards[1].value = "0"
//                self.dashboards[2].value = "0"
//                self.dashboards[3].value = "0"
//            }
//        }
//    }
//    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // Set the status bar style to complement night-mode.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func loadMapView() {
        
//        let camera = GMSCameraPosition.camera(withLatitude: AppDelegate.shareDelegate.currentLocation!.latitude , longitude: AppDelegate.shareDelegate.currentLocation!.longitude, zoom: 5.0)
        
        let camera = GMSCameraPosition.camera(withLatitude: 13.806684877238261, longitude:  100.5057400551459, zoom: 5.0)
        
//        ,
        
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
        
        configure(LastDataViewModel())
        
    }
    
    
    func configure(_ interface: LastDataStationProtocol) {
        self.viewModel = interface
        bindToViewModel()
//        self.getWarning(type: "6")
//        self.getLastData(type: "all_warn")
    }
    
    fileprivate func showAlert(data: StationXLastDataModel) {
        DispatchQueue.main.async {
            self.listMarker.append(data)
//            self.tableview.reloadData()
            
            print("data22 \(data.title) -- \(data.rain12h)")
            
            self.stopLoding()
            if let lat = data.latitude!.toDouble() {
                if let long = data.longitude!.toDouble() {
                    switch data.type_status {
                    case 3:
                        self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: self.index, iconMarker: self.markerEvacuateView)
                    case 2:
                        self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: self.index, iconMarker: self.markerWarningView)
                    case 1:
                        self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: self.index, iconMarker: self.markerBewareView)
                    case 9:
                        self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: self.index, iconMarker: self.markerDefaultView)
                    default:
                        self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: self.index, iconMarker: self.markerWhiteView)
                    }
                }
            }
            
            self.index += 1
            
            
        }
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
        if indexPath.row == dashboards.count-1 {
            cell.iconView.isHidden = true
        }else {
            cell.iconView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/CGFloat(dashboards.count)
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        showPickerController(index: Int(marker.snippet!)!)
        
        return true
    }
    
    func showPickerController(index: Int) {
        print("showPickerController")
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let customView = UIView()
        customView.backgroundColor = .white
        alertController.view.addSubview(customView)
        alertController.view.backgroundColor = .red
        alertController.view.layer.cornerRadius = 8
        alertController.view.layer.masksToBounds = true
        
        customView.anchor(alertController.view.topAnchor, left: alertController.view.leftAnchor, bottom: alertController.view.bottomAnchor, right: alertController.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//        customView.view.backgroundColor = .white
        customView.addSubview(titleLabel)
        customView.addSubview(addressLabel)
        customView.addSubview(viewRecenty)
        customView.addSubview(rainLabel)
        customView.addSubview(valueLabel)
        customView.addSubview(valueUnitLabel)
        customView.addSubview(Pm25Label)
        
        titleLabel.anchor(customView.topAnchor, left: customView.leftAnchor, bottom: nil, right: customView.rightAnchor, topConstant: 5, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        addressLabel.anchor(titleLabel.bottomAnchor, left: customView.leftAnchor, bottom: nil, right: customView.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        viewRecenty.anchor(addressLabel.bottomAnchor, left: customView.leftAnchor, bottom: customView.bottomAnchor, right: nil, topConstant: 5, leftConstant: 20, bottomConstant: 8, rightConstant: 20, widthConstant: alertController.view.frame.width/2, heightConstant: 0)
        
        viewRecenty.addSubview(iconView)
        viewRecenty.addSubview(textRecenty)
        iconView.anchor(viewRecenty.topAnchor, left: viewRecenty.leftAnchor, bottom: nil, right: viewRecenty.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 60)
        
        textRecenty.anchor(iconView.bottomAnchor, left: viewRecenty.leftAnchor, bottom: viewRecenty.bottomAnchor, right: viewRecenty.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        rainLabel.anchor(addressLabel.bottomAnchor, left: iconView.rightAnchor, bottom: nil, right: customView.rightAnchor, topConstant: 5, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        
        valueLabel.anchor(rainLabel.bottomAnchor, left: iconView.rightAnchor, bottom: nil, right: valueUnitLabel.leftAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        valueUnitLabel.anchor(nil, left: valueLabel.rightAnchor, bottom: valueLabel.bottomAnchor, right: customView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 8, widthConstant: 25, heightConstant: 0)
        
        Pm25Label.anchor(nil, left: nil, bottom: alertController.view.bottomAnchor, right: alertController.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 3, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        
        print("data \(listMarker[index].title) -- \(listMarker[index].rain12h)")
        
        setValueAlert(station: listMarker[index])
        
        self.present(alertController, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
            
            let tapRecenty = UITapGestureRecognizer(target: self, action: #selector(self.handleRecentyRain))
            self.viewRecenty.isUserInteractionEnabled = true
            self.viewRecenty.addGestureRecognizer(tapRecenty)
            
        }
    }
    
    
    func setValueAlert(station: StationXLastDataModel) {
       
        
//        #imageLiteral(resourceName: "simulator_screenshot_229382E6-0BEB-463F-B77E-2672A65E4046.png
        selectedStation = station
        
        titleLabel.text = station.title!
        
        let stringValue = station.address!
        let attributedString = NSMutableAttributedString(string: stringValue)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.maximumLineHeight = 17.0
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        attributedString.addAttribute(
            .font,
            value: UIFont.PrimaryLight(size: CGFloat(15)),
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        addressLabel.attributedText = attributedString
        
        
        if station.status == "สถานการณ์ ฝนตกเล็กน้อย" {
            rainLabel.text = "ปริมาณน้ำฝนสะสม"
//            valueUnitLabel.text = "มม."
        }else {
            if station.warning_type == "rain" {
                rainLabel.text = "ปริมาณน้ำฝนสะสม"
//                valueUnitLabel.text = "มม."
            } else {
                rainLabel.text = "ระดับน้ำ"
//                valueUnitLabel.text = "ม."
            }
        }
        
        print("type_status -- \(station.type_status) -- \(station.rain12h!) -- \(station.value!)")
        
        if station.type_status == 9 || station.type_status == -999 || station.type_status == 0  {
            valueLabel.text = "\(station.rain12h!)"

        } else {
            valueLabel.text = "\(station.value!)"

        }
        

        
        if let pm2Double = station.pm25!.toDouble() {
            Pm25Label.text = "PM 2.5 = \(pm2Double)"
        }else {
            Pm25Label.text = "PM 2.5 = \(station.pm25!)"
        }
        
        
        switch station.status! {
        case "สถานการณ์ อพยพ":
            iconView.image = UIImage(named: "rain_tornado")!
            break
        case "สถานการณ์ เตือนภัย":
            iconView.image = UIImage(named: "rain_thunder")!
            break
        case "สถานการณ์ เฝ้าระวัง":
            iconView.image = UIImage(named: "rain")!
            break
        case "สถานการณ์ ฝนตกเล็กน้อย":
            iconView.image = UIImage(named: "overcast")!
            break
        default:
            iconView.image = UIImage(named: "overcast")!
        }
    }
    
    @objc func handleRecentyRain(){
        let rootVC = DetailMapStationViewController()
        rootVC.station = self.selectedStation!
        let rootNC = UINavigationController(rootViewController: rootVC)
        
        self.dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.async {
            self.present(rootNC, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func dismissAlertController()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if AppDelegate.shareDelegate.stations != nil {
            switch indexPath.row {
            case 0:
                getWarning(type: "1")
                break
//                getLastData(type: "สถานการณ์ อพยพ")
            case 1:
                getWarning(type: "2")
                break
//                getLastData(type: "สถานการณ์ เตือนภัย")
            case 2:
                getWarning(type: "3")
                break
//                getLastData(type: "สถานการณ์ เฝ้าระวัง")
            case 3:
                getWarning(type: "4")
                break
//                getLastData(type: "สถานการณ์ ฝนตกเล็กน้อย")
            default:
                getWarning(type: "5")
                break
//                getLastData(type: "all")
            }
//        }
        
    }
    
    func getLastData(type: String) {
        self.startLoding()
        self.listMarker.removeAll()
        self.index = 0
        mapView.clear()
        DispatchQueue.global(qos: .background).async {
            LastDataModel.FetchMapLastData(type: type, viewModel: self.viewModel as! LastDataViewModel)
            DispatchQueue.main.async {
                self.stopLoding()
            }
        }
    }
    
    
    func getMap() {
        for (index,item) in self.listMarker.enumerated() {
            if let lat = item.latitude!.toDouble() {
                if let long = item.longitude!.toDouble() {
                    //                    Thread.sleep(forTimeInterval: 0.0001)
                    DispatchQueue.main.async {
                        switch item.status {
                        case "สถานการณ์ อพยพ":
                            self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: index, iconMarker: self.markerEvacuateView)
                        case "สถานการณ์ เตือนภัย":
                            self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: index, iconMarker: self.markerWarningView)
                        case "สถานการณ์ เฝ้าระวัง":
                            self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: index, iconMarker: self.markerBewareView)
                        case "สถานการณ์ ฝนตกเล็กน้อย":
                            self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: index, iconMarker: self.markerDefaultView)
                        default:
                            self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: index, iconMarker: self.markerBewareView)
                        }
                        
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            
            
            self.stopLoding()
            let camera = GMSCameraPosition.camera(withLatitude:13.708019369618574, longitude: 100.40275714558622, zoom: 5.0)
            self.mapView.animate(to: camera)
//            let camera = GMSCameraPosition.camera(withLatitude: AppDelegate.shareDelegate.currentLocation!.latitude, longitude: AppDelegate.shareDelegate.currentLocation!.longitude, zoom: 5.0)
//            self.mapView.animate(to: camera)
        }
        
        
    }
    
}


extension MapStationViewController {
    
    func bindToViewModel() {
        viewModel.output.showMessageAlert = showAlert()
    }
    
    func showAlert() -> ((StationXLastDataModel) -> Void) {
        print("dldldl")
        return {  [weak self] data in
            guard let weakSelf = self else { return }
            weakSelf.showAlert(data: data)
        }
    }
}
