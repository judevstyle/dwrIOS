//
//  Extensions.swift
//  EwsAppiOS
//
//  Created by Nontawat Kanboon on 9/10/2563 BE.
//  Copyright © 2563 ssoft. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended
import Toast_Swift
import GoogleMaps
extension UIView {
    
    func setAllRounded(rounded: CGFloat) {
//        print("ssize \(self.layer.frame.height)")
        self.layer.cornerRadius = rounded
    }
    
    
    func setAllRounded(rounded: CGFloat,text:String) {
//        self.layer.frame.height = 44
        self.layer.cornerRadius = rounded/2
        print("ssize \(text) --- \(self.layer.frame.height)")

    }
    
    func setRoundedCircle() {
        let width = self.frame.width/2
        self.layer.cornerRadius = width
    }
    
    func setShadowBoxView()  {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func roundedTop(radius: CGFloat){
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
     }
    
    func roundedBottom(radius: CGFloat){
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
     }
    
    func roundedLeft(radius: CGFloat){
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
     }
    
    func roundedRight(radius: CGFloat){
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topRight, .bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
     }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        
        _ = anchorPositionReturn(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
        
    }
    
    func anchorPositionReturn(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint]{
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
        
    }
    
    
    func updateConstraint(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) -> Void {
        
        
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            
            constraint.constant = constant
            
        }
    }
    
    
    func setConstraintConstant(constant: CGFloat,
                               forAttribute attribute: NSLayoutConstraint.Attribute) -> Bool
    {
        if let constraint = constraintForAttribute(attribute: attribute) {
            constraint.constant = constant
            
            //            UIView.animate(withDuration: 0.2) {
            //
            //            self.layoutIfNeeded()
            //
            //             }
            
            return true
        }
        else {
            superview?.addConstraint(NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1.0, constant: constant))
            return false
        }
    }
    
    func constraintConstantforAttribute(attribute: NSLayoutConstraint.Attribute) -> CGFloat?
    {
        if let constraint = constraintForAttribute(attribute: attribute) {
            return constraint.constant
        }
        else {
            return nil
        }
    }
    
    func constraintForAttribute(attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint?
    {
        return superview?.constraints.filter({
            $0.firstAttribute == attribute
        }).first
    }
    
    
    
    
    func setViewShadow() {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.2
    }
    
    
    func setViewShadowRadius(_ radius: CGFloat) {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.1
    }
    
    func dashedBorderLayerWithColor(color:CGColor) {
        let  borderLayer = CAShapeLayer()
        borderLayer.name  = "borderLayer"
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        borderLayer.bounds=shapeRect
        borderLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color
        borderLayer.lineWidth=1
        borderLayer.lineJoin = .round
        borderLayer.lineDashPattern = NSArray(array: [NSNumber(value: 8),NSNumber(value:4)]) as? [NSNumber]
        
        let path = UIBezierPath.init(roundedRect: shapeRect, cornerRadius: frameSize.width/2)
        
        borderLayer.path = path.cgPath
        
        self.layer.addSublayer(borderLayer)
    }
    
    
    func dashedShapeBorderLayerWithColor(color:CGColor) {
        let  borderLayer = CAShapeLayer()
        borderLayer.name  = "borderLayer"
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        borderLayer.bounds=shapeRect
        borderLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color
        borderLayer.lineWidth=1
        borderLayer.lineJoin = .round
        borderLayer.lineDashPattern = NSArray(array: [NSNumber(value: 8),NSNumber(value:4)]) as? [NSNumber]
        
        let path = UIBezierPath.init(roundedRect: shapeRect, cornerRadius: 3)
        
        borderLayer.path = path.cgPath
        
        self.layer.addSublayer(borderLayer)
    }
    
    func roundCorners(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    
    func roundedTopLeft(cornerRadius: Double){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func roundedTopRight(cornerRadius: Double){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedBottomLeft(cornerRadius: Double){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomLeft],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedBottomRight(cornerRadius: Double){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomRight],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedBottom(cornerRadius: Double){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomRight , .bottomLeft],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedTop(cornerRadius: Double){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .topLeft],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedLeft(cornerRadius: Double){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedRight(cornerRadius: Double){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .bottomRight],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedAllCorner(cornerRadius: Double){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .bottomRight , .topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func addBottomRoundedEdge(desiredCurve: CGFloat?) {
        let offset: CGFloat = self.frame.width / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        self.layer.mask = maskLayer
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
}


extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
    
    
    func addCharactersSpacing(spacing: CGFloat, txt: String) {
        let attributedString = NSMutableAttributedString(string: txt)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: txt.count))
        self.attributedText = attributedString
    }
}

extension UITableViewCell {
    
    func withTextParagraph(text: String,fonSize: Int) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.maximumLineHeight = 17.0
        
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        attributedString.addAttribute(
            .font,
            value: UIFont.PrimaryLight(size: CGFloat(fonSize)),
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        return attributedString
    }
    
    
    //    func ParagraphDashboardMap(title: String, value: String) -> NSAttributedString {
    //
    //             let attributedString = NSMutableAttributedString(a)
    //
    //                  let paragraphStyle = NSMutableParagraphStyle()
    //
    //                  paragraphStyle.maximumLineHeight = 17.0
    //
    //
    //                  attributedString.addAttribute(
    //                      .paragraphStyle,
    //                      value: paragraphStyle,
    //                      range: NSRange(location: 0, length: attributedString.length
    //                  ))
    //
    //                  attributedString.addAttribute(
    //                      .font,
    //                      value: UIFont.PrimaryLight(size: 15),
    //                      range: NSRange(location: 0, length: attributedString.length
    //                  ))
    //
    //             return attributedString
    //         }
    
}


extension UIColor {
    
    static func whiteAlpha(alpha: CGFloat) -> UIColor {
        return UIColor(white: 1, alpha: alpha)
    }
    
    static func blackAlpha(alpha: CGFloat) -> UIColor {
        return UIColor(white: 0, alpha: alpha)
    }
    
    static func AppPrimary() -> UIColor {
        return UIColor(named: "AppPrimary")!
    }
    
    static func AppAccent() -> UIColor {
        return UIColor(named: "AppAccent")!
    }
    
    static func AppPrimaryDark() -> UIColor {
        return UIColor(named: "AppPrimaryDark")!
    }
    
    
    
    static func AppPrimaryDarkGray() -> UIColor {
        return UIColor(named: "AppPrimaryDarkGray")!
    }
    
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static var jetBlack = UIColor.rgb(red: 33, green: 45, blue: 79)
    static var gold = UIColor.rgb(red: 255, green: 182, blue: 0)
    static var kelly = UIColor.rgb(red: 0, green: 206, blue: 62)
    static var mediumBlue = UIColor.rgb(red: 0, green: 122, blue: 255)
    static var rosePink = UIColor.rgb(red: 255, green: 193, blue: 224)
    static var navy = UIColor.rgb(red: 66, green: 66, blue: 136)
    static var emerald = UIColor.rgb(red: 0, green: 222, blue: 182)
    static var lolipop = UIColor.rgb(red: 143, green: 20, blue: 108)
    static var ruby = UIColor.rgb(red: 235, green: 42, blue: 117)
    
    static var Color333333 = UIColor(named: "#333333")!
    static var PrimaryRed = UIColor(named: "PrimaryRed")!
    static var CED4D9 = UIColor(named: "#CED4D9")!
    static var bgTrans = UIColor(named: "bgTrans")!

    
    
    
    
    
}

extension UIFont {
    
    static func PrimaryBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Kanit-Bold", size: size)!
    }
    
    static func PrimaryMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Kanit-Medium", size: size)!
    }
    
    
    static func PrimaryRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Kanit-Regular", size: size)!
    }
    
    static func PrimaryLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Kanit-Light", size: size)!
    }
    
}

