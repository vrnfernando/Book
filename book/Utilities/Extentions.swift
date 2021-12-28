//
//  AlertDialog.swift
//  book
//
//  Created by Vishwa Fernando on 12/28/21.
//  Copyright © 2021 Soul. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
//Show a basic alert
func showAlert(alertText : String, alertMessage : String) {
    let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
//Add more actions as you see fit
self.present(alert, animated: true, completion: nil)
  }
}
