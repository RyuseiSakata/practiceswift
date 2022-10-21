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
    
    var roudoujikann: [Int] = []
    var hozonnnitiji: [String] = []
    
    var chartView: LineChartView!
        var chartDataSet: LineChartDataSet!
        // 今回使用するサンプルデータ
        let sampleData = [0, 99, 93, 67, 45, 72, 58]
        
        /*override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            // グラフを表示する
            let defaults = UserDefaults.standard
            let loadedMemoList3  = defaults.object(forKey: "roudoujikann")
            if (loadedMemoList3 as? [Int] != nil) {
                roudoujikann = loadedMemoList3 as! [Int]
                }
            
            
            let loadedMemoList4  = defaults.object(forKey: "hozonnnitiji")
            if (loadedMemoList4 as? Int != nil) {
                hozonnnitiji = loadedMemoList4 as! [String]
                }
            
            
            displayChart(data: sampleData)
        }
        
        func displayChart(data: [Int]) {
            // グラフの範囲を指定する
            chartView = LineChartView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 400))
            // プロットデータ(y軸)を保持する配列
            var dataEntries = [ChartDataEntry]()
            
            for (xValue, yValue) in data.enumerated() {
                let dataEntry = ChartDataEntry(x: Double(xValue), y: Double(yValue))
                dataEntries.append(dataEntry)
            }
            // グラフにデータを適用
            chartDataSet = LineChartDataSet(entries: dataEntries, label: "SampleDataChart")
            
            chartDataSet.lineWidth = 5.0 // グラフの線の太さを変更
            chartDataSet.mode = .cubicBezier // 滑らかなグラフの曲線にする
            
            chartView.data = LineChartData(dataSet: chartDataSet)
            
            // X軸(xAxis)
            chartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
            
            // Y軸(leftAxis/rightAxis)
            chartView.leftAxis.axisMaximum = 100 //y左軸最大値
            chartView.leftAxis.axisMinimum = 0 //y左軸最小値
            chartView.leftAxis.labelCount = 10// y軸ラベルの数
            chartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示
            
            // その他の変更
            chartView.highlightPerTapEnabled = false // プロットをタップして選択不可
            chartView.legend.enabled = false // グラフ名（凡例）を非表示
            chartView.pinchZoomEnabled = false // ピンチズーム不可
            chartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
            chartView.extraTopOffset = 20 // 上から20pxオフセットすることで上の方にある値(99.0)を表示する
            
            chartView.animate(xAxisDuration: 2) // 2秒かけて左から右にグラフをアニメーションで表示する
            chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: items.map({$0.name}))
            
            //chartView.xAxis.valueFormatter = formatter
                    //labelCountはChartDataEntryと同じ数だけ入れます。
                    chartView.xAxis.labelCount = 7
                    //granularityは1.0で固定
                    chartView.xAxis.granularity = 1.0
            
            let xAxisValues = hozonnnitiji

                    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
                        //granularityを１.０、labelCountを１２にしているおかげで引数のvalueは1.0, 2.0, 3.0・・・１１.０となります。
                        let index = Int(value)
                        return xAxisValues[index]
                    }
            
            view.addSubview(chartView)
        }*/
    override func viewDidLoad() {
            super.viewDidLoad()
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        let loadedMemoList3  = defaults.object(forKey: "roudoujikann")
        if (loadedMemoList3 as? [Int] != nil) {
            roudoujikann = loadedMemoList3 as! [Int]
            }
        
        
        let loadedMemoList4  = defaults2.object(forKey: "hozonnnitiji")
        if (loadedMemoList4 as? [String] != nil) {
            hozonnnitiji = loadedMemoList4 as! [String]
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
            
            /*let day1 = Date(timeIntervalSinceNow: -(60*60*24)) //1日前
        //  let day2 = Date() //当日 今回これはチャートに表示させない
            let day3 = Date(timeIntervalSinceNow: 60*60*24) //1日後
            let day4 = Date(timeIntervalSinceNow: -(60*60*48)) //2日後
            let day5 = Date(timeIntervalSinceNow: -(60*60*72)) //3日後
            let day6 = Date(timeIntervalSinceNow: -(60*60*96)) //4日後
            let day7 = Date(timeIntervalSinceNow: -(60*60*120)) //5日後*/
            
            /*let time1 = hozonnnitiji[0]
            let time2 = hozonnnitiji[1] //当日 今回これはチャートに表示させない
            let time3 = hozonnnitiji[2]
            let time4 = hozonnnitiji[3]
            let time5 = hozonnnitiji[4]
            let time6 = hozonnnitiji[5]
            let time7 = hozonnnitiji[6]*/
            
            //labels配列に１つずつ代入していく
           /* labels[0] = hozonnnitiji[0]
            labels[1] = hozonnnitiji[1] //ここだけ手書きにしてみる
            labels[2] = "ad"
            labels[3] = "adf"
            labels[4] = "dff"
            labels[5] = "今日"
            labels[6] = "adf"*/
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
            let rawData: [Int] = roudoujikann
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


