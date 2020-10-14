//
//  AppDelegate.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 9/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import CoreData
import Moya
//import SwiftyXMLParser

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    static let shareDelegate = AppDelegate()
    var stations: [StationModel]! = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       

        DispatchQueue.global(qos: .background).async {
            self.stations = StationModel.FetchStations()
        }
        
             let attrs = [
                 NSAttributedString.Key.foregroundColor: UIColor.white,
                 NSAttributedString.Key.font: UIFont(name: "Kanit-Regular", size: 18)!
             ]
             
             UINavigationBar.appearance().titleTextAttributes = attrs
        
            window = UIWindow(frame: UIScreen.main.bounds)
               let rootVC = IntroViewController()
               let rootNC = UINavigationController(rootViewController: rootVC)
               window?.rootViewController = rootNC
               window?.makeKeyAndVisible()
               
        
        return true
    }
    
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "EwsAppiOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

