//
//  ViewController4.swift
//  Charts
//
//  Created by 阪田竜生 on 2022/10/18.
//

import UIKit
import Charts

class ViewController4: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
    var nitiji:Bool = true;
    var nitiji2:Bool = false;
    var monchecker2 :String = ""
    var monchecker3 :String = ""
    
    var chartView: LineChartView!
    var chartDataSet: LineChartDataSet!
        
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        let defaults3 = UserDefaults.standard
        let loadedMemoList3  = defaults.object(forKey: "roudoujikann")
        if (loadedMemoList3 as? [Double] != nil) {
            roudoujikann = loadedMemoList3 as! [Double]
        }
        
        let loadedMemoList4  = defaults2.object(forKey: "hozonnnitiji")
        if (loadedMemoList4 as? [String] != nil) {
            hozonnnitiji = loadedMemoList4 as! [String]
        }
        
        let loadedMemoList6  = defaults3.object(forKey: "TUKIGOTONOROUDOUJIKANN")
        if (loadedMemoList6 as? [String] != nil) {
            sumtime = loadedMemoList6 as! [String]
        }
        
        let loadedMemoList7  = defaults3.object(forKey: "nitiBOOL")
        if (loadedMemoList7 as? Bool != nil) {
            nitiji  = loadedMemoList7 as! Bool
        }
        
        let loadedMemoList8  = defaults.object(forKey: "Month2")
         if (loadedMemoList8 as? String != nil) {
             monchecker2 = loadedMemoList8 as! String
         }
        let loadedMemoList9  = defaults.object(forKey: "SHOWMonth")
         if (loadedMemoList9 as? String != nil) {
             monchecker3 = loadedMemoList9 as! String
         }
        
        let dateFormatter = DateFormatter()
        let dateFormatter2 = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "M", options: 0, locale: Locale(identifier: "ja_JP"))
        dateFormatter2.dateFormat = DateFormatter.dateFormat(fromTemplate: "yM", options: 0, locale: Locale(identifier: "ja_JP"))
        print(monchecker2)
        
       // let month :Int = monchecker2.toInt()!
        
        let today = Date()
        //let yesterday = Calendar.current.date(bySetting: .month,value:month,of:Date())!
        
        print(dateFormatter.string(from:today))
        print(monchecker2)
        
        if dateFormatter.string(from:today) != monchecker2/*&&nitiji*/{
           
            let defaults10 = UserDefaults.standard
            let loadedMemoList5  = defaults10.object(forKey: "TUKIJIKANN")
            if (loadedMemoList5 as? Int != nil) {
                sumtime2 = loadedMemoList5 as! Int
            }
            
            sumtime.append(/*dateFormatter2.string(from: yesterday)*/monchecker3+"　"+String((sumtime2/3600)%60)+"時間"+String((sumtime2/60)%60)+"分働きました")
            
            /*if(monchecker2 == ""){
                sumtime.removeFirst();
            }*/
            let defaults5 = UserDefaults.standard
            defaults5.set(sumtime, forKey: "TUKIGOTONOROUDOUJIKANN")
            nitiji = false
            TableView.reloadData()
            let defaults8 = UserDefaults.standard
            defaults8.set(nitiji, forKey: "nitiBOOL")
            let defaults3 = UserDefaults.standard
            defaults3.set(dateFormatter.string(from:today), forKey: "Month2")
            
            getChart()
        }
        
        else{
            //nitiji = true
            let defaults9 = UserDefaults.standard
            defaults9.set(nitiji, forKey: "nitiBOOL")
            if sumtime.count == 0{
                sumtime = ["ここには","月毎の労働時間が記録されます。","上のグラフでは","直近１週間の就労時間が表示されます。"]
            }
            getChart()
           
        }
        if(monchecker2 == ""){
            sumtime = ["ここには","月毎の労働時間が記録されます。","上のグラフでは","直近１週間の就労時間が表示されます。"]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sumtime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // checkTabletag(tableView)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel?.text = sumtime[indexPath.row] //as? String
        
        return cell
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
        var count = hozonnnitiji.count
        
        let defaults3 = UserDefaults.standard
        let loadedMemoList3  = defaults3.object(forKey: "roudoujikann")
        if (loadedMemoList3 as? [Double] != nil) {
            roudoujikann = loadedMemoList3 as! [Double]
        }
        
        let defaults4 = UserDefaults.standard
        let loadedMemoList4  = defaults4.object(forKey: "hozonnnitiji")
        if (loadedMemoList4 as? [String] != nil) {
            hozonnnitiji = loadedMemoList4 as! [String]
        }
        
        while hozonnnitiji.count > 7 {
            
            hozonnnitiji.removeFirst()
           
        }
        
        while roudoujikann.count > 7 {
            
            roudoujikann.removeFirst()
            
        }
        
        let defaults5 = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        defaults2.set(roudoujikann, forKey: "roudoujikann")
        defaults5.set(hozonnnitiji, forKey: "hozonnnitiji")
        
        while num < hozonnnitiji.count{
            labels[num] = hozonnnitiji[num]
            num = num + 1
        }
          
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
            
            
            //その他設定
            barChart.dragDecelerationEnabled = true //指を離してもスクロール続くか
            barChart.dragDecelerationFrictionCoef = 0.6 //ドラッグ時の減速スピード(0-1)
            barChart.chartDescription.text = nil //Description(今回はなし)
            barChart.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //Background Color
            barChart.doubleTapToZoomEnabled = false  //ダブルタップでの拡大禁止
            barChart.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .linear) //グラフのアニメーション(秒数で設定)
            
            
        }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
}


