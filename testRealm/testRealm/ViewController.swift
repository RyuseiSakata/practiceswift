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
        user.name = text1.text!
        user.age = Int(text2.text!)!
        try! realm.write {
            realm.add(user)
        }
        
        text1.text = ""
        text2.text = ""
        table.reloadData()
    }
}

