//
//  ViewController3.swift
//  timer
//
//  Created by 阪田竜生 on 2022/09/29.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic



class ViewController3: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    
   
    @IBOutlet weak var calendar: FSCalendar!
    var newmemoLists: [String] = []
    var newmemoLists2: [String] = []
    var savealldate: [String] = []
    var eventsDate : [String] = []
    var date: [[String]] = []
    var tag: Int = 0
    var cellidentifar: String = ""
    
    @IBOutlet weak var tabel: UITableView!
    
   @IBOutlet weak var table2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲートの設定
        self.calendar.dataSource = self
        self.calendar.delegate = self
        let defaults = UserDefaults.standard
        let loadedMemoList = defaults.object(forKey: "MEMO_LIST")
        if (loadedMemoList as? [String] != nil) {
            
            newmemoLists = loadedMemoList as! [String]
            savealldate = loadedMemoList as! [String]
            }
        
        let defaults2 = UserDefaults.standard
        let loadedMemoList2 = defaults2.object(forKey: "SKEMEMO_LIST")
        if (loadedMemoList2 as? [String] != nil) {
            
            eventsDate = loadedMemoList2 as! [String]
            
            }
        
        let defaults3 = UserDefaults.standard
        let loadedMemoList3  = defaults3.object(forKey: "MEMO_LIST2")
        if (loadedMemoList3 as? [String] != nil) {
            newmemoLists2 = loadedMemoList3 as! [String]
            }
        
        tabel.delegate = self
        table2.delegate = self
        tabel.dataSource = self
        table2.dataSource = self
        
        
        date.append(newmemoLists)
        date.append(newmemoLists2)
    }
    
    func checkTabletag(_ tableView: UITableView) -> Void{
        if(tableView.tag == 0){
            tag = 0
            cellidentifar = "Cell"
        }
        else{
            tag = 1
            cellidentifar = "Cell2"
        }
    }
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            checkTabletag(tableView)
            return /*newmemoLists.count*/date[tag].count
       }
       //ここが一覧表示
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           checkTabletag(tableView)
           
           let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifar, for: indexPath as IndexPath)
           cell.textLabel?.text = date[tag][indexPath.row] //as? String
           
           return cell
       }
    
    func tableView2(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return newmemoLists2.count
       }
    
     func tableView2(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        cell2.textLabel!.text = newmemoLists2[indexPath.row]
        return cell2
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)

        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)

        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()

        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }

    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }

    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            return UIColor.red
        }

        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }

        return nil
    }
    
    @IBAction func close(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(savealldate, forKey: "MEMO_LIST2")
        dismiss(animated: true)
    }
    
    @IBAction func Clear(_ sender: Any) {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        tabel.reloadData()
    }
    
    
    //ここはイベントの処理
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
               dateFormatter.dateFormat = "yyyy-MM-dd"
               for eventDate in eventsDate{
                   guard let eventDate = dateFormatter.date(from: eventDate) else { return 0 }
                   if date.compare(eventDate) == .orderedSame{
                       return 1
                   }
               }
               return 0
    }
    
    
    
}
