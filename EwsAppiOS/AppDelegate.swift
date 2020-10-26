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
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static let shareDelegate = AppDelegate()
    var stations: [StationModel]! = nil
    var currentLocation: CLLocationCoordinate2D? = CLLocationCoordinate2DMake(15.8700, 100.9925) //Thailand
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.PrimaryRegular(size: 18)
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attrs
        
        GMSServices.provideAPIKey("AIzaSyDg-bwviwDVeAhD_JPJt4mdCidS9dK4uvA")
        GMSPlacesClient.provideAPIKey("AIzaSyDg-bwviwDVeAhD_JPJt4mdCidS9dK4uvA")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = MainAppViewController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        DispatchQueue.global(qos: .background).async {
            AppDelegate.shareDelegate.stations = StationModel.FetchStations()
        }
        
        
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