extension UIViewController: NVActivityIndicatorViewable {
    
    func ToastAlert(text: String, duration: Double) {
        self.view.makeToast("\(text)", duration: duration, position: .bottom)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.view.hideToast()
        }
    }
    
    func convertRectOfInterest(rect: CGRect) -> CGRect {
        let screenRect = self.view.frame
        let screenWidth = screenRect.width
        let screenHeight = screenRect.height
        let newX = 1 / (screenWidth / rect.minX)
        let newY = 1 / (screenHeight / rect.minY)
        let newWidth = 1 / (screenWidth / rect.width)
        let newHeight = 1 / (screenHeight / rect.height)
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 7, y: 7)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    func setTitleNavigation(title: String)  {
        
        self.navigationItem.title = "\(title)"
    }
    
    func setBarTintColorNavigation(color: UIColor)  {
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    func setisTranslucentNavigationBar(status: Bool)  {
        self.navigationController?.navigationBar.isTranslucent = status
    }
    
    
    func setBarStyleNavigation(style: UIBarStyle)  {
        self.navigationController?.navigationBar.barStyle = style
    }
    
    func setHideBorderNavigation(status: Bool)  {
        
        if status == true {
            
            self.navigationController?.navigationBar.barTintColor = .AppPrimary()
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.layoutIfNeeded()
            
        }else {
            
            self.navigationController?.navigationBar.barTintColor = .AppPrimary()
            self.navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.layoutIfNeeded()
            
        }
        
    }
    
    
    func setHideBackNavigation(color: UIColor)  {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = color
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    func startLoding() {
        let size = CGSize(width: 70.0, height: 70.0)
        startAnimating(size, message: "", messageFont: .PrimaryRegular(size: 17), type: .ballScaleMultiple,color: .whiteAlpha(alpha: 0.7), backgroundColor: .blackAlpha(alpha: 0.3), textColor: .white, fadeInAnimation: nil)
    }
    
    func stopLoding() {
        stopAnimating()
    }
    
    
    func startLodingCircle() {
        let size = CGSize(width: 35.0, height: 35.0)
        startAnimating(size, message: "", messageFont: .PrimaryRegular(size: 17), type: .circleStrokeSpin,color: .whiteAlpha(alpha: 0.7), backgroundColor: .blackAlpha(alpha: 0.3), textColor: .white, fadeInAnimation: nil)
    }
    
    func errorDialog(title: String, message: String) {
        let dialogMessage = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default,  handler: { (action) -> Void in
            
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    func ToastMsg(msg:String) {
        self.view.makeToast("\(msg)", duration: 1.5, position: .bottom)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

extension UIScrollView {
    
    func addScrollWhenKeyboardShow() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.convert(keyboardFrame, from: nil)
        
        
        let content:UIEdgeInsets = UIEdgeInsets.zero
        self.contentInset = content
        
        var contentInset:UIEdgeInsets = self.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.contentInset = contentInset
    }
    
}

extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}

import Foundation

extension String {
    
    
    func DateThFormateReport() -> String {
        
        let dateAndtime = self.components(separatedBy: " ")
        let date = dateAndtime[0].components(separatedBy: "-")
        let time = dateAndtime[1].components(separatedBy: ":")
        
    
        let dayTH = date[2]
        
        var mountTH = "มกราคม"
        
        switch Int(date[1]) {
        case 1:
            mountTH = "มกราคม"
            break
        case 2:
            mountTH = "กุมภาพันธ์"
            break
        case 3:
            mountTH = "มีนาคม"
            break
        case 4:
            mountTH = "เมษายน"
            break
        case 5:
            mountTH = "พฤษภาคม"
            break
        case 6:
            mountTH = "มิถุนายน"
            break
        case 7:
            mountTH = "กรกฎาคม"
            break
        case 8:
            mountTH = "สิงหาคม"
            break
        case 9:
            mountTH = "กันยายน"
            break
        case 10:
            mountTH = "ตุลาคม"
            break
        case 11:
            mountTH = "พฤศจิกายน"
            break
        case 12:
            mountTH = "ธันวาคม"
            break
        default:
            mountTH = "มกราคม"
        }
        
        let yearTH = "\(Int(date[0])! + 543)"
        
        //    "วันที่ 22 เดือน ตุลาคม พ.ศ. 2563 เวลา 19.57.00"
        let fullDate = "วันที่ \(dayTH) เดือน \(mountTH) พ.ศ. \(yearTH) เวลา \(time[0]).\(time[1]).\(time[2])"
        
        return fullDate
    }
    
    func isBase64() -> Bool {
        guard Data(base64Encoded: self) != nil else {
            return false
        }
        return true
    }
    
    
    func subStringReport() -> [String]{
        
        let text = self.components(separatedBy: "สถานี")
        
        let title    = text[0]
        let address = text[1]
        
        return [title,address]
    }
    
    func subStringReportStatus() -> String{
        
        let text = self.components(separatedBy: " ")
        
        let status    = text[1]
        
        return status
    }
    
    func toBase64() -> String {
        if let data = (self).data(using: String.Encoding.utf8) {
            let base64 = data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            return base64
        }else {
            return ""
        }
    }
    
    func convertBase64StringToImage () -> UIImage {
        let imageData = Data.init(base64Encoded: self, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
}

extension Date {
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}

extension UITextField {
    
    
    
    func setInputViewDatePicker(target: Any, selector: Selector,setDate: Date) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        datePicker.locale = Locale(identifier: "th")
        datePicker.setDate(setDate, animated: false)
        self.inputView = datePicker //3
        
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    func setInputViewTimePicker(target: Any, selector: Selector,setDate: Date) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = UIDatePicker.Mode.time
        datePicker.locale = Locale(identifier: "da_DK")
        datePicker.setDate(setDate, animated: false)
        self.inputView = datePicker //3
        
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    
    func setIconSearchBar() {
        self.setViewShadowRadius(self.frame.height/2)
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.placeholder = "ค้นหา..."
        self.font = UIFont.PrimaryRegular(size: 15)
        
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 10, width: self.frame.height-20, height:  self.frame.height-20))
        iconView.image = UIImage(named: "search")
        iconView.tintColor = UIColor.AppPrimary()
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 45, height: self.frame.height))
        iconContainerView.addSubview(iconView)
        self.leftView = iconContainerView
        self.leftViewMode = .always
    }
    
    
    func setPaddingLeft(padding: CGFloat){
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 5))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    
    func setPaddingRight(padding: CGFloat){
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 5))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setTextFieldBottom() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
    
    func addArrowIconDropdown()  {
        
        let iconArrow = UIImageView()
        iconArrow.image = UIImage(named: "down-arrow")?.withRenderingMode(.alwaysTemplate)
        iconArrow.tintColor = .gray
        
        setPaddingLeft(padding: 8)
        setPaddingRight(padding: 8)
        
        self.addSubview(iconArrow)
        
        iconArrow.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 14, leftConstant: 0, bottomConstant: 14, rightConstant: 8, widthConstant: 13, heightConstant: 0)
    }
    
    
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}



