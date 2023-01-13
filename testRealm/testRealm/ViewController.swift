//
//  ViewController.swift
//  testRealm
//
//  Created by 阪田竜生 on 2022/12/26.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource  {
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var table: UITableView!
    
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        text1.text = "名前を入力してください"
        text2.text = "年齢を入力してください"
        
        let userData = realm.objects(User.self)
        print("🟥全てのデータ\(userData)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userData = realm.objects(User.self)
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let userData = realm.objects(User.self)
        cell.textLabel!.text = "\(userData[indexPath.row].name)さん"
        cell.detailTextLabel!.text = String("\(userData[indexPath.row].age)歳")
        return cell
    }

    @IBAction func add(_ sender: Any) {
        
        let user = User()
        if((text1.text != ""&&text2.text != "")&&(text1.text != "名前を入力してください"&&text2.text != "年齢を入力してください")){
            user.name = text1.text!
            user.age = Int(text2.text!)!
            try! realm.write {
                realm.add(user)
            }
        }
        text1.text = ""
        text2.text = ""
        text1.endEditing(true)
        text2.endEditing(true)
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath) {
            // 先にデータを削除しないと、エラーが発生する。
        let user = User()
        let userData = realm.objects(User.self)
            
        
        // ② 削除したいデータを検索する
        user.name = userData[indexPath.row].name
        
        // ③ 部署を更新する
        do{
          try realm.write{
            realm.delete(userData[indexPath.row])
          }
        }catch {
          print("Error \(error)")
        }
            //データを削除
           
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //self.saveTextlist()
        }
    
    func saveTextlist() {
        do {
            //try context.save()
    } catch {
    print("Error saving Item \(error)")
   }
  }
}

