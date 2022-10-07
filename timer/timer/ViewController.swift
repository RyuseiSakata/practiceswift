//
//  ViewController.swift
//  timer
//
//  Created by 阪田竜生 on 2022/09/21.
//

import UIKit

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
    /*let date = Date()
    //日本時間を表示
    let formatterJP = DateFormatter()*/
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
            //
           /* hour = loadedMemoList as! Int/3600
            minute = loadedMemoList as! Int/60
            second = hour*3600 - minute*60
            
            timesave.text = "\(hour) \(minute) \(second-1)"*/
            memoLists = loadedMemoList as! [String]
           /* hour = memoList[0]/3600
            minute = (memoList[0] - hour*3600)/60
            second = memoList[0] - hour*3600 - minute*60 */
            //timesave.text = "\(memoLists[0])"
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
            self.timesave.text = "\(self.timema/3600)時間\((self.timema/60)%60)分\((self.timema)%60)秒"
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
        if flag == false{
            applyMemo()
            
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
            let vc = segue.destination as! ViewController3
            vc.newmemoLists.append(timechecker)
            
            _ = segue.destination as! ViewController3
            vc.eventsDate.append(skechecker)
             
            _ = segue.destination as! ViewController3
            vc.newmemoLists2.append(timechecker)
            
           
                _ = segue.destination as! ViewController3
                vc.showsumtimer += timema
            
        }
    }
    
    
}

