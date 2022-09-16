//
//  ViewController.swift
//  targetandaction
//
//  Created by 阪田竜生 on 2022/09/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let lightGray = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)

        let button = UIButton(type: .roundedRect)
        button.backgroundColor = lightGray
        button.addTarget(
          self,
          action: #selector(buttonTapped(_:forEvent:)),
          for: .touchUpInside)
        button.setTitle("Button1", for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)

        view.addSubview(button)
    }

    @objc func buttonTapped(){
        print("buttonTapped called")
    }

    @objc func buttonTapped(_ sender: UIButton){
        print("buttonTapped(_:) called")
        printType(sender)
    }

    @objc func buttonTapped(_ sender: UIButton, forEvent event: UIEvent){
        print("buttonTapped(_:forEvent:) called")
        printType(sender)
        printType(event)
        print("ここが呼ばれた")
    }

    func printType(_ obj: Any?) {
        var s = ""
        if let o = obj {
            s = String(describing: o)
        } else {
            s = "null"
        }
        print("- type = \(s)")
    }
}
