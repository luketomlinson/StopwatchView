//: Playground - noun: a place where people can play

import UIKit
import XCPlayground


let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
view.backgroundColor = UIColor.whiteColor()

XCPlaygroundPage.currentPage.liveView = view


class NeedleView:UIView{
    
    let lineWidth:CGFloat = 2.0
    var rotationPoint:CGPoint = CGPointZero
    let centerRadius:CGFloat = 4.0
    var secondaryLineLength:CGFloat {
        get{
            return 0.1 * bounds.size.height
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: CGRectGetMidX(bounds), y: 0))
        path.addLineToPoint(CGPoint(x: center.x, y: center.y - (lineWidth + centerRadius)))
        path.lineWidth = lineWidth
        path.addArcWithCenter(center, radius: centerRadius, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(2*M_PI), clockwise: true)
        path.moveToPoint(CGPoint(x: center.x, y: center.y + (centerRadius)))
        path.addLineToPoint(CGPoint(x: center.x, y: center.y + (lineWidth+centerRadius+secondaryLineLength)))
        //UIColor.orangeColor().setFill()
        UIColor.orangeColor().setStroke()
        //path.fill()
        path.stroke()
    }
    
    
}


let nView = NeedleView(frame: view.frame)

view.addSubview(nView)