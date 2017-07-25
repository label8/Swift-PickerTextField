//
//  ViewController.swift
//  PickerViewSample
//
//  Created by Hachiya Tsunemasa on 2017/07/25.
//  Copyright © 2017年 Hachiya Tsunemasa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerTextField1: PickerTextField!
    @IBOutlet weak var pickerTextField2: PickerTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerTextField1.delegate = self
        pickerTextField2.delegate = self
        pickerTextField1.tag = 1
        pickerTextField2.tag = 2
        
        pickerTextField1.setup(dataList: ["Ei!", "Fire!", "Icestorm!", "Diacute!", "Braindumbed!", "Jugem!", "Bayoen!"])
        pickerTextField2.setup(dataList: [])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: UITextFieldDelegate {
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField.tag == 2 {
//            if !(pickerTextField1.text?.isEmpty)! {
//                pickerTextField2.setup(dataList: ["Japan", "America", "China", "Austraria", "Rusia", "Germany", "England"])
//            }
//        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            
            if !(pickerTextField1.text?.isEmpty)! {
                pickerTextField2.setup(dataList: ["Japan", "America", "China", "Austraria", "Rusia", "Germany", "England"])
            }
        }
 
    }
    
}

