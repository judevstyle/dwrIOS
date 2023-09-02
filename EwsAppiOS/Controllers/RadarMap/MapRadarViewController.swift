//
//  MapRadarViewController.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 12/11/22.
//  Copyright © 2022 ssoft. All rights reserved.
//


import UIKit
import GoogleMaps
import GoogleMapsUtils
import Moya
import GoogleMaps
import CoreLocation

//import AlamofireImage
import SwiftyXMLParser
class MapRadarViewController : UIViewController, GMSMapViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let APIServiceProvider = MoyaProvider<APIService>()
    let apiServiceJsonProvider = MoyaProvider<APIJsonService>()

    var locationCurrent:CLLocationCoordinate2D? = nil
    private let locationManager = CLLocationManager()

    

    
    private var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    
    var markerCustom: GMSMarker?
    
    var marker: GMSMarker!
    var raduins:Int = 12

    var select = 0
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
    
    let sliderRadar: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 800
        slider.minimumValue = 1

        
        return slider
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
    
    
    let viewSlideMain: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let textRadar: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .blackAlpha(alpha: 0.7)
        label.text = "สถานีภายใน 12 km."
        label.font = .PrimaryLight(size: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    var dashboards = DashboardCardModel.dashboardsMapRadar()
    
    var listMarker: [StationXLastDataModel] = []
    var selectedStation: StationXLastDataModel? = nil
    
    var viewModel: LastDataStationProtocol!
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String

        print("baseURL \(baseURL)")
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
        
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 100, heightConstant: 200)
        
        
        
        
        viewSlideMain.addSubview(textRadar)
        viewSlideMain.addSubview(sliderRadar)
        sliderRadar.value = 12
        
        sliderRadar.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)

        textRadar.anchor(viewSlideMain.topAnchor, left: viewSlideMain.leftAnchor, bottom: nil, right: viewSlideMain.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
        sliderRadar.anchor(textRadar.bottomAnchor, left: viewSlideMain.leftAnchor, bottom: nil, right: viewSlideMain.rightAnchor, topConstant: 4, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
    
        
        view.addSubview(viewSlideMain)
        viewSlideMain.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 26, bottomConstant: 26, rightConstant: 26, widthConstant: 0, heightConstant: 80)
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMapView()

        DispatchQueue.global(qos: .background).async {
//            self.getCountStatus()
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        
        let step: Float = 1

        let roundedValue = round(slider.value / step) * step
//        slider.value = roundedValue
        print("slider.value \(roundedValue)")
        textRadar.text = "สถานีภายใน \(Int(roundedValue)) km."

        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                // handle drag began
                print("aaaa")
            case .moved:
                // handle drag moved
                print("aaaa")

            case .ended:
                // handle drag ended
                print("ccccc")

                raduins = (Int(roundedValue))
                getProvince()
            default:
                break
            }
        }
    }
    
    
    func getProvince() {
    
        
        var type = "all"
        if select == 0 {
            type = "warn" }
        apiServiceJsonProvider.rx.request(.GetRadarService(type: type, radius: self.raduins, lat: locationCurrent!.latitude, lng: locationCurrent!.longitude)).subscribe { event in
            self.mapView.clear()

            let km = self.raduins*1000
            let circleCenter = CLLocationCoordinate2DMake(13.7194367, 100.6164316)//change to your center point
            let circ = GMSCircle(position: circleCenter, radius: CLLocationDistance(km) )//radius in meters

            circ.fillColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 0.05)
            circ.strokeColor = UIColor.blue
            circ.strokeWidth = 1
            circ.map = self.mapView
            switch event {
            case let .success(response):
                print("ddd -- \(response.data)")

                do {
                    let result = try JSONDecoder().decode([StationDataResponse].self, from: response.data)
                  //  print("ddd -- \(result[0].stn)")
                    
                    DispatchQueue.main.async {

                    
                    self.startLoding()
                    self.listMarker.removeAll()
                    self.index = 0
                    DispatchQueue.global(qos: .background).async {
                        LastDataModel.setMethodAllWarnMap(viewModel: self.viewModel as! LastDataViewModel,stations: result)
                        DispatchQueue.main.async {
                            self.stopLoding()
                        }
                    }
                    }
                    
                    
                    
                } catch { print("err --- \(error)") }
//                print("data ---- \(response.data)")
//                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
            case let .failure(error):
                self.dashboards[0].value = "0"
                self.dashboards[1].value = "0"
//                self.dashboards[2].value = "0"
//                self.dashboards[3].value = "0"
            }
        
        }

        
        
        
    }
    
    
    
    func getCountStatus() {
        APIServiceProvider.rx.request(.GetCountStatus).subscribe { event in
            switch event {
            case let .success(response):
                
                let xml = XML.parse(response.data)
                let status3 = xml["ews"]["status1"]
                let status2 = xml["ews"]["status2"]
                let status1 = xml["ews"]["status3"]
                let status4 = xml["ews"]["status9"]
                
                self.dashboards[0].value = status1.text ?? "0"
                self.dashboards[1].value = status2.text ?? "0"
//                self.dashboards[2].value = status3.text ?? "0"
//                self.dashboards[3].value = status4.text ?? "0"
                self.tableview.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    if Int(self.dashboards[0].value ?? "0")! == 0 && Int(self.dashboards[1].value ?? "0")! == 0 && Int(self.dashboards[2].value ?? "0")! == 0 {
                        
                        let alert = UIAlertController(title: "ไม่มีการเตือนภัย", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                   
                }
                
            case let .failure(error):
                self.dashboards[0].value = "0"
                self.dashboards[1].value = "0"
//                self.dashboards[2].value = "0"
//                self.dashboards[3].value = "0"
            }
        }
    }
    
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
        
        print("00000-----")
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
     
        
        configure(LastDataViewModel())
        initLLocation()

//        getProvince()

        
    }
    
    
    
    func initLLocation(){
        
        //initializing CLLocationManager
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    
    
    
    
    func configure(_ interface: LastDataStationProtocol) {
        self.viewModel = interface
        bindToViewModel()
//        self.getLastData(type: "all_warn")
    }
    
    fileprivate func showAlert(data: StationXLastDataModel) {
        DispatchQueue.main.async {
            self.listMarker.append(data)
            self.tableview.reloadData()
            self.stopLoding()
            if let lat = data.latitude!.toDouble() {
                if let long = data.longitude!.toDouble() {
                    switch data.status {
                    case "สถานการณ์ อพยพ":
                        self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: self.index, iconMarker: self.markerEvacuateView)
                    case "สถานการณ์ เตือนภัย":
                        self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: self.index, iconMarker: self.markerWarningView)
                    case "สถานการณ์ เฝ้าระวัง":
                        self.handleAddMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), index: self.index, iconMarker: self.markerBewareView)
                    case "สถานการณ์ ฝนตกเล็กน้อย":
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
        if indexPath.row == select {
            cell.viewCard.backgroundColor = UIColor(named: "RadarSelect")
        }else{
            cell.viewCard.backgroundColor = .whiteAlpha(alpha: 0.5)

        }
        cell.iconView.isHidden = false
        cell.valueLabel.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
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
        
        valueLabel.text = "\(station.value!)"

        
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
        
        
        if(self.select != indexPath.row){
            self.select = indexPath.row
            tableview.reloadData()
            getProvince()
            
        }
        
//        if AppDelegate.shareDelegate.stations != nil {
//            switch indexPath.row {
//            case 0:
//                getLastData(type: "สถานการณ์ อพยพ")
//            case 1:
//                getLastData(type: "สถานการณ์ เตือนภัย")
//            case 2:
//                getLastData(type: "สถานการณ์ เฝ้าระวัง")
//            case 3:
//                getLastData(type: "สถานการณ์ ฝนตกเล็กน้อย")
//            default:
//                getLastData(type: "all")
//            }
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
            let camera = GMSCameraPosition.camera(withLatitude: AppDelegate.shareDelegate.currentLocation!.latitude, longitude: AppDelegate.shareDelegate.currentLocation!.longitude, zoom: 5.0)
            self.mapView.animate(to: camera)
        }
        
        
    }
    
}


extension MapRadarViewController {
    
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




extension MapRadarViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        self.mapView?.isMyLocationEnabled = true
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        
        locationCurrent = location.coordinate
        print("location \(locationCurrent)")
        let camera  = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 10)
        self.mapView.camera = camera

//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude))
//
//            mapView.setMinZoom(4.6, maxZoom: 20)
        
        locationManager.stopUpdatingLocation()
        getProvince()
    }
}
