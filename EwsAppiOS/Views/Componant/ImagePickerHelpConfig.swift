//
//  ImagePickerHelpConfig.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 9/3/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
import UIKit

public struct ImagePickerHelpConfig {
    public let allowsEditing: Bool
    public let mediaTypes: [String]
    public let sourceType: [UIImagePickerController.SourceType]
    public let delegate: ImagePickerHelpDelegate?
    public let enableCropImage: Bool
    
    init(allowsEditing: Bool = true,
         mediaTypes: [ImagePickerMediaTypes],
         sourceType: [UIImagePickerController.SourceType],
         delegate: ImagePickerHelpDelegate?,
         enableCropImage: Bool = false) {
        self.allowsEditing = allowsEditing
        self.mediaTypes = mediaTypes.map({ $0.rawValue })
        self.sourceType = sourceType
        self.delegate = delegate
        self.enableCropImage = enableCropImage
    }
}

public enum ImagePickerMediaTypes: String {
    case publicImage = "public.image"
    case publicMovie = "public.movie"
}
