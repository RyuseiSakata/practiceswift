//
//  ViewController.swift
//  DrawScrean
//
//  Created by 阪田竜生 on 2022/09/21.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var drawView: DrawView!
    
    @IBOutlet weak var segmentedC: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedC.selectedSegmentIndex = 0
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        drawView.clear()
    }
    
    @IBAction func undoTapped(_ sender: Any) {
        drawView.undo()
    }
    @IBAction func colorchanged(_ sender: Any) {
        var c = UIColor.black
        switch segmentedC.selectedSegmentIndex{
        case 1:
            c = UIColor.blue
            break
        case 2:
            c = UIColor.red
            break
            
        default:
            break
        }
        drawView.setDrawingColor(color: c)
    }
    
    
    
}

