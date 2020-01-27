//
//  UIViewControllerExtension.swift
//  Gitter
//
//  Created by Nazar Petruk on 27/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentSafariVCFor(url: String) {
        let readmeURL = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: readmeURL!)
        safariVC.preferredBarTintColor = #colorLiteral(red: 0.450481832, green: 0.3242934644, blue: 0.597058773, alpha: 0.9030314701)
        safariVC.preferredControlTintColor = #colorLiteral(red: 0.8526210189, green: 0.274410665, blue: 0, alpha: 0.9030314701)
        present(safariVC, animated:  true, completion: nil)
        
    }
}
