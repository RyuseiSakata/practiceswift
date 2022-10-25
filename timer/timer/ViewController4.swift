//
//  ViewController4.swift
//  Charts
//
//  Created by 阪田竜生 on 2022/10/18.
//

import UIKit
import Charts

class ViewController4: UIViewController {

    //@IBOutlet weak var barChart: BarChartView!
   
    struct BarChartModel {
        let value: Int
        let name: String
    }
    
    
    
    @IBOutlet weak var barChart: BarChartView!
    
    var roudoujikann: [Double] = []
    var hozonnnitiji: [String] = []
    var sumtime:[String] = []
    var sumtime2:Int = 0
    //var date: [[String]] = []
    
    var chartView: LineChartView!
    var chartDataSet: LineChartDataSet!
        // 今回使用するサンプルデータ
    let sampleData = [0, 99, 93, 67, 45, 72, 58]
        
       
    override func viewDidLoad() {
            super.viewDidLoad()
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        let loadedMemoList3  = defaults.object(forKey: "roudoujikann")
        if (loadedMemoList3 as? [Double] != nil) {
            roudoujikann = loadedMemoList3 as! [Double]
            }
        
        
        let loadedMemoList4  = defaults2.object(forKey: "hozonnnitiji")
        if (loadedMemoList4 as? [String] != nil) {
            hozonnnitiji = loadedMemoList4 as! [String]
            }
        
        let loadedMemoList6  = defaults2.object(forKey: "TUKIGOTONOROUDOUJIKANN")
        if (loadedMemoList6 as? [String] != nil) {
            sumtime = loadedMemoList6 as! [String]
            }
        
        let today = Date()
        let dateFormatter = DateFormatter()
        let dateFormatter2 = DateFormatter()
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "d", options: 0, locale: Locale(identifier: "ja_JP"))
        dateFormatter2.dateFormat = DateFormatter.dateFormat(fromTemplate: "ym", options: 0, locale: Locale(identifier: "ja_JP"))
        //print(dateFormatter.string(from:today))
        
        if dateFormatter.string(from:today) == "25日"{
            print("月初だよ〜")
            let defaults3 = UserDefaults.standard
            let loadedMemoList5  = defaults3.object(forKey: "TUKIJIKANN")
            if (loadedMemoList5 as? Int != nil) {
                sumtime2 = loadedMemoList5 as! Int
            }
            
            sumtime.append(dateFormatter2.string(from: today)+"　"+String((sumtime2/3600)%60)+"時間"+String((sumtime2/60)%60)+"分働きました")
            print(dateFormatter2.string(from: today)+"　"+String((sumtime2/3600)%60)+"時間"+String((sumtime2/60)%60)+"分働きました")
            
            let defaults5 = UserDefaults.standard
            defaults5.set(sumtime, forKey: "TUKIGOTONOROUDOUJIKANN")
        }
        
        
            
        
            getChart()
            print(hozonnnitiji)
        
        }
    
    
    
    func getChart(){
            //適当に数字を入れた配列を作成しておく
            var labels:[String] = ["1","2","3","4","5","6","7"]
            
            //X軸のラベルに使うデータを作成する 少し面倒だけど日付にしてみる
            //日本時間を表示する準備・・・
            let formatterJP = DateFormatter()
            formatterJP.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMEE", options: 0, locale: Locale(identifier: "ja_JP"))
            formatterJP.timeZone = TimeZone(identifier:  "Asia/Tokyo")
           
            var num = 0
        if hozonnnitiji.count > 7{
            hozonnnitiji.removeFirst()
            roudoujikann.removeFirst()
            let defaults3 = UserDefaults.standard
            let defaults2 = UserDefaults.standard
            defaults2.set(roudoujikann, forKey: "roudoujikann")
            defaults3.set(hozonnnitiji, forKey: "hozonnnitiji")
            print("消した")
        }
        while num < hozonnnitiji.count{
            labels[num] = hozonnnitiji[num]
            num = num + 1
        }
           // labels = hozonnnitiji
            
            //適当に、棒グラフに使う数字をInt型配列で作成
           // print(roudoujikann[0])
            let rawData: [Double] = roudoujikann
            let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
            let dataSet = BarChartDataSet(entries: entries)
            let data = BarChartData(dataSet: dataSet)
            barChart.data = data
            
            //ラベルに表示するデータを指定　上で作成した「labels」を指定
            barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
            barChart.xAxis.granularity = 1
            // ラベルの数を設定
            barChart.xAxis.labelCount = 7
            // X軸のラベルの位置を下に設定
            barChart.xAxis.labelPosition = .bottom
            // X軸のラベルの色,文字サイズを設定
            barChart.xAxis.labelTextColor = .gray
            barChart.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 8.0)!
            // X軸の線、グリッドを非表示にする
            barChart.xAxis.drawGridLinesEnabled = false
            barChart.xAxis.drawAxisLineEnabled = false
            // 右側のY座標軸は非表示にする
            barChart.rightAxis.enabled = false
            // Y座標の値が0始まりになるように設定
            barChart.leftAxis.axisMinimum = 0 //y左軸最小値
            barChart.leftAxis.axisMaximum = 10 //y左軸最大値
            barChart.leftAxis.drawZeroLineEnabled = true
            barChart.leftAxis.zeroLineColor = .gray
            // ラベルの数を設定
            barChart.leftAxis.labelCount = 10
            // ラベルの色を設定
            barChart.leftAxis.labelTextColor = .gray
            // グリッドの色を設定
            barChart.leftAxis.gridColor = .gray
            // 軸線は非表示にする
            barChart.leftAxis.drawAxisLineEnabled = false
            //凡例削除
            barChart.legend.enabled = false
            //色の指定　数値の表示非表示
            dataSet.drawValuesEnabled = false
            //dataSet.colors = [.gray]
            dataSet.colors = [UIColor.systemGreen, .systemPink, UIColor.systemGreen, UIColor.systemGreen, UIColor.systemGreen, UIColor.systemGreen, UIColor.systemGreen ]
            
            //その他設定
            barChart.dragDecelerationEnabled = true //指を離してもスクロール続くか
            barChart.dragDecelerationFrictionCoef = 0.6 //ドラッグ時の減速スピード(0-1)
        barChart.chartDescription.text = nil //Description(今回はなし)
            barChart.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //Background Color
            barChart.doubleTapToZoomEnabled = false  //ダブルタップでの拡大禁止
            barChart.animate(xAxisDuration: 2.5, yAxisDuration: 2.5, easingOption: .linear) //グラフのアニメーション(秒数で設定)
            
            
        }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
}


