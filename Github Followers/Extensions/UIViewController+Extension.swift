//
//  UIViewController+Extension.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 07/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentGFAlertViewController(title: String, message: String, textButton: String) {
        DispatchQueue.main.async {
            let alertViewController = AlertViewController(title: title, message: message, textButton: textButton)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
}
