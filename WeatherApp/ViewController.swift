//
//  ViewController.swift
//  WeatherApp
//
//  Created by 平澤 剛 on 2016/11/13.
//  Copyright © 2016年 平澤 剛. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage



class ViewController: UIViewController {
    
    
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var dayTitles: [UILabel]!
    @IBOutlet var dayImages: [UIImageView]!
    @IBOutlet var weatherLabels: [UILabel]!
    @IBOutlet var temperatureLabels: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request("http://weather.livedoor.com/forecast/webservice/json/v1?city=030010").responseJSON { (response: DataResponse<Any>) in
            
            print(response)
            
            if response.result.isFailure == true {
                self.simpleAlert( message: "通信に失敗しました")
                return
            }
            
            // "guard let 変数 〜 else" で変数の中身がnilの場合のみの処理が書けます。
            // ただし最後に必ずreturnで関数を終了させなければいけません。
            // 変数は以後の関数内でも利用できます。
            guard let val = response.result.value as? [String: Any] else {
                self.simpleAlert( message: "通信結果がJSONではありませんでした")
                return
            }
            
            // responseJSONを使うと辞書形式でも扱えますが、今回はより簡単に扱うためにSwiftyJSONを利用します。
            let json = JSON(val)
            
            // タイトル部分
            if let title = json["title"].string {
                self.titleLabel.text = title
            }
            
            // 天気の情報
            if let forecasts = json["forecasts"].array {
                
                if let forecasts = json["forecasts"].array {
                    for num in 0...2{
                        // 今日の天気
                       
                    }
                }
            }
        }
    }
    
    func demo(_ int i) {
        
        if forecasts.coun >= 2 {
            var dayTitle = forecasts[i]
            
            self.dayTitles[i].text = dayTitle["dateLabel"].stringValue
            
            if let imgUrl = dayTitle["image"]["url"].string {
                self.dayImages[i].sd_setImage(with: URL(string: imgUrl))
            }
            
            self.weatherLabels[i].text = dayTitle["telop"].stringValue
            
            self.temperatureLabels[i].text = self.generateTemperatureText(dayTitle["temperature"])
        }
    }
    
    
    // 気温のラベル用テキストを生成します。
    func generateTemperatureText(_ temperature: JSON) -> String {
        
        var resultText = ""
        
        if let min = temperature["min"]["celsius"].string {
            resultText += min + "℃"
        } else {
            resultText += "-"
        }
        
        resultText += " / "
        
        if let max = temperature["max"]["celsius"].string {
            resultText += max + "℃"
        } else {
            resultText += "-"
        }
        return resultText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 閉じるボタンのみのアラートを表示します。
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
