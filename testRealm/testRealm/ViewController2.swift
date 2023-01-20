//
//  ViewController2.swift
//  testRealm
//
//  Created by 阪田竜生 on 2023/01/13.
//

import UIKit
import RealmSwift

var flag : Bool = true
var flag2 : Bool = true
var flag3 : Bool = true
class ViewController2: UIViewController,UIGestureRecognizerDelegate {
    
    let pinchView = UIView()
    let realm = try! Realm()
    //var sucsess : Bool
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var rad: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var image: UIImageView!
    var draw = DrawView()
    var image1: UIImage!
    override func viewDidLoad() {
            super.viewDidLoad()
         draw = DrawView()
        image1 = UIImage(named:"IMG_3314 1")
        flag = true
        image.image = image1
        image.isHidden = flag
        text.isHidden = true
        text2.isHidden = true
           /* let drawView = DrawView(frame: self.view.bounds)
            self.view.addSubview(drawView)*/
            // MARK: - タップ
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
            self.view.addGestureRecognizer(tapGesture)

            // MARK: - 長押し
            let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTapped(_:)))
            self.view.addGestureRecognizer(longTapGesture)

            // MARK: - UIView
            /*pinchView.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.width / 2 , height: 100)
            pinchView.backgroundColor = .orange
            self.pinchView.center = self.view.center
            self.view.addSubview(pinchView)*/
            
            // MARK: - ピンチ
           /* let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinched(_:)))
            pinchView.addGestureRecognizer(pinchGesture)
            
            // MARK: - パン
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panSlide(_:)))
            pinchView.addGestureRecognizer(panGesture)*/
        }
        // MARK: - タップ
        @objc  func tapped(_ sender : UITapGestureRecognizer) {
            let drawView = DrawView(frame: self.view.bounds)
             self.view.addSubview(drawView)
            image.isHidden = flag
            text.isHidden = flag2
            
        }
    //ここでタッチされた座標を格納
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = Point();
        let pointData = realm.objects(Point.self)
        if let allTouches = event?.allTouches {
            for touch in allTouches {
                
                let location = touch.location(in: self.view) //一番親のビュー
                point.x = location.x
                point.y = location.y
                try! realm.write {
                    realm.add(point)
                }
                
            }
        }
        Swift.print(pointData)
        image.isHidden = flag
        if(flag){
            text2.isHidden = flag3
        }
        if(pointData.count == 3||pointData.count == 4){
            rad.text = String(draw.caldo())
            rad.layer.position.x = pointData[1].x + 2
            rad.layer.position.y = pointData[1].y
        }
        print(image.isHidden)
    }
        // MARK: - 長押し
        @objc  func longTapped(_ sender : UILongPressGestureRecognizer) {
            print("長押しされたよ")
        }
        // MARK: - ピンチ
       /* @objc  func pinched(_ sender: UIPinchGestureRecognizer) {
            self.pinchView.transform = self.pinchView.transform.scaledBy(x: sender.scale, y: sender.scale)
        }*/
        // MARK: - パン
    @IBAction func reset(_ sender: Any) {
        let pointData = realm.objects(Point.self)
        try! realm.write {
            realm.delete(pointData)
            
        }
        print("消去完了")
    }
    @IBAction func remove(_ sender: Any) {
        let pointData = realm.objects(Point.self)
        try! realm.write {
            realm.delete(pointData)
            
        }
        print("消去完了")
    }
    /*@objc  func panSlide(_ sender: UIPanGestureRecognizer) {
            self.pinchView.transform = CGAffineTransform(translationX: sender.translation(in: pinchView).x, y: sender.translation(in: pinchView).y)
        }*/
}
