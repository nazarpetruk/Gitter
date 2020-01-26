//
//  FancyTextField.swift
//  Gitter
//
//  Created by Nazar Petruk on 24/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit

class FancyTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        let placeHolder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        attributedPlaceholder = placeHolder
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        layer.cornerRadius = frame.height / 2
        layer.borderColor = #colorLiteral(red: 0.431372549, green: 0.3294117647, blue: 0.5803921569, alpha: 1)
        layer.borderWidth = 3
        layer.masksToBounds = true
    }


}
