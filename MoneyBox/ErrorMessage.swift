//
//  ErrorMessage.swift
//  MoneyBox
//
//  Created by Denis Hackett on 03/07/2023.
//

import UIKit

//custom error message class
class ErrorMessagePopup {
    static func show(withTitle title: String, message: String, inViewController viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // custom alert colour
        if let subview = alert.view.subviews.first?.subviews.first {
            subview.backgroundColor = UIColor(named: "GreyColor")
        }
        
        alert.view.tintColor = UIColor(named: "AccentColor")
        
        let okAction = UIAlertAction(title: "Okay", style: .default) { _ in
            completion?()
        }
        
        // okay button text colour
        okAction.setValue(UIColor(named: "AccentColor"), forKey: "titleTextColor")
        
        //add action button to message view
        alert.addAction(okAction)
        //add message repsonse to the view controller
        viewController.present(alert, animated: true, completion: nil)
    }
}


