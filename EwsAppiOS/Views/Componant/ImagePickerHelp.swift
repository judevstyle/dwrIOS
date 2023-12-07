//
//  ImagePickerHelp.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 9/3/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
import UIKit
import PermissionsKit
import PhotoLibraryPermission
import CameraPermission
import AVFoundation
import TOCropViewController
public enum RatioPickerImage{
    
    case SQUERE,PROTATE,NONE
    
}
public protocol ImagePickerHelpDelegate: AnyObject {
    func didSelectImage(image: UIImage?, fileName: String?, imagePicker: ImagePickerHelp)
    func didSelectVideo(imageThumbnail: UIImage?, imagePicker: ImagePickerHelp, videoUrl: URL?)
}

public extension ImagePickerHelpDelegate {
    func didSelectImage(image: UIImage?, fileName: String?, imagePicker: ImagePickerHelp) {}
    func didSelectVideo(imageThumbnail: UIImage?, imagePicker: ImagePickerHelp, videoUrl: URL?) {}
}

open class ImagePickerHelp: NSObject {
    
    private let sourceType: [UIImagePickerController.SourceType]
    private let pickerController: UIImagePickerController
    private let presentController: UIViewController
    weak var delegate: ImagePickerHelpDelegate?
    private var enableCropImage: Bool = false
    private var fileNamePreCropImage: String? = nil
    
    private var ratioPickerImage: RatioPickerImage

    
    public init(config: ImagePickerHelpConfig,
                pickerController: UIImagePickerController = UIImagePickerController(),
                ratioPickerImage:RatioPickerImage  = RatioPickerImage.NONE
    ) {
        self.ratioPickerImage = ratioPickerImage
        self.sourceType = config.sourceType
        self.pickerController = pickerController
        self.presentController = UIApplication.getTopViewController() ?? UIViewController()
        self.enableCropImage = config.enableCropImage
        super.init()
        self.delegate = config.delegate
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = config.allowsEditing
        self.pickerController.mediaTypes = config.mediaTypes
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            switch type {
            case .camera:
                if Permission.camera.denied || Permission.camera.notDetermined {
                    Permission.camera.request {
                        self.pickerController.sourceType = .camera
                        self.presentController.present(pickerController, animated: true)
                    }
                } else {
                    self.pickerController.sourceType = .camera
                    self.presentController.present(pickerController, animated: true)
                }
                break
            case .photoLibrary:
                if Permission.photoLibrary.denied || Permission.photoLibrary.notDetermined {
                    Permission.photoLibrary.request {
                        self.pickerController.sourceType = .photoLibrary
                        self.presentController.present(pickerController, animated: true)
                    }
                } else {
                    self.pickerController.sourceType = .photoLibrary
                    self.presentController.present(pickerController, animated: true)
                }
            default:
                break
            }
        }
    }
    
    public func present() {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
        self.sourceType.forEach({ type in
            switch type {
            case .camera:
                let action = setActionType(type: .camera , title: "ถ่ายภาพ")
                alertController.addAction(action)
                break
            case .photoLibrary:
                let action = setActionType(type: .photoLibrary , title: "เลือกจากอัลบั้ม")
                alertController.addAction(action)
                break
            case .savedPhotosAlbum:
                let action = setActionType(type: .savedPhotosAlbum , title: "Camera roll")
                alertController.addAction(action)
                break
            default:
                break
            }
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad, let view = presentController.view {
            alertController.popoverPresentationController?.sourceView = view
            alertController.popoverPresentationController?.sourceRect = view.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentController.present(alertController, animated: true)
    }
    
    private func setActionType(type: UIImagePickerController.SourceType, title: String) -> UIAlertAction {
        return self.action(for: type, title: title)
    }
    
    private func pickerController(_ controller: UIImagePickerController, image: UIImage? = nil, fileName: String? = nil, videoUrl: URL? = nil) {
        controller.dismiss(animated: true, completion: nil)
        
        if let image = image {
            if enableCropImage {
                fileNamePreCropImage = fileName
                let cropViewController = TOCropViewController(croppingStyle: .default, image: image)
                cropViewController.delegate = self
                
                switch self.ratioPickerImage {
                    
               
                case RatioPickerImage.SQUERE :
                    cropViewController.aspectRatioPreset = .presetSquare

                    break
                case RatioPickerImage.PROTATE :
                    cropViewController.aspectRatioPreset = .preset4x3

                    break
                case RatioPickerImage.NONE :
                    cropViewController.aspectRatioPreset = .presetOriginal

                    break
                    
                }
                
                cropViewController.aspectRatioLockEnabled = true
                cropViewController.aspectRatioLockDimensionSwapEnabled = true
                cropViewController.resetAspectRatioEnabled = false
                cropViewController.rotateButtonsHidden = true
                self.presentController.present(cropViewController, animated: true, completion: nil)
            } else {
                presentController.startLoding()
                self.delegate?.didSelectImage(image: image, fileName: fileName, imagePicker: self)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.presentController.stopLoding()
                }
            }
        }
        
        if let videoUrl = videoUrl {
            presentController.startLoding()
            self.getThumbnailImageFromVideoUrl(url: videoUrl) { (thumbNailImage) in
                self.delegate?.didSelectVideo(imageThumbnail: thumbNailImage, imagePicker: self, videoUrl: videoUrl)
                self.presentController.stopLoding()
            }
        }
    }
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbNailImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbNailImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
}

extension ImagePickerHelp: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var itemInfo: UIImagePickerController.InfoKey = .originalImage
        if !enableCropImage, picker.allowsEditing {
            itemInfo = .editedImage
        }
        
        guard let image = info[itemInfo] as? UIImage else {
            guard  let movieUrl = info[.mediaURL] as? URL else {
                return self.pickerController(picker)
            }
            return self.pickerController(picker, videoUrl: movieUrl)
        }
        var fileName: String? = nil
        if let infoURL = info[.imageURL] as? NSURL,
            let urlArray = infoURL.absoluteString?.components(separatedBy: "/"),
            let name = urlArray.last {
            fileName = name
        }
        
        if (picker.sourceType == UIImagePickerController.SourceType.camera){
            let imgName = UUID().uuidString
            let documentDirectory = NSTemporaryDirectory()
            let localPath = documentDirectory.appending(imgName)
            
            let data = image.jpegData(compressionQuality: 0.3)! as NSData
            data.write(toFile: localPath, atomically: true)
            let photoURL = URL.init(fileURLWithPath: localPath)
            self.pickerController(picker, image: image, fileName: imgName)

            
            
        }else {
            
            self.pickerController(picker, image: image, fileName: fileName)
        }
    }
}

extension ImagePickerHelp: UINavigationControllerDelegate {
    
}

extension ImagePickerHelp: TOCropViewControllerDelegate {
    public func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true)
        guard enableCropImage,
                let fileName = fileNamePreCropImage,
                !fileName.isEmpty else { return }
        presentController.startLoding()
        self.delegate?.didSelectImage(image: image, fileName: fileName, imagePicker: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.presentController.stopLoding()
        }
    }
}
