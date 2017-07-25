//
//  PickerTextField.swift
//  PickerViewSample
//
//  Created by Hachiya Tsunemasa on 2017/07/25.
//  Copyright © 2017年 Hachiya Tsunemasa. All rights reserved.
//

import UIKit

class PickerTextField: UITextField {

    var dataList: Array = Array<String>()
//    var dataList: Array = Array<Any>()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(dataList: [String]) {
//    func setup(dataList: Array<Any>) {
        self.dataList = dataList
        
        let pickerView: UIPickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 44))
        let doneItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickerTextField.done))
        let cancelItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(PickerTextField.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.inputView = pickerView
        self.inputAccessoryView = toolbar
    }
    
    func cancel() {
        self.text = ""
        self.endEditing(true)
    }

    func done() {
        self.endEditing(true)
    }

    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    // 範囲選択カーソル非表示
    override func selectionRects(for range: UITextRange) -> [Any] {
        return []
    }
    
    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
}

extension PickerTextField: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
}

extension PickerTextField: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if let list = dataList[row] as? Dictionary<String, Any> {
//            if let data = list["prefecture"] {
//               return data as? String
//            }
//        }
//
//        return ""
        
        return dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if let list = dataList[row] as? Dictionary<String, Any> {
//            if let data = list["prefecture"] {
//                self.text = data as? String
//            }
//        }
        
        self.text = dataList[row]
    }

}

