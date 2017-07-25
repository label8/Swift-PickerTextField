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
        
        let data1 = [
            "response": [
                ["prefecture": "東京都"],
                ["prefecture": "神奈川県"],
                ["prefecture": "千葉県"],
                ["prefecture": "埼玉県"],
                ["prefecture": "茨城県"],
                ["prefecture": "群馬県"],
                ["prefecture": "栃木県"]
            ]
//            ["id": 1, "prefecture": "東京都"],
//            ["id": 2, "prefecture": "神奈川県"],
//            ["id": 3, "prefecture": "千葉県"],
//            ["id": 4, "prefecture": "埼玉県"],
//            ["id": 5, "prefecture": "茨城県"],
//            ["id": 6, "prefecture": "群馬県"],
//            ["id": 7, "prefecture": "栃木県"]
        ]
        
        var prefectures: Array = Array<String>()
        
        if let res = data1["response"] {
            for list in res {
                prefectures.append(list["prefecture"]!)
            }
        }
        
        let areas = [] as Array
        
        pickerTextField1.setup(dataList: prefectures)
        pickerTextField2.setup(dataList: areas as! [String])
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

