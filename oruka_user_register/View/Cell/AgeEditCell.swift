//
//  AgeEditCell.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/04.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import UIKit

protocol AgeEditCellDelegate: AnyObject {
    func ageEditCell(_ cell: AgeEditCell, didSelectAge age: String)
}

final class AgeEditCell: UITableViewCell {

    @IBOutlet weak var textField: PickerTextField!
    
    weak var delegate: AgeEditCellDelegate?
    
    lazy var currentValue: String? = textField.pickerContents.first
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
}

extension AgeEditCell: UITextFieldDelegate, PickerTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = currentValue
        if let text = textField.text {
            delegate?.ageEditCell(self, didSelectAge: text)
        }
    }
    
    func pickerTextField(_ textField: PickerTextField, didSelectPickerValue value: String) {
        delegate?.ageEditCell(self, didSelectAge: value)
    }
}
