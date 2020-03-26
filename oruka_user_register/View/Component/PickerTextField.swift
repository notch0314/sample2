//
//  PickerTextField.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/04.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import UIKit

protocol PickerTextFieldDelegate: UITextFieldDelegate {
    func pickerTextField(_ textField: PickerTextField, didSelectPickerValue value: String)
}

@IBDesignable
final class PickerTextField: UITextField {
    
    var pickerContents: [String]! {
        didSet {
            pickerView?.reloadAllComponents()
        }
    }
    
    var pickerView: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerContents = [String]()
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let doneItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(doneButtonTapped(_:)))
        doneItem.tintColor = .black
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 40))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        toolbar.items = [spacer, doneItem]
        
        inputView = pickerView
        inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        resignFirstResponder()
    }
}

extension PickerTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerContents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerContents[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = pickerContents[row]
        (delegate as? PickerTextFieldDelegate)?.pickerTextField(self, didSelectPickerValue: pickerContents[row])
    }
}
