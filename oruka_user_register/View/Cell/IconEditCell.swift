//
//  IconEditCell.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/02.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import UIKit

protocol IconEditCellDelegate: AnyObject {
    func iconEditCellDidIconButtonTapped(_ cell: IconEditCell)
}

final class IconEditCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: IconEditCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.addTarget(self, action: #selector(iconButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = button.bounds.size.width / 2
    }
    
    @objc private func iconButtonTapped(_ sender: UIButton) {
        delegate?.iconEditCellDidIconButtonTapped(self)
    }
    
    func setImage(_ image: UIImage) {
        button.setBackgroundImage(image, for: .normal)
    }
    
}
