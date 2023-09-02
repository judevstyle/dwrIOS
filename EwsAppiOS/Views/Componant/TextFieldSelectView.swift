//
//  TextFieldSelectView.swift
//  EwsAppiOS
//
//  Created by Ssoft_dev on 9/2/23.
//  Copyright © 2023 ssoft. All rights reserved.
//

import Foundation
import UIKit


protocol TextFieldSelectViewDelegate: AnyObject {
    func didSelectItem(_ item: SelectionModel?, view: TextFieldSelectView)
}

class TextFieldSelectView: UIView {
    
    private let stackViewInput: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.backgroundColor = .clear
        return view
    }()
    
    let inputText: UITextField = {
        let view = UITextField()
        view.borderStyle = .none
//        view.font = .smallText
        view.textColor = .white
        view.backgroundColor = .clear
        return view
    }()
    
    let iconArrowBottom: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_expand_down_light")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .PrimaryRed
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let headInputLabel: UILabel = {
        let view = UILabel()
        view.textColor = .Color333333
//        view.font = .extraSmallText
        return view
    }()
    
    
    let pickerView = ToolbarPickerView()
    var listSelect: [SelectionModel] = []
    public var selectedItem : SelectionModel?
    weak var delegate: TextFieldSelectViewDelegate?
    
    private var isSetupUI: Bool = false
    private var headerText: String? = nil
    private var isEnable: Bool = true
    
    init(frame: CGRect = .zero, headerText: String? = nil, placeholder: String, listSelect: [SelectionModel], delegate: TextFieldSelectViewDelegate? = nil) {
        super.init(frame: frame)
        self.inputText.placeholder = placeholder
        self.listSelect = listSelect
        self.delegate = delegate
        self.headerText = headerText
        
        self.listSelect.insert(.init(id: -1, name: ""), at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    public func setupUI() {
        guard !isSetupUI else { return }
        backgroundColor = .clear
        
        self.addSubview(stackViewInput)
        stackViewInput.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        stackViewInput.addArrangedSubview(headInputLabel)
        stackViewInput.addArrangedSubview(inputText)
        inputText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        if let headerText = self.headerText {
            headInputLabel.text = headerText
            headInputLabel.isHidden = false
        } else {
            headInputLabel.isHidden = true
        }
        
        inputText.addSubview(iconArrowBottom)
        iconArrowBottom.isUserInteractionEnabled = true
        iconArrowBottom.anchor(inputText.topAnchor, left: nil, bottom: inputText.bottomAnchor, right: inputText.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        let tapArrow = UITapGestureRecognizer(target: self, action: #selector(self.handleTapArrow))
        iconArrowBottom.addGestureRecognizer(tapArrow)
        inputText.isUserInteractionEnabled = true
        
        inputText.setAllRounded(rounded: 8)
        inputText.setBorder(width: 1.0, color: .white)
        inputText.setPaddingLeft(padding: 16)
        inputText.setPaddingRight(padding: 30)
    
        inputText.inputView = pickerView
        inputText.inputAccessoryView = pickerView.toolbar
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.toolbarDelegate = self

        isSetupUI = true
        
        selecedDefaultItem()
    }
    
    public func setupValue(listSelect: [SelectionModel], selectedId: Int = -1, isEnableEmpty: Bool = true) {
        self.listSelect = listSelect
        if isEnableEmpty {
            self.listSelect.insert(.init(id: -1, name: ""), at: 0)
        }
        pickerView.reloadAllComponents()
        selecedDefaultItem(selectedId)
    }
    
    public func selecedDefaultItem(_ selectedId: Int = -1) {
        listSelect.enumerated().forEach({ index, item in
            
            print("enumerated \(selectedId == item.id)")
            
            if selectedId == item.id {
                self.selectedItem = listSelect[index]
                self.inputText.text = self.selectedItem?.name ?? ""
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
        })
    }
    
    @objc func handleTapArrow() {
        inputText.becomeFirstResponder()
    }
    
    func isEnable(_ enable: Bool) {
        self.isEnable = enable
        inputText.isEnabled = enable
        inputText.backgroundColor = .white
        inputText.tintColor = enable ? .Color333333 : .CED4D9
        inputText.textColor = enable ? .white : .white
        iconArrowBottom.tintColor = enable ? .PrimaryRed : .CED4D9
    }

}

extension TextFieldSelectView {
    
    func setBorder(validate: Bool) {
        if validate {
            inputText.setBorder(width: 1.0, color: .CED4D9)
        } else {
            inputText.setBorder(width: 1.0, color: .PrimaryRed)
        }
    }
}

extension TextFieldSelectView : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}

extension TextFieldSelectView: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        self.inputText.text = self.selectedItem?.name ?? ""
        delegate?.didSelectItem(self.selectedItem, view: self)
        self.endEditing(true)
    }
    
    func didTapCancel() {
        self.endEditing(true)
    }
}

extension TextFieldSelectView : UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listSelect.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listSelect[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedItem = self.listSelect[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
//            pickerLabel?.font = UIFont.bodyText
            pickerLabel?.textAlignment = .center
        }
        
        if self.listSelect[row].id == -1 {
            pickerLabel?.text = "ไม่ระบุ"
        } else {
            pickerLabel?.text = self.listSelect[row].name
        }
        return pickerLabel!
    }
}
