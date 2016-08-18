//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport

class GaugeLayer:CAShapeLayer{
    
    var lineW:CGFloat = 2.0
    var lineColor = UIColor.blue
    var padding:CGFloat = 5.0
    var segmentWidth:CGFloat = 80.0
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        let path = UIBezierPath(arcCenter: CGPoint(x:bounds.midX,y:bounds.maxY - padding), radius: bounds.width / 2.0 - padding, startAngle: 0.0, endAngle: CGFloat.pi, clockwise: false)
        
        path.lineWidth = lineW
        
        path.addArc(withCenter: CGPoint(x:bounds.midX,y:bounds.maxY - padding), radius: bounds.width / 2.0 - padding - segmentWidth, startAngle: CGFloat.pi, endAngle: 0.0, clockwise: true)
        
        path.addLine(to: CGPoint(x: bounds.maxX - padding , y: bounds.maxY - padding))
        
        path.fill()
        
        path.stroke()
        
        self.path = path.cgPath
    }
    
    
    
}


class Gauge:UIView{
    
    var lineWidth:CGFloat = 2.0
    var lineColor = UIColor.blue
    var padding:CGFloat = 5.0
    var segmentWidth:CGFloat = 80.0
    
    var gaugeLayer:GaugeLayer
    
    
    override init(frame: CGRect) {
        gaugeLayer = GaugeLayer()
        super.init(frame: frame)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        gaugeLayer = GaugeLayer()
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clear
        self.layer.addSublayer(gaugeLayer)
    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return
//        }
//        
//        context.setStrokeColor(lineColor.cgColor)
//        context.setFillColor(lineColor.cgColor)
//        
//        print(bounds.width)
//        let path = UIBezierPath(arcCenter: CGPoint(x:bounds.midX,y:bounds.maxY - padding), radius: bounds.width / 2.0 - padding, startAngle: 0.0, endAngle: CGFloat.pi, clockwise: false)
//        
//        path.lineWidth = lineWidth
//        
//        path.addArc(withCenter: CGPoint(x:bounds.midX,y:bounds.maxY - padding), radius: bounds.width / 2.0 - padding - segmentWidth, startAngle: CGFloat.pi, endAngle: 0.0, clockwise: true)
//        
//        path.addLine(to: CGPoint(x: bounds.maxX - padding , y: bounds.maxY - padding))
//        
//        path.fill()
//        
//        path.stroke()
//        
//        
//    }
    
}



let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 800, height: 400))
containerView.backgroundColor = UIColor.gray

let gaugeFrame = UIEdgeInsetsInsetRect(containerView.frame, UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0))

print(gaugeFrame)

let gauge = Gauge(frame: gaugeFrame)
containerView.addSubview(gauge)

PlaygroundPage.current.liveView = containerView





let context = UIGraphicsGetCurrentContext()
context?.setStrokeColor(UIColor.blue.cgColor)




