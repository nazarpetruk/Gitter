//
//  RoundedButton.swift
//  Gitter
//
//  Created by Nazar Petruk on 24/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }

}
