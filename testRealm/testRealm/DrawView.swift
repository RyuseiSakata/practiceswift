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
            print(caldo())
            if(calrad() == 0.5||caldo() == 60){
                //ViewController2.image.isHidden = false
                flag = false
            }
            else{
                flag3 = false
            }
        }
        if(pointData.count == 4){
            
            line.move(to: CGPoint(x: pointData[0].x, y: pointData[0].y))
            line.addLine(to: CGPoint(x: pointData[1].x, y: pointData[1].y))
            line.addLine(to: CGPoint(x: pointData[2].x, y: pointData[2].y))
            line.addLine(to: CGPoint(x: pointData[0].x, y: pointData[0].y))
            line.close()
            UIColor.white.setStroke()
            line.lineWidth = 3.0
            line.stroke()
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
    func caldo() -> Int{
        let cos = calrad()
        var dosuu : Double
            
        dosuu = acos(cos)
        //print(dosuu)
        
        return Int(dosuu*(180/M_PI));
    }
    
    
    
    
}
