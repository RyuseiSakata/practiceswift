//
//  ViewController2.swift
//  ChangeScrean
//
//  Created by 阪田竜生 on 2022/09/16.
//

import UIKit

class ViewController2: UIViewController {

    var text : String = ""
    @IBOutlet weak var label1: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = text
    }

    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
