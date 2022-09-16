//
//  ViewController.swift
//  ChangeScrean
//
//  Created by 阪田竜生 on 2022/09/16.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func shouldPerformSegue(
        withIdentifier identifier: String,
        sender: Any?) -> Bool {

        if identifier == "showView2" {
            if let text = textField.text,
                !text.trimmingCharacters(in: .whitespaces).isEmpty {
                return true
            }
        }

        return false
    }

    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?) {

        if segue.identifier == "showView2" {
            let vc = segue.destination as! ViewController3
            vc.text = textField.text ?? ""
        }
    }
}
