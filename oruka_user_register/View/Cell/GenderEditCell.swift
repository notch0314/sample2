//
//  GenderEditCell.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/04.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import UIKit

protocol GenderEditCellDelegate: AnyObject {
    func genderEditCell(_ cell: GenderEditCell, didSelectGenderButton tag: Int)
}

final class GenderEditCell: UITableViewCell {

    @IBOutlet weak var notsetGenderButton: UIButton!
    @IBOutlet weak var womanGenderButton: UIButton!
    @IBOutlet weak var manGenderButton: UIButton!
    
    weak var delegate: GenderEditCellDelegate?
    
    private var buttons: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttons = [UIButton]()
        buttons.append(notsetGenderButton)
        buttons.append(womanGenderButton)
        buttons.append(manGenderButton)
        
        for i in buttons {
            i.layer.cornerRadius = i.bounds.size.width / 2
            i.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        }
        
    }
    
    @objc private func genderButtonTapped(_ sender: UIButton) {
        for i in buttons {
            i.isSelected = false
            i.layer.borderWidth = 0
            i.layer.borderColor = UIColor.clear.cgColor
        }
        sender.isSelected = true
        sender.layer.borderWidth = 1.5
        sender.layer.borderColor = UIColor(named: "gender_border")?.cgColor
        delegate?.genderEditCell(self, didSelectGenderButton: sender.tag)
    }
    
}
