//
//  ViewController.swift
//  timer
//
//  Created by 阪田竜生 on 2022/09/21.
//

import UIKit
import AVFoundation
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var shukkinnbutton: UIButton!
    @IBOutlet weak var taikinnbutton: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timesave: UILabel!
    var day = Calendar.current.component(.day, from: Date())
    var hour = Calendar.current.component(.hour, from: Date())
    var minute = Calendar.current.component(.minute, from: Date())
    var second = Calendar.current.component(.second, from: Date())
    var memoList: [Int] = []
    var memoLists: [String] = []
    var memoLists2: [String] = []
    var skememoLists: [String] = []
    var roudoujikann: [Double] = []
    var hozonnnitiji: [String] = []
    var tukijikann: [Int] = []
    var timema :Int = 0
    var flag : Bool = false
    var flaga: Int = 0;
    var player: AVAudioPlayer?
    var flagera = false
    var backgroundTaskID : UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
    var backtime : Int = 0
    var backtimeflag : Bool = false
    var changemonth : Bool = true
    var nitiji2 :Bool = true
    /*let date = Date()*/
    //日本時間を表示
    var hiduke = DateFormatter()
    var timechecker :String = ""
    var skechecker :String = ""
    
    var mytimer = Timer()
    var mytimer2 = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(foreground(notification:)),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil
        )
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(background(notification:)),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil
        )
        
        let context = LAContext()
        var error: NSError?
        let description: String = "認証"
        taikinnbutton.isHidden = true
        
        // Touch ID・Face IDが利用できるデバイスか確認する
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 利用できる場合は指紋・顔認証を要求する
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: description, reply: {success, evaluateError in
                if (success) {
                    self.flagera = true
                    print("認証成功")
                }
                
                else {
                    // 認証失敗時の処理を書く
                    print("認証失敗")
                }
            })
        } else {
            // Touch ID・Face IDが利用できない場合の処理
            let errorDescription = error?.userInfo["NSLocalizedDescription"] ?? ""
            print(errorDescription) // Biometry is not available on this device.
        }
        
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
        let loadedMemoList3  = defaults.object(forKey: "roudoujikann")
        if (loadedMemoList3 as? [Double] != nil) {
            roudoujikann = loadedMemoList3 as! [Double]
            }
        
        
        let loadedMemoList4  = defaults.object(forKey: "hozonnnitiji")
        if (loadedMemoList4 as? [String] != nil) {
            hozonnnitiji = loadedMemoList4 as! [String]
            }
        
        let loadedMemoList5  = defaults.object(forKey: "SKEMEMO_LIST")
        if (loadedMemoList5 as? [String] != nil) {
            skememoLists = loadedMemoList5 as! [String]
            }
    }
    
    @objc func foreground(notification: Notification) {
        
        let defaults = UserDefaults.standard
        let loadedMemoList4  = defaults.object(forKey: "hozonnnitiji")
        if (loadedMemoList4 as? String != nil) {
            hozonnnitiji = loadedMemoList4 as! [String]
            }
        
        let today = Calendar.current.component(.day, from: Date())
        if(backtimeflag){
            if(today == day){
                hour = Calendar.current.component(.hour, from: Date())
                minute = Calendar.current.component(.minute, from: Date())
                second = Calendar.current.component(.second, from: Date())
                let comebacktime = hour*3600+minute*60+second
                timema += comebacktime - backtime
                
                if(timema >= 8*3600&&flag == true){
                    timema = 8 * 3600
                    let dialog = UIAlertController(title: "自動で退勤しました", message: "労働時間が８時間を超えてしまったため自動で退勤しました", preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    // 生成したダイアログを実際に表示します
                    self.present(dialog, animated: true, completion: nil)
                }
            }
            else{
               let hour2 = Calendar.current.component(.hour, from: Date())
               let minute2 = Calendar.current.component(.minute, from: Date())
               let second2 = Calendar.current.component(.second, from: Date())
                
                let comebacktime = (24 - hour)*3600 + (60 - minute)*60 + (60 - second) + (hour2*3600+minute2*60+second2)
                
                timema += comebacktime
                if(timema >= 8*3600&&flag == true){
                    timema = 8 * 3600
                    let dialog = UIAlertController(title: "自動で退勤しました", message: "労働時間が８時間を超えてしまったため自動で退勤しました", preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    // 生成したダイアログを実際に表示します
                    self.present(dialog, animated: true, completion: nil)
                }
            }
        }
        print("\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒")
    }
    
    @objc func background(notification: Notification) {
        
        let defaults3 = UserDefaults.standard
        defaults3.set(hozonnnitiji, forKey: "hozonnnitiji")
        print(hozonnnitiji)
        day = Calendar.current.component(.day, from: Date())
        hour = Calendar.current.component(.hour, from: Date())
        minute = Calendar.current.component(.minute, from: Date())
        second = Calendar.current.component(.second, from: Date())
        backtime = hour*3600+minute*60+second
        backtimeflag = true
        
    }
    
    
    @objc func timecheck(){
        
        let date = Date()
        //日本時間を表示
        let formatterJP = DateFormatter()
        let formatterJP2 = DateFormatter()
        formatterJP.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMMHms", options: 0, locale: Locale(identifier: "ja_JP"))
        formatterJP2.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: Locale(identifier: "ja_JP"))
        formatterJP.timeZone = TimeZone(identifier:  "Asia/Tokyo")
       
        time.text = ("🇯🇵　\(formatterJP.string(from: date))")
        timechecker = formatterJP.string(from: date)
        skechecker = formatterJP2.string(from: date)
    }
   
    
    
    func applyMemo() {
        taikinnbutton.isHidden = false
        shukkinnbutton.isHidden = true
        hour = Calendar.current.component(.hour, from: Date())
        minute = Calendar.current.component(.minute, from: Date())
        second = Calendar.current.component(.second, from: Date())
       
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        memoLists.append(timechecker)
        skememoLists.append(skechecker)
        defaults.set(memoLists, forKey: "MEMO_LIST")
        defaults2.set(skememoLists, forKey: "SKEMEMO_LIST")
        
        flag = true
        self.flaga = 1
        timema = 0
        
        mytimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.timema = self.timema+1
            self.timesave.text = "\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒"
            
            if(self.timema >= 8*3600){
                
                self.applyMemo2()
            }
        })
       
    }
    
    
    
    func applyMemo2() {
        
        shukkinnbutton.isHidden = false
        taikinnbutton.isHidden = true
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        let defaults3 = UserDefaults.standard
        let ji :Int = timema/3600
        let guraftime = Double((timema/60)%60)/100
        let timee : Double = Double(ji) + guraftime
      
        memoLists2.append(timechecker)
        defaults.set(memoLists2, forKey: "MEMO_LIST2")
        roudoujikann.append(timee)
       
        let dt = Date()
        let dateFormatter = DateFormatter()

        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "Md", options: 0, locale: Locale(identifier: "ja_JP"))
        hozonnnitiji.append(dateFormatter.string(from: dt))
        
        //print(hozonnnitiji)
        defaults2.set(roudoujikann, forKey: "roudoujikann")
        defaults3.set(hozonnnitiji, forKey: "hozonnnitiji")
            self.flag = false
            self.flaga = 1
            mytimer.invalidate()
            mytimer2.invalidate()
        
    }
    
    @IBAction func input(_ sender: Any) {
        
        
        
        if flagera{
            let date = Date()
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            _ = calendar.component(.hour, from: date)
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            
            let kijyunn = calendar.date(from: DateComponents(year: year,month: month,day: day,hour: 0))!
            let kijyunn2 = calendar.date(from: DateComponents(year: year,month: month,day: day,hour: 4))!
            
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
                   
                    let dialog = UIAlertController(title: "出勤しました", message: "出勤時間が記録されます", preferredStyle: .alert)
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
        else{
            let dialog = UIAlertController(title: "認証失敗", message: "アプリを再起動してもう一度本人確認をしてください", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // 生成したダイアログを実際に表示します
            self.present(dialog, animated: true, completion: nil)
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
    
    
    @IBAction func clear(_ sender: Any) {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
    
    //ここで画面遷移処理
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?) {
            
        if segue.identifier == "showView2" {
           
            let today = Date()
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "d", options: 0, locale: Locale(identifier: "ja_JP"))
            print(dateFormatter.string(from:today))
            
            if(flaga == 1){
                let defaults = UserDefaults.standard
                let vc = segue.destination as! ViewController3
                let loadedMemoList4  = defaults.object(forKey: "sumtime")
                if (loadedMemoList4 as? Int != nil) {
                    vc.showsumtimer = loadedMemoList4 as! Int
                }
                
                if dateFormatter.string(from:today) == "1日"&&nitiji2{
                    changemonth = true
                    nitiji2 = false
                }
                else if dateFormatter.string(from:today) != "1日"{
                    changemonth = true
                }
                print(changemonth)
                if dateFormatter.string(from:today) == "1日" && changemonth{
                    
                    let defaults5 = UserDefaults.standard
                    defaults5.set(vc.showsumtimer, forKey: "TUKIJIKANN")
                    print(vc.showsumtimer)
                    vc.showsumtimer = 0;
                    let defaults6 = UserDefaults.standard
                    defaults6.set(vc.showsumtimer, forKey: "sumtime")
                    changemonth = false
                }
                else{
                    vc.showsumtimer += timema
                    let defaults5 = UserDefaults.standard
                    defaults5.set(vc.showsumtimer, forKey: "sumtime")
                    let defaults6 = UserDefaults.standard
                    defaults6.set(vc.showsumtimer, forKey: "TUKIJIKANN")
                    print(vc.showsumtimer)
                }
                timema = 0
                flaga = 2;
            }
            
        }
    }
    
    
}

