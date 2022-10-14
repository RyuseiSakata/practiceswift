//
//  ViewController.swift
//  timer
//
//  Created by 阪田竜生 on 2022/09/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timesave: UILabel!
    var hour = Calendar.current.component(.hour, from: Date())
    var minute = Calendar.current.component(.minute, from: Date())
    var second = Calendar.current.component(.second, from: Date())
    var memoList: [Int] = []
    var memoLists: [String] = []
    var memoLists2: [String] = []
    var skememoLists: [String] = []
    var timema :Int = 0
    var flag : Bool = false
    var flaga: Int = 0;
    var player: AVAudioPlayer?
    
    /*let date = Date()*/
    //日本時間を表示
    var hiduke = DateFormatter()
    var timechecker :String = ""
    var skechecker :String = ""
    
    var mytimer = Timer()
    var mytimer2 = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        /*time.text = "\(hour) \(minute) \(second)"*/
        timecheck()
                mytimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timecheck), userInfo: nil, repeats: true)
        
        let defaults = UserDefaults.standard
        let loadedMemoList = defaults.object(forKey: "MEMO_LIST")
        if (loadedMemoList as? [String] != nil) {
           
            memoLists = loadedMemoList as! [String]
          
            }
        let loadedMemoList2 = defaults.object(forKey: "MEMO_LIST2")
        if (loadedMemoList2 as? [String] != nil) {
           
            memoLists2 = loadedMemoList2 as! [String]
          
            }
        
    }
    
    @objc func timecheck(){
        
        let date = Date()
        //日本時間を表示
        let formatterJP = DateFormatter()
        let formatterJP2 = DateFormatter()
        formatterJP.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMMHms", options: 0, locale: Locale(identifier: "ja_JP"))
        formatterJP2.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: Locale(identifier: "ja_JP"))
        formatterJP.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        //memoLists.append(/*hour*3600+minute*60+second*/formatterJP.string(from: date))
        time.text = ("🇯🇵　\(formatterJP.string(from: date))")
        timechecker = formatterJP.string(from: date)
        skechecker = formatterJP2.string(from: date)
    }
   
    
    
    func applyMemo() {
        hour = Calendar.current.component(.hour, from: Date())
        minute = Calendar.current.component(.minute, from: Date())
        second = Calendar.current.component(.second, from: Date())
        //memoList.append(/*hour*3600+minute*60+second*/)
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        memoLists.append(/*hour*3600+minute*60+second*/timechecker)
       skememoLists.append(/*hour*3600+minute*60+second*/skechecker)
        defaults.set(memoLists, forKey: "MEMO_LIST")
        defaults2.set(skememoLists, forKey: "SKEMEMO_LIST")
        
        flag = true
        
        
        mytimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.timema = self.timema+1
            self.timesave.text = "\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒"
            
            if(self.timema == 8*3600){
                
                self.applyMemo2()
            }
        })
       
    }
    
    
    func applyMemo2() {
  
            let defaults = UserDefaults.standard
            memoLists2.append(timechecker)
            defaults.set(memoLists2, forKey: "MEMO_LIST2")
            self.flag = false
            self.flaga = 1
            mytimer.invalidate()
            
            
    }
    
    @IBAction func input(_ sender: Any) {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        let kijyunn = calendar.date(from: DateComponents(year: year,month: month,day: day,hour: 0))!
        let kijyunn2 = calendar.date(from: DateComponents(year: year,month: month,day: day,hour: 4))!
        
        print(date)
        print(kijyunn)
        print(kijyunn2)
        
        let defaults = UserDefaults.standard
        let loadedMemoList4  = defaults.object(forKey: "Hiduke")
        
        if date > kijyunn && date < kijyunn2  {
            
            if flag == false{
                applyMemo()
               
                let nowday = calendar.component(.day, from: date)
                let defaults5 = UserDefaults.standard
                defaults5.set(nowday, forKey: "Hiduke")
                
                let dialog = UIAlertController(title: "残業出勤しました", message: "残業中の時間が記録されます", preferredStyle: .alert)
               dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(dialog, animated: true, completion: nil)
            }
            
            else {
                let dialog = UIAlertController(title: "退勤してください", message: "退勤しないと出勤できません", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // 生成したダイアログを実際に表示します
                self.present(dialog, animated: true, completion: nil)
            }
        }
        else {
            if  flag == false && loadedMemoList4 != nil && day == loadedMemoList4 as! Int{
                print("adfadf")
                let dialog = UIAlertController(title: "エラー", message: "出勤は1日に１回しかできません", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // 生成したダイアログを実際に表示します
                self.present(dialog, animated: true, completion: nil)
            }
            else if flag == false{
                applyMemo()
                
                let nowday = calendar.component(.day, from: date)
                let defaults5 = UserDefaults.standard
                defaults5.set(nowday, forKey: "Hiduke")
                // ダイアログ(AlertControllerのインスタンス)を生成します
                //   titleには、ダイアログの表題として表示される文字列を指定します
                //   messageには、ダイアログの説明として表示される文字列を指定します
                let dialog = UIAlertController(title: "出勤しました", message: "出勤時間が記録されます", preferredStyle: .alert)
                // 選択肢(ボタン)を2つ(OKとCancel)追加します
                //   titleには、選択肢として表示される文字列を指定します
                //   styleには、通常は「.default」、キャンセルなど操作を無効にするものは「.cancel」、削除など注意して選択すべきものは「.destructive」を指定します
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // 生成したダイアログを実際に表示します
                self.present(dialog, animated: true, completion: nil)
            }
            
            else {
                let dialog = UIAlertController(title: "退勤してください", message: "退勤しないと出勤できません", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // 生成したダイアログを実際に表示します
                self.present(dialog, animated: true, completion: nil)
            }
        }
    }
    
   
    @IBAction func taikinnbutonn(_ sender: Any) {
        if flag == false{
            let dialog = UIAlertController(title: "出勤してください", message: "本日はまだ出勤していません", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            // 生成したダイアログを実際に表示します
            self.present(dialog, animated: true, completion: nil)
        }
        
        else{
            applyMemo2()
            let dialog = UIAlertController(title: "退勤しました", message: "お疲れ様です。退勤時間が記録されます", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // 生成したダイアログを実際に表示します
            self.present(dialog, animated: true, completion: nil)
            
            
        }
    }
    
    //ここで画面遷移処理
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?) {
            
        if segue.identifier == "showView2" {
            
           /* let vc = segue.destination as! ViewController3
            vc.newmemoLists.append(timechecker)*/
            
            
             
           /* _ = segue.destination as! ViewController3
            vc.newmemoLists2.append(timechecker)*/
            if(flaga == 1){
                let defaults = UserDefaults.standard
                let vc = segue.destination as! ViewController3
                let loadedMemoList4  = defaults.object(forKey: "sumtime")
                if (loadedMemoList4 as? Int != nil) {
                    vc.showsumtimer = loadedMemoList4 as! Int
                }
                //let vc = segue.destination as! ViewController3
                vc.showsumtimer += timema
                let defaults5 = UserDefaults.standard
                defaults5.set(vc.showsumtimer, forKey: "sumtime")
                //dump(timema)
                timema = 0
                flaga = 2;
            }
            
        }
    }
    
    
}

