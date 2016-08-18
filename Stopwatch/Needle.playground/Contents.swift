//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport


let view = UIView(frame: CGRect(x: 0, y: 0, width: 700, height: 700))
view.backgroundColor = UIColor.white

PlaygroundPage.current.liveView = view

class NeedleView:UIView{
    
    let lineWidth:CGFloat = 4.0
    var rotationPoint:CGPoint = CGPoint.zero
    let centerRadius:CGFloat = 20.0
    
    var secondaryLineLength:CGFloat {
        get{
            return 0.1 * bounds.size.height
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    func commonInit(){
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.saveGState()
        
        let centerX = bounds.width / 2.0
        let centerY = bounds.width / 2.0
        
        let realCenter = CGPoint(x: centerX,y:centerY)
        
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        //top middle
        path.move(to: CGPoint(x: bounds.midX, y: 0))
        
        let y = realCenter.y - (lineWidth + centerRadius)
        path.addLine(to: CGPoint(x: realCenter.x, y: y))
        
        path.addArc(withCenter: realCenter, radius: centerRadius, startAngle: 3.0 * CGFloat.pi / 2.0, endAngle: 3.5 * CGFloat.pi, clockwise: true)
        
        
        path.move(to: CGPoint(x: realCenter.x, y: realCenter.y + (centerRadius)))
        path.addLine(to: CGPoint(x: realCenter.x, y: realCenter.y + (lineWidth+centerRadius+secondaryLineLength)))
        context.setStrokeColor(UIColor.orange.cgColor)
        path.stroke()
        
        context.restoreGState()
    }
    
    
}


let nView = NeedleView(frame: view.frame)

view.addSubview(nView)

//func rotate(transform: CGAffineTransform = CGAffineTransform.identity) {
//    let newTransform = transform.rotated(by: CGFloat(M_PI) / 4.0)
//    
//    UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveLinear], animations: {
//        
//        nView.transform = newTransform
//        
//        }, completion: { complete in
//            rotate(transform: newTransform)
//        })
//    
//}
//
//rotate()
