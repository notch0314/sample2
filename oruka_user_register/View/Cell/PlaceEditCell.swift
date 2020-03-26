//
//  PlaceEditCell.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/04.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import UIKit

protocol PlaceEditCellDelegate: AnyObject {
    func placeEditCell(_ cell: PlaceEditCell, didSelectPlace place: String)
}

final class PlaceEditCell: UITableViewCell {

    @IBOutlet weak var textField: PickerTextField!
    lazy var currentValue: String? = textField.pickerContents.first
    
    weak var delegate: PlaceEditCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
}

extension PlaceEditCell: UITextFieldDelegate, PickerTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = currentValue
        if let text = textField.text {
            delegate?.placeEditCell(self, didSelectPlace: text)
        }
    }
    
    func pickerTextField(_ textField: PickerTextField, didSelectPickerValue value: String) {
        delegate?.placeEditCell(self, didSelectPlace: value)
    }
}
