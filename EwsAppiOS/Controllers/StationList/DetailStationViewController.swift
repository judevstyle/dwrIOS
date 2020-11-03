//
//  DetailStationViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 27/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

class DetailStationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var cellID = "CellStation"
    
    var currentPage: Int = 0
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromSafeArea
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    
    
    lazy var titlLabel: UILabel = {
        let label = UILabel()
        label.text = "บ้านแซะ"
        label.font = .PrimaryRegular(size: 23)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        let unit = "ต.หนองไผ่ อ.ด่านมะขามเตี้ย จ.กาญจนบุรี\nหมู่บ้านคลอบคลุมจำนวน 3 หมู่บ้าน"
        
        let attributedText = NSMutableAttributedString(string: unit, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 17), NSAttributedString.Key.foregroundColor: UIColor.systemYellow])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var previousBtn: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "previous")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(previousAction), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = .white
        return button
    }()
    
    
    lazy var nextBtn: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "next")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = .white
        
        return button
    }()
    
    //    lazy var pageControl: UIPageControl = {
    //        let pageControl = UIPageControl()
    //
    //        pageControl.currentPageIndicatorTintColor = .AppPrimary()
    //        pageControl.pageIndicatorTintColor = .blackAlpha(alpha: 0.2)
    //        pageControl.currentPage = 0
    //
    //        return pageControl
    //
    //    }()
    
    var stations_last: [StationXLastDataModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .AppPrimary()
        self.setHideBorderNavigation(status: true)
        self.setBarStyleNavigation(style: .black)
        //        self.setTitleNavigation(title: "สรุปสถานการ์ณฝน")
        
        let leftbutton = UIBarButtonItem(image: UIImage(systemName:  "clear"), style: .done, target: self, action: #selector(handleClose))
        
        leftbutton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftbutton
        
        collectionView.register(DetailStationViewCell.self, forCellWithReuseIdentifier: cellID)
        
        
        view.addSubview(previousBtn)
        previousBtn.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        
        view.addSubview(nextBtn)
        nextBtn.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 45, heightConstant: 45)
        
        
        view.addSubview(titlLabel)
        titlLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: previousBtn.rightAnchor, bottom: nil, right: nextBtn.leftAnchor, topConstant: -30, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        view.addSubview(valueLabel)
        valueLabel.anchor(titlLabel.bottomAnchor, left: previousBtn.rightAnchor, bottom: nil, right: nextBtn.leftAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(collectionView)
        collectionView.anchor(valueLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        DispatchQueue.main.async {
            let scrollIndex: NSIndexPath = NSIndexPath(item: self.currentPage, section: 0)
            self.collectionView.scrollToItem(at: scrollIndex as IndexPath, at: .right, animated: false)
            self.setStateButtonPreviousNext()
            
            self.setValueStation()
            
        }
    }
    
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
    
    
    @objc func previousAction (){
        pageSelected(index: currentPage-1, animated: true, position: .left)
    }
    
    @objc func nextAction (){
        pageSelected(index: currentPage+1, animated: true, position: .right)
    }
    
    func setStateButtonPreviousNext()  {
        if currentPage == 0 {
            previousBtn.tintColor = .whiteAlpha(alpha: 0.5)
            previousBtn.isEnabled = false
        }else if currentPage == (self.stations_last!.count-1)  {
            nextBtn.tintColor = .whiteAlpha(alpha: 0.5)
            nextBtn.isEnabled = false
        }else {
            previousBtn.tintColor = .white
            previousBtn.isEnabled = true
            nextBtn.tintColor = .white
            nextBtn.isEnabled = true
        }
        
        if self.stations_last!.count == 1 {
            previousBtn.tintColor = .whiteAlpha(alpha: 0.5)
            previousBtn.isEnabled = false
            nextBtn.tintColor = .whiteAlpha(alpha: 0.5)
            nextBtn.isEnabled = false
        }
    }
    
    
    func pageSelected(index: Int, animated: Bool, position: UICollectionView.ScrollPosition) {
        let scrollIndex: NSIndexPath = NSIndexPath(item: index, section: 0)
        
        collectionView.scrollToItem(at: scrollIndex as IndexPath, at: position, animated: animated)
        currentPage = index
        self.setStateButtonPreviousNext()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.setValueStation()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.stations_last!.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DetailStationViewCell
        
        cell.station = self.stations_last![indexPath.row]
        
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = view.frame.width
        currentPage = Int(collectionView.contentOffset.x/pageWidth)
        setStateButtonPreviousNext()
        setValueStation()
    }
    
    func setValueStation() {
        titlLabel.text = "\(self.stations_last![currentPage].title!)"
        
        let unit = "\(self.stations_last![currentPage].address!)"
        
        let attributedText = NSMutableAttributedString(string: unit, attributes: [NSAttributedString.Key.font : UIFont.PrimaryLight(size: 17), NSAttributedString.Key.foregroundColor: UIColor.systemYellow])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        valueLabel.attributedText = attributedText
        valueLabel.textAlignment = .center
        valueLabel.numberOfLines = 2
        valueLabel.adjustsFontSizeToFitWidth = true
    }
    
}
