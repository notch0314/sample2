//
//  NickNameEditCell.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/04.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import UIKit

protocol NickNameEditCellDelegate: AnyObject {
    func nickNameEditCell(_ cell: NickNameEditCell, nickNameDidEdiding text:String)
}

final class NickNameEditCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: NickNameEditCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
}

extension NickNameEditCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        delegate?.nickNameEditCell(self, nickNameDidEdiding: resultString)
        return resultString.count <= 15
    }
}
