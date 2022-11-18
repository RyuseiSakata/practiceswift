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
    var eventsDate2 : [String] = []
    var date: [[String]] = []
    var tag: Int = 0
    var sumtimer: [Int] = []
    var showsumtimer: Int = 0
    var cellidentifar: String = ""
    
    var filterdDatas = [String]()
    
    private var filterdDdatas = [String]()
    
    @IBOutlet weak var tabel: UITableView!
    
    @IBOutlet weak var table2: UITableView!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var text: UITextField!
    
    @IBOutlet weak var roudoujikann: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲートの設定
        self.calendar.dataSource = self
        self.calendar.delegate = self
        
        
        
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        let defaults3 = UserDefaults.standard
        let loadedMemoList = defaults.object(forKey: "MEMO_LIST")
        if (loadedMemoList as? [String] != nil) {
            
            newmemoLists = loadedMemoList as! [String]
            savealldate = loadedMemoList as! [String]
            }
        
       
        let loadedMemoList2 = defaults2.object(forKey: "SKEMEMO_LIST")
        if (loadedMemoList2 as? [String] != nil) {
            
            eventsDate = loadedMemoList2 as! [String]
            
            }
       
        
        let loadedMemoList3  = defaults3.object(forKey: "MEMO_LIST2")
        if (loadedMemoList3 as? [String] != nil) {
            newmemoLists2 = loadedMemoList3 as! [String]
            }
        
        let today = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "d", options: 0, locale: Locale(identifier: "ja_JP"))
       
   
            let loadedMemoList4  = defaults.object(forKey: "sumtime")
            if (loadedMemoList4 as? Int != nil) {
                showsumtimer = loadedMemoList4 as! Int
            }
        
        tabel.delegate = self
        table2.delegate = self
        tabel.dataSource = self
        table2.dataSource = self
        print(eventsDate)
        print(newmemoLists)
        dump(showsumtimer)
        date.append(newmemoLists)
        date.append(newmemoLists2)
      
        roudoujikann.text = "今月は\((showsumtimer/3600)%60)時間\((showsumtimer/60)%60)分\((showsumtimer)%60)秒働きました！！"
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
            return date[tag].count
       }
       //ここが一覧表示
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           checkTabletag(tableView)
           
          
           let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifar, for: indexPath as IndexPath)
           cell.textLabel?.text = date[tag][indexPath.row] //as? String
           
           return cell
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
      //  let defaults = UserDefaults.standard
       // defaults.set(newmemoLists2, forKey: "MEMO_LIST2")
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
    
    //この関数は選択した日付を保持
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        //labelDate.text = "\(year)/\(month)/\(day)"
        
        let result1 = newmemoLists.first(where: { $0.contains("\(year)年\(month)月\(day)日") })
        let result2 = newmemoLists2.first(where: { $0.contains("\(year)年\(month)月\(day)日") })
        print(result1)
        print(result2)
        
        
        
        if result1 != nil && result2 != nil{
            print("入った")
            self.date.removeAll()
            var hyoujidate : [String] = []
            var hyoujidate2 : [String] = []
            
            hyoujidate.append(result1!)
            hyoujidate2.append(result2!)
            
            self.date.append(hyoujidate)
            self.date.append(hyoujidate2)
            print(self.date)
            
        }
        else{
            self.date.removeAll()
            self.date.append(newmemoLists)
            self.date.append(newmemoLists2)
            print(self.date)
        }
        
        tabel.reloadData()
        table2.reloadData()
    }
    
    
    
}
