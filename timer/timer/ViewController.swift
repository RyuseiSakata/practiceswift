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
    var skememoLists: [String] = []
    var timema :Int = 0
    /*let date = Date()
    //日本時間を表示
    let formatterJP = DateFormatter()*/
    var timechecker :String = ""
    var skechecker :String = ""
    
    var mytimer = Timer()
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
    
        //timesave.text =
        mytimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.timema = self.timema+1
            self.timesave.text = "\(self.timema/3600)時間\(self.timema/60)分\(self.timema)秒"
                })
    }
    
    @IBAction func input(_ sender: Any) {
        applyMemo()
        hour = Calendar.current.component(.hour, from: Date())
        minute = Calendar.current.component(.minute, from: Date())
        second = Calendar.current.component(.second, from: Date())
    }
    
    @IBAction func clear(_ sender: Any) {
        /*hour = Calendar.current.component(.hour, from: Date())
        minute = Calendar.current.component(.minute, from: Date())
        second = Calendar.current.component(.second, from: Date())*/
        
        
    }
    
    
    //ここで画面遷移処理
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?) {

        if segue.identifier == "showView2" {
            let vc = segue.destination as! ViewController3
            vc.newmemoLists.append(timechecker)
            
            let vc2 = segue.destination as! ViewController3
            vc.eventsDate.append(skechecker)
        }
    }
    
    
}

