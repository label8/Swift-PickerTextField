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
    
    var prefectures: Array<String> = []
    var cities: Array<String> = []
    
    var prefectureList: Array<Any> = []
    var cityList: Array<Any> = []
    
    var prefectureRow: Int = 0
    var cityRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerTextField1.delegate = self
        pickerTextField1.tag = 1
        pickerTextField1.text = "選択してください"
        
        pickerTextField2.delegate = self
        pickerTextField2.tag = 2
        
        setPrefectures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 登録ボタン
    @IBAction func regist(_ sender: Any) {
        if prefectureRow > 0 {
print(prefectureRow)
            print(prefectureList[prefectureRow])
        }

        if cityRow > 0 {
print(cityRow)
            print(cityList[cityRow])
        }
    }
}

extension ViewController: UITextFieldDelegate {
    // テキストフィールドをタップしたときに呼ばれる
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            pickerTextField1.setup(dataList: prefectures)
        } else {
            pickerTextField2.setup(dataList: cities)
        }
    }

    // テキストフィールドの入力が終わったら呼び出される（ピッカーのDoneが押されたら）
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            // 選択された都道府県コードをセット（都道府県は必須選択なので都道府県コード0はない）
            prefectureRow = pickerTextField1.selectedItemRow + 1
            // デフォルト表示
            pickerTextField2.text = "未選択"
            
            self.cities.removeAll()
            self.cityList.removeAll()
            self.cityRow = 0
            
            // 市町村のデータを配列にセットする
            setCities(prefCode: prefectureRow)
            // ピッカーの1行目を初期選択状態にする
            pickerTextField2.pickerView.selectRow(0, inComponent: 0, animated: true)

        } else {
            cityRow = pickerTextField2.selectedItemRow
        }
    }
    
}

extension ViewController {

    func setPrefectures() {
        let api = APIClient()
        let url = "https://opendata.resas-portal.go.jp/api/v1/prefectures"
        let addRequestValues = [
            ["value": "application/json", "forHTTPHeaderField": "Accept"],
            ["value": "f0daZW75eZa6nUzUPzujsK350mvVT54QBM5Euvie", "forHTTPHeaderField": "X-API-KEY"]
        ]
        api.get(urlString: url, addValues: addRequestValues, queryItems: nil) { (data) in
            if let jsonData = data as? Dictionary<String, Any> {
                let results = jsonData["result"]! as! NSArray
                for list in results {
                    let dic = list as! Dictionary<String, Any>
                    let prefCode = dic["prefCode"]! as! Int
                    let prefName = dic["prefName"]! as! String
                    
                    self.prefectures.append(prefName)
                    self.prefectureList.append(["prefCode": prefCode, "prefName": prefName])
                }

                self.prefectureList.insert([], at: 0)
            }
        }
    }
    
    func setCities(prefCode: Int) {
print(prefCode)
        let api = APIClient()
        let url = "https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=\(prefCode)"
        let addRequestValues = [
            ["value": "application/json", "forHTTPHeaderField": "Accept"],
            ["value": "f0daZW75eZa6nUzUPzujsK350mvVT54QBM5Euvie", "forHTTPHeaderField": "X-API-KEY"]
        ]
        api.get(urlString: url, addValues: addRequestValues, queryItems: nil) { (data) in
            if let jsonData = data as? Dictionary<String, Any> {
                self.cities.removeAll()
                self.cityList.removeAll()
                let results = jsonData["result"]! as! NSArray
                for list in results {
                    let dic = list as! Dictionary<String, Any>
                    let cityCode = dic["cityCode"]! as! String
                    let cityfName = dic["cityName"]! as! String
                    let prefCode = prefCode
                    
                    self.cities.append(cityfName)
                    self.cityList.append(["cityCode": cityCode, "cityName": cityfName, "prefCode": prefCode])
                }
                
                self.cities.insert("未選択", at: 0)
                self.cityList.insert([], at: 0)
            }
        }
    }

}

