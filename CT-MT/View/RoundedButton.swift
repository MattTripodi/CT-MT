//
//  RoundedButton.swift
//  CT-MT
//
//  Created by Matthew Tripodi on 8/12/22.
//

import UIKit

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.2117647059, blue: 0.2078431373, alpha: 1)
    }
    
}
