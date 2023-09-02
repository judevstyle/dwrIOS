//
//  NewsViewController.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 9/2/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import UIKit
import Moya
import Toast_Swift
import Toast
class NewsViewController: UIViewController {

    let APIServiceProvider = MoyaProvider<APIService>()
    let apiServiceJsonProvider = MoyaProvider<APIJsonService>()
    var imagePickerHelp: ImagePickerHelp?

    var proveinceSelect:SelectionModel? = nil
    var amPhurSelect:SelectionModel? = nil
    var districSelect:SelectionModel? = nil
    var imgName:String? = nil

    public let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.backgroundColor = .clear
        return view
    }()
    
    
    lazy var provinceTextView: UILabel = {
        let view = UILabel()
//        view.font = .header9
        view.text = "จังหวัด"
//        view.f
        return view
    }()
    
    lazy var amphurTextView: UILabel = {
        let view = UILabel()
//        view.font = .header9
        view.text = "อำเภอ"
//        view.f
        return view
    }()
    
    lazy var districTextView: UILabel = {
        let view = UILabel()
//        view.font = .header9
        view.text = "ตำบล"
//        view.f
        return view
    }()
    
    lazy var stationTextView: UILabel = {
        let view = UILabel()
//        view.font = .header9
        view.text = "สถานี"
//        view.f
        return view
    }()
    
    lazy var stationValueView: UILabel = {
        let view = UILabel()
//        view.font = .header9
        view.text = ""
//        view.f
        return view
    }()
    
    lazy var descTitleTextView: UILabel = {
        let view = UILabel()
//        view.font = .header9
        view.text = "รายละเอียด"
//        view.f
        return view
    }()
    
    
    lazy var imgTitleTextView: UILabel = {
        let view = UILabel()
//        view.font = .header9
        view.text = "รูปภาพ"
//        view.f
        return view
    }()
    
    lazy var imgView: UIImageView = {
        let view = UIImageView()
//        view.f
        return view
    }()
    
    lazy var imgAddView: UIImageView = {
        let view = UIImageView()
//        view.f
        return view
    }()
    
    
    lazy var inputInfoView: UITextView = {
        let view = UITextView()
        view.setAllRounded(rounded: 8)
//        view.pess

        view.setBorder(width: 1.0, color: .CED4D9)
        view.backgroundColor = .white
        view.textColor = .black
//        view.font = .smallText
//        view.delegate = self
        return view
    }()
    
    
    let inputProvince: TextFieldSelectView = {
        let view = TextFieldSelectView(placeholder: "เลือก", listSelect: [])
        return view
    }()
    
    private let dmProvinceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let inputAmphur: TextFieldSelectView = {
        let view = TextFieldSelectView(placeholder: "เลือก", listSelect: [])
        return view
    }()
    private let dmAmphurView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let inputDistric: TextFieldSelectView = {
        let view = TextFieldSelectView(placeholder: "เลือก", listSelect: [])
        return view
    }()
    private let dmDistricView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    lazy var bgImage: UIView = {
        let view = UIView()
        view.setAllRounded(rounded: 8)
        view.backgroundColor = .bgTrans
        return view
    }()
    
    
    
    private let btnSave: UIView = {
        let view = UIButton()
        view.backgroundColor = .green
        view.setAllRounded(rounded: 8)
        view.setTitle("บันทึก", for: .normal)
        view.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
//        view.titleLabel?.font = .h3Text
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let baseURL = Bundle.main.infoDictionary!["API_BASE_URL"] as! String

        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        self.setTitleNavigation(title: "แจ้งเตือนภัย")
        
        
         let leftbutton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(handleClose))
                   leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
     

        
        setupUI()
        getProvince()
        
    }
    

    func setupUI(){
        
        self.inputAmphur.delegate = self
        self.inputDistric.delegate = self
        self.inputProvince.delegate = self

        var mediaTypes: [ImagePickerMediaTypes] = [.publicImage]
        var sourceType: [UIImagePickerController.SourceType] = [.camera, .photoLibrary]
//        if self.getCollectionGridType() == .video {
//            mediaTypes = [.publicMovie]
//            sourceType = [.photoLibrary]
//        }
//
        
        let config = ImagePickerHelpConfig(allowsEditing: false,
                                           mediaTypes: mediaTypes,
                                           sourceType: sourceType,
                                           delegate: self,
                                           enableCropImage: true)
        DispatchQueue.main.async {
            
            self.imagePickerHelp = ImagePickerHelp(config: config)
            
        }
        
        
        let margins = self.view.layoutMarginsGuide

        self.view.addSubview(scrollView)
//        scrollView.backgroundColor = .CED4D9
        scrollView.anchor(margins.topAnchor, left: self.view.leftAnchor, bottom: margins.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        scrollView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        scrollView.addSubview(stackViewContainer)
//        stackViewContainer.backgroundColor = .red
        stackViewContainer.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
//        dmProvinceView.backgroundColor = .white
        dmProvinceView.addSubview(inputProvince)
        inputProvince.anchor(dmProvinceView.topAnchor, left: dmProvinceView.leftAnchor, bottom: dmProvinceView.bottomAnchor, right: dmProvinceView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dmAmphurView.addSubview(inputAmphur)
        inputAmphur.anchor(dmAmphurView.topAnchor, left: dmAmphurView.leftAnchor, bottom: dmAmphurView.bottomAnchor, right: dmAmphurView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dmDistricView.addSubview(inputDistric)
        inputDistric.anchor(dmDistricView.topAnchor, left: dmDistricView.leftAnchor, bottom: dmDistricView.bottomAnchor, right: dmDistricView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
   
        stackViewContainer.addArrangedSubview(provinceTextView)
        stackViewContainer.addArrangedSubview(dmProvinceView)
     
        stackViewContainer.addArrangedSubview(amphurTextView)
        stackViewContainer.addArrangedSubview(dmAmphurView)
//
        stackViewContainer.addArrangedSubview(districTextView)
        stackViewContainer.addArrangedSubview(dmDistricView)
        
        stackViewContainer.addArrangedSubview(stationTextView)
        stackViewContainer.addArrangedSubview(stationValueView)

        stackViewContainer.addArrangedSubview(descTitleTextView)
        
        stackViewContainer.addArrangedSubview(inputInfoView)
        inputInfoView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        
        
        
        imgAddView.image = UIImage(named: "ic_add_image1")?.withTintColor(.white, renderingMode: .alwaysOriginal)
//        imgAddView.tintColor = .blue

        bgImage.addSubview(imgAddView)
        bgImage.addSubview(imgView)
        
        let imgViewClick = UITapGestureRecognizer(target: self, action: #selector(handleCheckImage))
        imgView.addGestureRecognizer(imgViewClick)
        imgView.isUserInteractionEnabled = true
        self.imgView.contentMode = .scaleAspectFit
        
        imgView.setAllRounded(rounded: 8)
        
        imgAddView.anchor(bgImage.topAnchor, left: bgImage.leftAnchor, bottom: nil, right: nil, topConstant: (160/2)-30, leftConstant: (view.frame.width/2)-51, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
//        imgView.backgroundColor = . white
        imgView.anchor(bgImage.topAnchor, left: bgImage.leftAnchor, bottom: bgImage.bottomAnchor, right: bgImage.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
//        imgAddView.centerYAnchor.constraint(between: bgImage.bottomAnchor, and: bgImage.topAnchor)

        
        
        stackViewContainer.addArrangedSubview(imgTitleTextView)
        stackViewContainer.addArrangedSubview(bgImage)
        
        
        
        bgImage.heightAnchor.constraint(equalToConstant: 160).isActive = true

        
        
        
        stackViewContainer.addArrangedSubview(btnSave)
        btnSave.heightAnchor.constraint(equalToConstant: 48).isActive = true

//        inputInfoView.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        

    }
    
    @objc func handleCheckImage(){
       
        self.imagePickerHelp?.present()
        
    }
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func handleSave() {

        
        if self.proveinceSelect == nil {
            self.view.makeToast("เลือกจังหวัด")
            
        } else if self.proveinceSelect == nil {
            self.view.makeToast("เลือกอำเภอ")
            
        } else if self.proveinceSelect == nil {
            self.view.makeToast("เลือกตำบล")
            
        }else if self.inputInfoView.text == "" {
            self.view.makeToast("ระบุรายละเอียด")
            
        } else if self.imgName == nil {
            self.view.makeToast("เลือกรูปภาพ")
            
        } else {
            createNews()
            
            
        }
        

        
    }
    
    
    func createNews() {
    
        
        apiServiceJsonProvider.rx.request(.CreateNews(stn: districSelect?.stn ?? "", stn_name: districSelect?.stn_name ?? "", tambon: districSelect?.name ?? "", amphone: amPhurSelect?.name ?? "", province: proveinceSelect?.name ?? "", latitude:  districSelect?.lat ?? 0.0, longitude: districSelect?.lng ?? 0.0, text_news: self.inputInfoView.text, pic_news: imgName ?? "")).subscribe { event in

            switch event {
            case let .success(response):
                print("ddd -- \(response)")

                do {
                    let result = try JSONDecoder().decode(CallbackData.self, from: response.data)
                    print("ddd -- \(result)")
//                    self.startLoding()

                    DispatchQueue.main.async {

//                        self.stopLoding()
//                        if result.success {
                            self.view.makeToast("บันทึกข้อมูลเรียบร้อย")
                        self.dismiss(animated: true, completion: nil)

//                        } else {
//                            self.view.makeToast("เกิดข้อผิดพลาด กรุณาลองใหม่ภายหลัง")

//                        }
                    }
                    
                    
                    
                } catch { print("err --- \(error)") }
//                print("data ---- \(response.data)")
//                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
            case let .failure(error):
              print("ddd")
//                self.view.makeToast("เกิดข้อผิดพลาด กรุณาลองใหม่ภายหลัง")
//                self.dashboards[2].value = "0"
//                self.dashboards[3].value = "0"
            }
        
        }
        
        
        
    }
    
    
    func getProvince() {
    
        
        apiServiceJsonProvider.rx.request(.GetProvince).subscribe { event in

            switch event {
            case let .success(response):
                print("ddd -- \(response)")

                do {
                    let result = try JSONDecoder().decode([String].self, from: response.data)
                    print("ddd -- \(result)")
                    
                    DispatchQueue.main.async {

                    
                    self.startLoding()
                
                        
                    DispatchQueue.global(qos: .background).async {
//                        LastDataModel.setMethodAllWarnMap(viewModel: self.viewModel as! LastDataViewModel,stations: result)
                        
                        var dataModel:[SelectionModel] = []
                        
                        for data in result {
                    
                            dataModel.append(SelectionModel(id: 1, name: data ?? ""))
                        }
                                        
                        
                        DispatchQueue.main.async {
                            self.stopLoding()
                            self.inputProvince.setupValue(listSelect: dataModel)

                        }
                    }
                    }
                    
                    
                    
                } catch { print("err --- \(error)") }
//                print("data ---- \(response.data)")
//                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
            case let .failure(error):
              print("ddd")
//                self.dashboards[2].value = "0"
//                self.dashboards[3].value = "0"
            }
        
        }
        
        
        
    }
    
    func getAmphur() {
    
        print("getAmphur \(self.proveinceSelect?.name ?? "")")
        apiServiceJsonProvider.rx.request(.GetAmphone(pv: self.proveinceSelect?.name ?? "")).subscribe { event in

            switch event {
            case let .success(response):
                print("ddd -- \(response)")

                do {
                    let result = try JSONDecoder().decode([String].self, from: response.data)
                    print("ddd -- \(result)")
                    
                    DispatchQueue.main.async {

                    
                    self.startLoding()
                
                        
                    DispatchQueue.global(qos: .background).async {
//                        LastDataModel.setMethodAllWarnMap(viewModel: self.viewModel as! LastDataViewModel,stations: result)
                        
                        var dataModel:[SelectionModel] = []
                        
                        for data in result {
                    
                            dataModel.append(SelectionModel(id: 1, name: data ?? ""))
                        }
                                        
                        
                        DispatchQueue.main.async {
                            self.stopLoding()
                            self.inputAmphur.setupValue(listSelect: dataModel)

                        }
                    }
                    }
                    
                    
                    
                } catch { print("err --- \(error)") }
//                print("data ---- \(response.data)")
//                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
            case let .failure(error):
              print("ddd")
//                self.dashboards[2].value = "0"
//                self.dashboards[3].value = "0"
            }
        
        }
        
        
        
    }
    
    func getDistric() {
    
        print("getDistric -- \(self.amPhurSelect?.name ?? "")")

        apiServiceJsonProvider.rx.request(.GetTambon(am: self.amPhurSelect?.name ?? "")).subscribe { event in

            switch event {
            case let .success(response):
                print("ddd -- \(response)")

                do {
                    let result = try JSONDecoder().decode([TambonData].self, from: response.data)
                    print("ddd -- \(result)")
                    
                    DispatchQueue.main.async {

                    
                    self.startLoding()
                
                        
                    DispatchQueue.global(qos: .background).async {
//                        LastDataModel.setMethodAllWarnMap(viewModel: self.viewModel as! LastDataViewModel,stations: result)
                        
                        var dataModel:[SelectionModel] = []
                        
                        for data in result {
                    
                            dataModel.append(SelectionModel(id: 1, name: data.tambon ?? "",tm: "\(data.stn ?? "") \(data.name ?? "")",lat: Double((data.latitude ?? "0.0")),lng: Double((data.longitude ?? "0.0")) ))
                        }
                                        
                        
                        DispatchQueue.main.async {
                            self.stopLoding()
                            self.inputDistric.setupValue(listSelect: dataModel)

                        }
                    }
                    }
                    
                    
                    
                } catch { print("err --- \(error)") }
//                print("data ---- \(response.data)")
//                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
            case let .failure(error):
              print("ddd")
//                self.dashboards[2].value = "0"
//                self.dashboards[3].value = "0"
            }
        
        }
        
        
        
    }
    
    
    
    
    
    
    func uploadImage(image: UIImage, fileName: String?) {
    
        
      
        apiServiceJsonProvider.rx.request(.UploadFile(image: image, fileName: fileName)).subscribe { event in

            switch event {
            case let .success(response):
                print("ddd -- \(response)")

                do {
                    let result = try JSONDecoder().decode(CallbackData.self, from: response.data)
                    print("ddd -- \(result)")
                    
                    DispatchQueue.main.async {

                        self.imgName = result.msg
                    self.startLoding()
                
                        
                    DispatchQueue.global(qos: .background).async {
//                        LastDataModel.setMethodAllWarnMap(viewModel: self.viewModel as! LastDataViewModel,stations: result)
                        DispatchQueue.main.async {
                            self.stopLoding()
                        }
                    }
                    }
                    
                    
                    
                } catch { print("err --- \(error)") }
//                print("data ---- \(response.data)")
//                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
            case let .failure(error):
              print("ddd")
//                self.dashboards[2].value = "0"
//                self.dashboards[3].value = "0"
            }
        
        }

        
        
        
    }
    
}

extension NewsViewController: ImagePickerHelpDelegate {
    func didSelectImage(image: UIImage?, fileName: String?, imagePicker: ImagePickerHelp) {
        print("ffffffff \(fileName)")
        self.imgView.image = image!
        uploadImage(image: image!, fileName: fileName)
//        self.addListImage(image: image, fileName: fileName)
    }
    
    func didSelectVideo(imageThumbnail: UIImage?, imagePicker: ImagePickerHelp, videoUrl: URL?) {
//        if let image = imageThumbnail, let videoUrl = videoUrl {
//            self.addListVideo(image: image, videoUrl: videoUrl)
//        }
    }
}

extension NewsViewController : TextFieldSelectViewDelegate{
    func didSelectItem(_ item: SelectionModel?, view: TextFieldSelectView) {
        
        switch view {
        case self.inputProvince:
            self.proveinceSelect = item
            self.getAmphur()
            break
        case self.inputAmphur:
            self.amPhurSelect = item
            self.getDistric()

            break
        default :
            self.districSelect = item
            self.stationValueView.text = item?.tm ?? ""
            break
            
            
        }
       
    }
    
    
    
}
