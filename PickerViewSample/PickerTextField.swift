//
//  PickerTextField.swift
//  PickerViewSample
//
//  Created by Hachiya Tsunemasa on 2017/07/25.
//  Copyright © 2017年 Hachiya Tsunemasa. All rights reserved.
//

import UIKit

class PickerTextField: UITextField {

    // UIPickerViewのインスタンス生成
    let pickerView: UIPickerView = UIPickerView()

    // 表示データの初期化
    var dataList: Array = Array<String>() {
        // データがセットされたら
        didSet {
            // PickerViewを更新
            pickerView.reloadAllComponents()
        }
    }
    
    // 選択された項目番号を保持する変数の初期化
    var selectedItemRow: Int = 0
    
    // イニシャライザ
    init() {
        super.init(frame: CGRect.zero)
    }
    
    // イニシャライザ（コードから）
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // イニシャライザ（Storyboardから）
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // UIPickerViewとUITextFiledの結合設定
    func setup(dataList: [String]) {

        // 表示データのセット
        self.dataList = dataList
        
        // デリゲート
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        // UIPickerViewへのツールバー設定
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 44))
        let doneItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickerTextField.done))
//        let cancelItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(PickerTextField.cancel))
//        toolbar.setItems([cancelItem, doneItem], animated: true)
        toolbar.setItems([doneItem], animated: true)
        
        self.inputView = pickerView
        self.inputAccessoryView = toolbar
    }
    
//    func cancel() {
//        self.text = ""
//        self.endEditing(true)
//    }

    // 決定ボタンタップでUIPickerViewと閉じる
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
        return dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItemRow = row
        self.text = dataList[row]
    }

}

