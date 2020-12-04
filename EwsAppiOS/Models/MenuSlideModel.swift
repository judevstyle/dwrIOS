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
    
    init(icon: UIImage?) {
        self.icon = icon
    }
    
    
    static func menus() -> [MenuSlideModel] {
        var menus = [MenuSlideModel]()
        
        menus.append(MenuSlideModel(icon: UIImage(named: "IconApp")))
        menus.append(MenuSlideModel(icon:  UIImage(systemName: "house")))
        menus.append(MenuSlideModel(icon:  UIImage(systemName: "magnifyingglass")))
        menus.append(MenuSlideModel(icon:  UIImage(systemName: "mappin.and.ellipse")))
        menus.append(MenuSlideModel(icon:  UIImage(systemName: "map")))
        menus.append(MenuSlideModel(icon:  UIImage(systemName: "text.append")))
        menus.append(MenuSlideModel(icon: UIImage(systemName: "info.circle")))
        
        return menus
    }
}
