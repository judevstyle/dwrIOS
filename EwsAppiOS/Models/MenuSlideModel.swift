//
//  MenuSlideModel.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 26/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit

struct MenuSlideModel {
    var icon: UIImage?
    var index: Int?
    
    init(icon: UIImage?, index: Int?) {
        self.icon = icon
        self.index = index
    }
    
    
    static func menus() -> [MenuSlideModel] {
        var menus = [MenuSlideModel]()
        
        menus.append(MenuSlideModel(icon: UIImage(named: "iconAppNew"), index: 0))
        menus.append(MenuSlideModel(icon:  UIImage(systemName: "house"), index: 1))
        menus.append(MenuSlideModel(icon:  UIImage(named: "ic_maps"), index: 2))
        menus.append(MenuSlideModel(icon:  UIImage(named: "radar"), index: 3))

        menus.append(MenuSlideModel(icon:  UIImage(named: "ic_map_view"), index: 4))
        menus.append(MenuSlideModel(icon:  UIImage(named: "ic_alert"), index: 8))

        menus.append(MenuSlideModel(icon:  UIImage(named: "ic_search-location"), index: 5))
        
        menus.append(MenuSlideModel(icon:  UIImage(named: "ic_setting_sound"), index: 6))
        menus.append(MenuSlideModel(icon: UIImage(named: "ic_informaiton"), index: 7))
        
        return menus
    }
}
