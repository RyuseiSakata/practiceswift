//
//  DrawView.swift
//  DrawScrean
//
//  Created by 阪田竜生 on 2022/09/21.
//
import UIKit

class DrawView: UIView {
    
    var currentDrawing: Drawing?
    var finishedDrawings = [Drawing]() //Drawingリストに追加する
    var currentColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        for drawing in finishedDrawings {
            drawing.color.setStroke()
            stroke(drawing: drawing)
        }
        
        if let drawing = currentDrawing {
            drawing.color.setStroke()
            stroke(drawing: drawing)
        }
    }
    
    /*UIviewがタッチされたら新しいインスタンスが作成される*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        currentDrawing = Drawing()
        currentDrawing?.color = currentColor
        currentDrawing?.points.append(location)
        setNeedsDisplay()
    }
    
    /*移動に合わせてタッチされてる間座標が追加される*/
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
                
        currentDrawing?.points.append(location)
        
        setNeedsDisplay()
    }
    
    /*ここが呼び出されることによってfinish Drawingリストが呼び出される*/
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if var drawing = currentDrawing {
            let touch = touches.first!
            let location = touch.location(in: self)
            drawing.points.append(location)
            finishedDrawings.append(drawing)
        }
        currentDrawing = nil
        setNeedsDisplay()
    }
    
    func clear() {
        finishedDrawings.removeAll()
        setNeedsDisplay()
    }
    
    func undo() {
        if finishedDrawings.count == 0 {
            return
        }
        finishedDrawings.remove(at: finishedDrawings.count - 1)
        setNeedsDisplay()
    }
    
    func setDrawingColor(color : UIColor){
        currentColor = color
    }
    
    
    /*drawingオブジェクトを受け取って描画するメソッド*/
    func stroke(drawing: Drawing) {
        let path = UIBezierPath()//これが描画には必要
        path.lineWidth = 10.0
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        let begin = drawing.points[0];
        path.move(to: begin)//ここで起点を作成
        
        if drawing.points.count > 1 {
            for i in 1...(drawing.points.count - 1) {
                let end = drawing.points[i]
                path.addLine(to: end)//ここで帰着点を作成し続ける
            }
        }
        path.stroke()//ここで点と点を結んで描画する
    }
}
