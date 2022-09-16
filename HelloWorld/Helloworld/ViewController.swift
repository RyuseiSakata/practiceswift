//
//  ViewController.swift
//  Helloworld
//
//  Created by 阪田竜生 on 2022/09/16.
//

import UIKit

class ViewController: UIViewController {

   // @IBOutlet weak var textField1: UILabel!
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = ""
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        let s = textField1.text ?? ""
        label1.text = "Hello ,\(s)!"
    }
    
}

