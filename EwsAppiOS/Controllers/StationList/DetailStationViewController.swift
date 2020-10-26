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
    
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromSafeArea
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    
      let pageControl: UIPageControl = {
          let pageControl = UIPageControl()
          
          pageControl.currentPageIndicatorTintColor = .AppPrimary()
          pageControl.pageIndicatorTintColor = .blackAlpha(alpha: 0.2)
          
          return pageControl
          
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
        
        
        collectionView.register(DetailStationViewCell.self, forCellWithReuseIdentifier: cellID)
        
        view.addSubview(collectionView)
        collectionView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
       }
       

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
       
       var pages = PageDetailStationModel.page()
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        pageControl.numberOfPages = pages.count
        return pages.count
       }
       
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DetailStationViewCell
        
        cell.page = pages[indexPath.row]
    
           return cell
       }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           
           let pageWidth = view.frame.width
           pageControl.currentPage = Int(collectionView.contentOffset.x/pageWidth)
           
        print(pageControl.currentPage)
           
       }
    
}
