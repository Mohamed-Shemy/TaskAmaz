//
//  UIViewController.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Thu 13 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

extension UIViewController
{
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil)
    {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                completion?()
            })
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