extension UIButton {
    
    func addIconSocial(image: UIImage)  {
        
        let icon = UIImageView()
        icon.image = image.withRenderingMode(.alwaysOriginal)
        icon.contentMode = .scaleAspectFit
        
        self.addSubview(icon)
        
        icon.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 10, leftConstant: 16, bottomConstant: 10, rightConstant: 0, widthConstant: 25, heightConstant: 0)
    }
}

extension UIScrollView {
    
    func setScrollViewContentSize() {
        
        var height: CGFloat
        let lastView = subviews[0].subviews.last!
        
        let lastViewYPos = lastView.convert(lastView.frame.origin, to: nil).y  // this is absolute positioning, not relative
        let lastViewHeight = lastView.frame.size.height
        height = lastViewYPos + lastViewHeight
        contentSize.height = height
    }
}



extension UIApplication {
    
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 5111
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag
                
                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
        
    }
    
}

extension UIImage {
    func convertImageToBase64String () -> String {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
}

var activityView: NVActivityIndicatorView!

extension UIImageView {
    
    
    func setTopCornerRadius(cornerRadius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        self.layer.masksToBounds = true
    }
    
    func showLoadingIndicator(){
        if activityView == nil{
            activityView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.whiteAlpha(alpha: 1.0), padding: 20)
            // add subview
            self.addSubview(activityView)
            // autoresizing mask
            activityView.translatesAutoresizingMaskIntoConstraints = false
            // constraints
            self.addConstraint(NSLayoutConstraint(item: activityView!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: activityView!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
        }
        
        activityView.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityView.stopAnimating()
    }
    
}

extension NSLayoutXAxisAnchor {
    func constraint(between anchor1: NSLayoutXAxisAnchor, and anchor2: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        let anchor1Constraint = anchor1.anchorWithOffset(to: self)
        let anchor2Constraint = anchorWithOffset(to: anchor2)
        return anchor1Constraint.constraint(equalTo: anchor2Constraint)
    }
}

extension NSLayoutYAxisAnchor {
    func constraint(between anchor1: NSLayoutYAxisAnchor, and anchor2: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        let anchor1Constraint = anchor1.anchorWithOffset(to: self)
        let anchor2Constraint = anchorWithOffset(to: anchor2)
        return anchor1Constraint.constraint(equalTo: anchor2Constraint)
    }
}

extension UIAlertAction {
    static var propertyNames: [String] {
        var outCount: UInt32 = 0
        guard let ivars = class_copyIvarList(self, &outCount) else {
            return []
        }
        var result = [String]()
        let count = Int(outCount)
        for i in 0..<count {
            let pro: Ivar = ivars[i]
            guard let ivarName = ivar_getName(pro) else {
                continue
            }
            guard let name = String(utf8String: ivarName) else {
                continue
            }
            result.append(name)
        }
        return result
    }
}

public extension Optional {
    
    var isNil: Bool {
        
        guard case Optional.none = self else {
            return false
        }
        
        return true
        
    }
    
    var isSome: Bool {
        
        return !self.isNil
        
    }
    
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


extension UISearchBar {
    
    func clearBackgroundColor() {
        guard let UISearchBarBackground: AnyClass = NSClassFromString("UISearchBarBackground") else { return }
        
        for view in subviews {
            for subview in view.subviews where subview.isKind(of: UISearchBarBackground) {
                subview.alpha = 0
            }
        }
    }
    
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
}


extension Notification.Name {
    static let didLoadStationsSuccess = Notification.Name("didLoadStationsSuccess")
//    static let didCompleteTask = Notification.Name("didCompleteTask")
//    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}

extension String {
    func trim() -> String {
    return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
   }
}


extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
