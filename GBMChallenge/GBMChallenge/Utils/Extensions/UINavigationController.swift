//
//  UINavigationController.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 17/07/21.
//

import Foundation
import UIKit
extension UINavigationController {
    override open func viewDidLoad() {
        self.navigationBar.barTintColor = UIColor(named: "GBMPrimaryColor")
        self.navigationBar.tintColor = UIColor(named: "GBMSecondaryColor")
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor(named: "GBMQuinary") ?? .white, NSAttributedString.Key.font: UIFont(name: "FontAwesome", size: 18)!]
    }
}
