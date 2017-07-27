//
//  ViewControllerAlert.swift
//  PickerViewSample
//
//  Created by Hachiya Tsunemasa on 2017/07/27.
//  Copyright © 2017年 Hachiya Tsunemasa. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertDialog(title: String, message: String, buttonTitle: String, okFunc: @escaping () -> ()) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default) { action in
            okFunc()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
