//
//  TabBarVC.swift
//  Gitter
//
//  Created by Nazar Petruk on 26/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = UIColor.black
        tabBar.tintColor = UIColor.white
        tabBar.isTranslucent = false        
    }
}
