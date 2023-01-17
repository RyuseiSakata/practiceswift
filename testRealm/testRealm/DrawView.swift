//
//  DrawView.swift
//  testRealm
//
//  Created by 阪田竜生 on 2023/01/17.
//

import Foundation
import UIKit
import RealmSwift

class DrawView :UIView {
    
    let realm = try! Realm()
    override init (frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    //var sucsess : Bool
    required init? (coder aDecoder: NSCoder ){
        fatalError("okasiid")
    }
    
    override func draw(_ rect: CGRect){
        let line = UIBezierPath()
        let pointData = realm.objects(Point.self)
        if(pointData.count == 2){
            flag2 = false;
        }
        if(pointData.count == 3){
            line.move(to: CGPoint(x: pointData[0].x, y: pointData[0].y))
            line.addLine(to: CGPoint(x: pointData[1].x, y: pointData[1].y))
            line.addLine(to: CGPoint(x: pointData[2].x, y: pointData[2].y))
            line.addLine(to: CGPoint(x: pointData[0].x, y: pointData[0].y))
            line.close()
            UIColor.gray.setStroke()
            line.lineWidth = 2.0
            line.stroke()
            //flag = false
            flag2 = true
            if(calrad() == 0.5){
                //ViewController2.image.isHidden = false
                flag = false
            }
            else{
                flag3 = false
            }
        }
        if(pointData.count == 4){
            
            let rectangle = UIBezierPath(rect: CGRect(x: 0, y: 200, width: 1000, height: 600))
            // 内側の色
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).setFill()
            // 内側を塗りつぶす
            rectangle.fill()
            // 線の色
            UIColor(red: 0, green: 0, blue: 0, alpha: 100.0).setStroke()
            // 線の太さ
            rectangle.lineWidth = 2.0
            // 線を塗りつぶす
            rectangle.stroke()
            flag3 = true
            try! realm.write {
                realm.delete(pointData)
            }
            print("消去完了")
        }
    }
    
    func calrad() -> Double{
        let pointData = realm.objects(Point.self)
        let cos = (callength(x: pointData[0].x, y: pointData[0].y, x2: pointData[1].x, y2: pointData[1].y)*callength(x: pointData[0].x, y: pointData[0].y, x2: pointData[1].x, y2: pointData[1].y) + callength(x: pointData[1].x, y: pointData[1].y, x2: pointData[2].x, y2: pointData[2].y)*callength(x: pointData[1].x, y: pointData[1].y, x2: pointData[2].x, y2: pointData[2].y) - callength(x: pointData[0].x, y: pointData[0].y, x2: pointData[2].x, y2: pointData[2].y)*callength(x: pointData[0].x, y: pointData[0].y, x2: pointData[2].x, y2: pointData[2].y))/(2*callength(x: pointData[0].x, y: pointData[0].y, x2: pointData[1].x, y2: pointData[1].y)*callength(x: pointData[2].x, y: pointData[2].y, x2: pointData[1].x, y2: pointData[1].y))
        print(cos)
        return cos
    }
    
    func callength(x :Double,y :Double,x2 :Double, y2:Double) -> Double{
        let xpoint = x - x2
        let ypoint = y - y2
        let length = xpoint*xpoint + ypoint*ypoint
        
        return sqrt(length)
    }
    
    
    
}
