//
//  ViewController.swift
//  timer
//
//  Created by 阪田竜生 on 2022/09/21.
//

import UIKit
import AVFoundation
import LocalAuthentication

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var shukkinnbutton: UIButton!
    @IBOutlet weak var taikinnbutton: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timesave: UILabel!
    @IBOutlet weak var resetbutton: UIButton!
    
    var day = Calendar.current.component(.day, from: Date())
    var hour = Calendar.current.component(.hour, from: Date())
    var minute = Calendar.current.component(.minute, from: Date())
    var second = Calendar.current.component(.second, from: Date())
    var memoList: [Int] = []
    var start_time: [String] = []
    var end_time: [String] = []
    var skememoLists: [String] = []
    var roudoujikann: [Double] = []
    var hozonnnitiji: [String] = []
    var tukijikann: [Int] = []
    var timema :Int = 0
    var flag : Bool = false
    var flag2 : Bool = false
    var flag3 : Bool = false
    var flaga: Int = 0;
    var player: AVAudioPlayer?
    var flagera = false
    var backgroundTaskID : UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
    var backtime : Int = 0
    var backtimeflag : Bool = false
    var changemonth : Bool = true
    var nitiji2 :Bool = true
    var modotime : Int = 0
    var bababaflag :Bool = false
    var dontmove :Bool = true
    //日本時間を表示
    var hiduke = DateFormatter()
    var timechecker :String = ""
    var skechecker :String = ""
    var monchecker :String = ""
    var monchecker2 :String = ""
    var monchecker3 :String = ""
    var showdate :String = ""
    
    var g_sumtime:[String] = []
    var sumtime2:Int = 0
    
    var mytimer = Timer()
    var mytimer2 = Timer()
    
   
           
           //UIGestureのデリゲート
    //func tapGesture.delegate = self
           
           //viewに追加
           //self.view.addGestureRecognizer(tapGesture)
    
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
        resetbutton.isHidden = true
        dontmove = true
        // Touch ID・Face IDが利用できるデバイスか確認する
        if (context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)||context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)){
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // 利用できる場合は指紋・顔認証を要求する
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: description, reply: {success, evaluateError in
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
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: description, reply: {success, evaluateError in
                    if (success) {
                        self.flagera = true
                        print("認証成功")
                    }
                    
                    else {
                        // 認証失敗時の処理を書く
                        print("認証失敗")
                    }
                })
                let errorDescription = error?.userInfo["NSLocalizedDescription"] ?? ""
                print(errorDescription) // Biometry is not available on this device.
            }
        }else{
            self.flagera = true
        }
        // Do any additional setup after loading the view.
       
        
        timecheck()
                mytimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timecheck), userInfo: nil, repeats: true)
        
        let defaults = UserDefaults.standard
        let loadedMemoList = defaults.object(forKey: "MEMO_LIST")
        if (loadedMemoList as? [String] != nil) {
           
            start_time = loadedMemoList as! [String]
          
            }
        let loadedMemoList2 = defaults.object(forKey: "MEMO_LIST2")
        if (loadedMemoList2 as? [String] != nil) {
           
            end_time = loadedMemoList2 as! [String]
          
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
        let loadedMemoList6  = defaults.object(forKey: "Modori")
        if (loadedMemoList6 as? Bool != nil) {
            backtimeflag = loadedMemoList6 as! Bool
            }
        
        let loadedMemoList7  = defaults.object(forKey: "Modorimasita")
        if (loadedMemoList7 as? Int != nil) {
             modotime = loadedMemoList7 as! Int
            }
        
        let loadedMemoList8  = defaults.object(forKey: "Month")
         if (loadedMemoList8 as? String != nil) {
             monchecker2 = loadedMemoList8 as! String
         }
        let loadedMemoList9  = defaults.object(forKey: "TUKIGOTONOROUDOUJIKANN")
        if (loadedMemoList9 as? [String] != nil) {
            g_sumtime = loadedMemoList9 as! [String]
        }
        
        //ここにはアプリのタスクを切った時の処理が記載されています
       
        
    }
    
    @objc func foreground(notification: Notification) {
        
        
        let defaults1 = UserDefaults.standard
        let today1 = Date()
        let dateFormatter1 = DateFormatter()
        
        print(monchecker2)
        
        dateFormatter1.dateFormat = DateFormatter.dateFormat(fromTemplate: "M", options: 0, locale: Locale(identifier: "ja_JP"))
        
        if (dateFormatter1.string(from:today1) == monchecker2 || monchecker2 == ""){
           
            let defaults12 = UserDefaults.standard
            defaults12.set(showdate, forKey: "SHOWMonth")
            
            let defaults5 = UserDefaults.standard
            defaults5.set(monchecker, forKey: "Month")
            
            let defaults6 = UserDefaults.standard
            defaults6.set(monchecker, forKey: "Month2")
        }
        
        if dateFormatter1.string(from:today1) != monchecker2/*&&nitiji*/{
            let defaults10 = UserDefaults.standard
            var showsumtimer : Int = 0
            let loadedMemoList90  = defaults10.object(forKey: "sumtime")
            if (loadedMemoList90 as? Int != nil) {
                 showsumtimer = loadedMemoList90 as! Int
            }
           print("グラフの時間はここで設定されております")
            
            let loadedMemoList5  = defaults10.object(forKey: "TUKIJIKANN")
            if (loadedMemoList5 as? Int != nil) {
                sumtime2 = loadedMemoList5 as! Int
            }
            let loadedMemoList9  = defaults10.object(forKey: "SHOWMonth")
             if (loadedMemoList9 as? String != nil) {
                 monchecker3 = loadedMemoList9 as! String
             }
            sumtime2 = showsumtimer
            g_sumtime.append(/*dateFormatter2.string(from: yesterday)*/monchecker3+"　"+String((sumtime2/3600)%60)+"時間"+String((sumtime2/60)%60)+"分働きました")
            
            if(monchecker2 == ""){
                g_sumtime.removeFirst();
            }
            if(g_sumtime.count > 1&&g_sumtime[0] == g_sumtime[1]){
                print("ここを通れば二つ表示が消去できる")
                g_sumtime.removeFirst();
            }
            let defaults5 = UserDefaults.standard
            defaults5.set(g_sumtime, forKey: "TUKIGOTONOROUDOUJIKANN")
            let defaults3 = UserDefaults.standard
            defaults3.set(dateFormatter1.string(from:today1), forKey: "Month2")
            
           
        }
        
        print(g_sumtime)
        
        let today2 = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "M", options: 0, locale: Locale(identifier: "ja_JP"))

            if dateFormatter.string(from:today2) != monchecker2&&nitiji2{
                print("ミミみい耳耳いい耳耳みm")
                changemonth = true
                nitiji2 = false
            }
            else if dateFormatter.string(from:today2) == monchecker2{
                changemonth = true
            }
        
            if dateFormatter.string(from:today2) != monchecker2 && (backtimeflag == false || bababaflag == false){
                timema = 0
                flaga = 1
                bababaflag = true
                //backtimeflag = true
                print("ああああああああ")
            }
        
        
        let defaults = UserDefaults.standard
        let loadedMemoList4  = defaults.object(forKey: "hozonnnitiji")
        if (loadedMemoList4 as? String != nil) {
            hozonnnitiji = loadedMemoList4 as! [String]
            }
        
        let loadedMemoList7  = defaults.object(forKey: "Modorimasita")
        if (loadedMemoList7 as? Int != nil) {
             modotime = loadedMemoList7 as! Int
            }
        
        let today = Calendar.current.component(.day, from: Date())
        if(backtimeflag){
            
          /*  if(roudoujikann.count == end_time.count&&start_time.count == end_time.count){
                timema = Int(roudoujikann.last!)
                self.timesave.text = "\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒"
            }*/
            print("戻ったぜ")
            
            if(today == day){
                hour = Calendar.current.component(.hour, from: Date())
                minute = Calendar.current.component(.minute, from: Date())
                second = Calendar.current.component(.second, from: Date())
                let comebacktime = hour*3600+minute*60+second
                timema += comebacktime - backtime - 1
                //print("今日\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒")
                if(timema >= 8*3600&&flag == true){
                    timema = 8 * 3600
                    let dialog = UIAlertController(title: "自動で退勤しました", message: "労働時間が８時間を超えてしまったため自動で退勤しました", preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    // 生成したダイアログを実際に表示します
                    self.present(dialog, animated: true, completion: nil)
                    resetbutton.isHidden = true
                }
                print("今日\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒")
            }
            else{
               let hour2 = Calendar.current.component(.hour, from: Date())
               let minute2 = Calendar.current.component(.minute, from: Date())
               let second2 = Calendar.current.component(.second, from: Date())
                print("ここに入っているからおかしいのか？")
                let comebacktime = (24 - hour)*3600 + (60 - minute)*60 + (60 - second) + (hour2*3600+minute2*60+second2)
                
                timema += comebacktime
                if(timema >= 8*3600&&flag == true){
                    timema = 8 * 3600
                    let dialog = UIAlertController(title: "自動で退勤しました", message: "労働時間が８時間を超えてしまったため自動で退勤しました", preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    // 生成したダイアログを実際に表示します
                    self.present(dialog, animated: true, completion: nil)
                    resetbutton.isHidden = true
                    print("今日\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒")
                }
            }
            backtimeflag = false
            let defaults = UserDefaults.standard
            defaults.set(backtimeflag, forKey: "Modori")
        }
        else{
            if end_time.count != start_time.count{
                
                
                    taikinnbutton.isHidden = false
                    shukkinnbutton.isHidden = true
                    resetbutton.isHidden = false
                    flag = true
                    //self.flaga = 1
                    print(end_time)
                    
                    hour = Calendar.current.component(.hour, from: Date())
                    minute = Calendar.current.component(.minute, from: Date())
                    second = Calendar.current.component(.second, from: Date())
                    let comebacktime = hour*3600+minute*60+second
                    
                    timema = comebacktime - modotime
                    
                    print("これじゃ\(timema)")
                    
                    if timema <= 0 {
                        timema = 24*3600 + timema
                        print("デバック")
                        self.timema = 8*3600
                    }
                    else  if(skememoLists[skememoLists.count - 1] != skechecker){
                        timema = 24*3600 - modotime + hour*3600+minute*60+second
                        timema = 8*3600
                    }
                    
                    mytimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                        self.timema = self.timema+1
                       
                        if(self.timema >= 8*3600){
                            let dialog = UIAlertController(title: "自動で退勤しました", message: "労働時間が８時間を超えてしまったため自動で退勤しました", preferredStyle: .alert)
                            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            // 生成したダイアログを実際に表示します
                            self.present(dialog, animated: true, completion: nil)
                            self.timema = 8*3600
                            self.applyMemo2()
                        }
                        self.timesave.text = "\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒"
                    })
                
            }
        }
        
        print("\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒")
        
    }
    
    @objc func background(notification: Notification) {
        
        /*let defaults3 = UserDefaults.standard
        defaults3.set(hozonnnitiji, forKey: "hozonnnitiji")*/
        print(hozonnnitiji)
        day = Calendar.current.component(.day, from: Date())
        hour = Calendar.current.component(.hour, from: Date())
        minute = Calendar.current.component(.minute, from: Date())
        second = Calendar.current.component(.second, from: Date())
        backtime = hour*3600+minute*60+second
        
        backtimeflag = true
        
        /*ここはグラフ画面に移動しなかった時に就労時間を足していく処理である*/
        let defaults = UserDefaults.standard
        let today = Date()
        let dateFormatter = DateFormatter()
        
        print(monchecker2)
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "M", options: 0, locale: Locale(identifier: "ja_JP"))
        print(dateFormatter.string(from:today))
        //let vc = segue.destination as! ViewController3
        
        var showsumtimer : Int = 0
        
        if(flaga == 1){
           // let defaults = UserDefaults.standard
            //let vc = segue.destination as! ViewController3
            let loadedMemoList4  = defaults.object(forKey: "sumtime")
            if (loadedMemoList4 as? Int != nil) {
                 showsumtimer = loadedMemoList4 as! Int
            }
            
            if dateFormatter.string(from:today) != monchecker2&&nitiji2{
                print("ミミみい耳耳いい耳耳みm")
                changemonth = true
                nitiji2 = false
            }
            else if dateFormatter.string(from:today) == monchecker2{
                changemonth = true
            }
           
            if dateFormatter.string(from:today) != monchecker2 /*&& changemonth*/{
                /*let defaults5 = UserDefaults.standard
                defaults5.set(showsumtimer, forKey: "TUKIJIKANN")*/
                print("今月初めての出勤だよぞおお")
                print(showsumtimer)
                //timema = 0
                if(bababaflag){
                    showsumtimer = 0
                    bababaflag = false
                    print("ここは最初の処理")
                }
                else{
                    showsumtimer = 0
                    showsumtimer = timema
                    print("ここは最初以外の処理")
                }
                
                let defaults6 = UserDefaults.standard
                defaults6.set(showsumtimer, forKey: "sumtime")
                let defaults3 = UserDefaults.standard
                defaults3.set(monchecker, forKey: "Month")
                
               
                
                let loadedMemoList6  = defaults.object(forKey: "Month")
                 if (loadedMemoList6 as? String != nil) {
                     monchecker2 = loadedMemoList6 as! String
                 }
                print(monchecker2)
                changemonth = false
            }
            else{
                //vc.showsumtimer += timema
                
                print("こっちになってるぞよ")
                showsumtimer += timema
                
                let defaults5 = UserDefaults.standard
                defaults5.set(showsumtimer, forKey: "sumtime")
                /*let defaults6 = UserDefaults.standard
                defaults6.set(showsumtimer, forKey: "TUKIJIKANN")*/
                
                let defaults12 = UserDefaults.standard
                defaults12.set(showdate, forKey: "SHOWMonth")
                
                print(showsumtimer)
            }
            //timema = 0
            flaga = 2;
        }
        
        
    }
    
    
    @objc func timecheck(){
        
        let date = Date()
        //日本時間を表示
        let formatterJP = DateFormatter()
        let formatterJP2 = DateFormatter()
        let formatterJP3 = DateFormatter()
        let formatterJP4 = DateFormatter()
        formatterJP.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMMHms", options: 0, locale: Locale(identifier: "ja_JP"))
        formatterJP2.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: Locale(identifier: "ja_JP"))
        formatterJP3.dateFormat = DateFormatter.dateFormat(fromTemplate: "M", options: 0, locale: Locale(identifier: "ja_JP"))
        formatterJP4.dateFormat = DateFormatter.dateFormat(fromTemplate: "YM", options: 0, locale: Locale(identifier: "ja_JP"))
        formatterJP.timeZone = TimeZone(identifier:  "Asia/Tokyo")
       
        time.text = ("🇯🇵　\(formatterJP.string(from: date))")
        timechecker = formatterJP.string(from: date)
        skechecker = formatterJP2.string(from: date)
        monchecker = formatterJP3.string(from: date)
        showdate = formatterJP4.string(from: date)
    }
   
    
    
    func applyMemo() {
        
        
        
        bababaflag = false
        taikinnbutton.isHidden = false
        shukkinnbutton.isHidden = true
        resetbutton.isHidden = false
        hour = Calendar.current.component(.hour, from: Date())
        minute = Calendar.current.component(.minute, from: Date())
        second = Calendar.current.component(.second, from: Date())
        let  backtime : Int = hour*3600+minute*60+second
        
        let defaults1 = UserDefaults.standard
        defaults1.set(backtime, forKey: "Modorimasita")
       
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        //let defaults3 = UserDefaults.standard
       // let defaults4 = UserDefaults.standard
        start_time.append(timechecker)
        skememoLists.append(skechecker)
        defaults.set(start_time, forKey: "MEMO_LIST")
        defaults2.set(skememoLists, forKey: "SKEMEMO_LIST")
        
        //defaults3.set(monchecker, forKey: "Month")
        //defaults4.set(monchecker, forKey: "Month2")
        
        flag = true
        //self.flaga = 1
        timema = 0
        
        mytimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.timema = self.timema+1
            //self.timesave.text = "\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒"
            
            if(self.timema >= 8*3600){
                
                self.applyMemo2()
            }
            self.timesave.text = "\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒"
        })
       
    }
    
    
    
    func applyMemo2() {
        
        let defaults1 = UserDefaults.standard
        let today = Date()
        let dateFormatter1 = DateFormatter()
        
        print(monchecker2)
        
        dateFormatter1.dateFormat = DateFormatter.dateFormat(fromTemplate: "M", options: 0, locale: Locale(identifier: "ja_JP"))
        
        if (dateFormatter1.string(from:today) != monchecker2 || monchecker2 == ""){
            print("ここにはいいておりますか〜〜〜〜？")
            let defaults12 = UserDefaults.standard
            defaults12.set(showdate, forKey: "SHOWMonth")
        }
        
        let defaults5 = UserDefaults.standard
        defaults5.set(monchecker, forKey: "Month")
        
        let defaults6 = UserDefaults.standard
        defaults6.set(monchecker, forKey: "Month2")
        
        
        bababaflag = false
        shukkinnbutton.isHidden = false
        taikinnbutton.isHidden = true
        resetbutton.isHidden = true
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        let defaults3 = UserDefaults.standard
        //let ji :Double = Double(timema/3600)
        let guraftime = Double(timema/60)/60
        var timee : Double = /*Double(ji) +*/ guraftime
        //var timee : Double = Double(timema*24) //+ guraftime
        print("グラフに表示する時間だわさ")
        print(timee)
        end_time.append(timechecker)
        defaults.set(end_time, forKey: "MEMO_LIST2")
        
        //roudoujikann.append(timee)
       
        let dt = Date()
        let dateFormatter = DateFormatter()

        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "Md", options: 0, locale: Locale(identifier: "ja_JP"))
        hozonnnitiji.append(dateFormatter.string(from: dt))
        
        //print(hozonnnitiji)
        //defaults2.set(roudoujikann, forKey: "roudoujikann")
        defaults3.set(hozonnnitiji, forKey: "hozonnnitiji")
            self.flag = false
            self.flaga = 1
            mytimer.invalidate()
            mytimer2.invalidate()
        
        if timema > 3600*6 && timema < 3600*8 {
            timema = timema - 45*60
            //timee = timee - (45*60)/100
        }
        else if timema >= 3600*8{
            timema = timema - 60*60
            
        }
        roudoujikann.append(timee)
        defaults2.set(roudoujikann, forKey: "roudoujikann")
    }
    
    @IBAction func input(_ sender: Any) {
        
        flaga=0
        
        if flagera{
            let date = Date()
            let calendar = Calendar.current
            var day = calendar.component(.day, from: date)
            _ = calendar.component(.hour, from: date)
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            
            let kijyunn = calendar.date(from: DateComponents(year: year,month: month,day: day,hour: 0))!
            let kijyunn2 = calendar.date(from: DateComponents(year: year,month: month,day: day,hour: 4))!
            
            let defaults = UserDefaults.standard
            let loadedMemoList4  = defaults.object(forKey: "Hiduke")
            
            if(bababaflag == true){
                day = 0;
            }
            
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
            if timema > 3600*6 && timema < 3600*8 {
                let dialog = UIAlertController(title: "退勤しました", message: "お疲れ様です。退勤時間が記録されます。45分の休憩時間が差し引かれます", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                // 生成したダイアログを実際に表示します
                self.present(dialog, animated: true, completion: nil)
            }
            else if timema >= 3600*8{
                let dialog = UIAlertController(title: "退勤しました", message: "お疲れ様です。退勤時間が記録されます。1時間の休憩時間が差し引かれます", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                // 生成したダイアログを実際に表示します
                self.present(dialog, animated: true, completion: nil)
            }
            else{
                let dialog = UIAlertController(title: "退勤しました", message: "お疲れ様です。退勤時間が記録されます", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                // 生成したダイアログを実際に表示します
                self.present(dialog, animated: true, completion: nil)
            }
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
                dontmove = false
                let defaults = UserDefaults.standard
                let today = Date()
                let dateFormatter = DateFormatter()
                
                print(monchecker2)
                
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "M", options: 0, locale: Locale(identifier: "ja_JP"))
                print(dateFormatter.string(from:today))
                let vc = segue.destination as! ViewController3
                
                if(flaga == 1){
                    // let defaults = UserDefaults.standard
                    //let vc = segue.destination as! ViewController3
                    let loadedMemoList4  = defaults.object(forKey: "sumtime")
                    if (loadedMemoList4 as? Int != nil) {
                        vc.showsumtimer = loadedMemoList4 as! Int
                    }
                    
                    if dateFormatter.string(from:today) != monchecker2&&nitiji2{
                        print("ミミみい耳耳いい耳耳みm")
                        changemonth = true
                        nitiji2 = false
                    }
                    else if dateFormatter.string(from:today) == monchecker2{
                        changemonth = true
                    }
                    
                    if dateFormatter.string(from:today) != monchecker2 /*&& changemonth*/{
                        let defaults5 = UserDefaults.standard
                         defaults5.set(vc.showsumtimer, forKey: "TUKIJIKANN")
                         print("今月初めての出勤だよぞおお")
                         print(vc.showsumtimer)
                         //timema = 0
                         if(bababaflag){
                         vc.showsumtimer = 0
                         bababaflag = false
                         print("ここは最初の処理")
                         }
                         else{
                         vc.showsumtimer = 0
                         vc.showsumtimer = timema
                         print("ここは最初以外の処理")
                         }
                         
                         let defaults6 = UserDefaults.standard
                         defaults6.set(vc.showsumtimer, forKey: "sumtime")
                         let defaults3 = UserDefaults.standard
                         defaults3.set(monchecker, forKey: "Month")
                         
                         
                         
                         
                         let loadedMemoList6  = defaults.object(forKey: "Month")
                         if (loadedMemoList6 as? String != nil) {
                         monchecker2 = loadedMemoList6 as! String
                         }
                         print(monchecker2)
                         changemonth = false
                    }
                    else{
                        //vc.showsumtimer += timema
                        
                        print("こっちになってるぞよ")
                        vc.showsumtimer += timema
                        
                        let defaults5 = UserDefaults.standard
                        defaults5.set(vc.showsumtimer, forKey: "sumtime")
                        let defaults6 = UserDefaults.standard
                        defaults6.set(vc.showsumtimer, forKey: "TUKIJIKANN")
                        let defaults12 = UserDefaults.standard
                        defaults12.set(showdate, forKey: "SHOWMonth")
                        print(vc.showsumtimer)
                    }
                    //timema = 0
                    flaga = 2;
                }
                
            }
        }


        

    @IBAction func reset(_ sender: Any) {
        taikinnbutton.isHidden = true
        shukkinnbutton.isHidden = false
        resetbutton.isHidden = true
        
        let defaults = UserDefaults.standard
        let defaults2 = UserDefaults.standard
        let defaults3 = UserDefaults.standard
        start_time.remove(at: start_time.count - 1)
        skememoLists.remove(at: skememoLists.count - 1)
        
        if end_time.count != start_time.count {
            print("あいうえお")
            end_time.remove(at: end_time.count - 1)
        }
        
        defaults.set(start_time, forKey: "MEMO_LIST")
        defaults2.set(skememoLists, forKey: "SKEMEMO_LIST")
        defaults3.set(end_time, forKey: "MEMO_LIST2")
        UserDefaults.standard.removeObject(forKey: "Hiduke")
        
        
        flag = false
        self.flaga = 0
        timema = 0
        
        mytimer.invalidate()
        mytimer2.invalidate()
        
        self.timesave.text = "\((self.timema/3600)%60)時間\((self.timema/60)%60)分\((self.timema)%60)秒"
        
    }
    
   
}

