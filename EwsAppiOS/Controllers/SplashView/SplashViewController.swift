//
//  SplashViewController.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 17/12/2563 BE.
//  Copyright © 2563 BE ssoft. All rights reserved.
//

import UIKit
import FirebaseMessaging

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.startLodingCircle()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidLoadStationsSuccess(_:)), name: .didLoadStationsSuccess, object: nil)
        
    }

    
    @objc func onDidLoadStationsSuccess(_ notification:Notification) {
        self.stopLoding()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let rootVc = MainAppViewController()
        appDelegate.window?.rootViewController = rootVc
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
