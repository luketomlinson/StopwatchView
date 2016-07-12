//
//  NeedleView.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 7/10/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import UIKit

class NeedleView:UIView{
    
    let lineWidth:CGFloat = 2.0
    var rotationPoint:CGPoint = CGPointZero
    let centerRadius:CGFloat = 4.0
    
    var secondaryLineLength:CGFloat {
        get{
            return 0.1 * bounds.size.height
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        let centerX = bounds.width / 2.0
        let centerY = bounds.width / 2.0
        
        let realCenter = CGPoint(x: centerX,y:centerY)
        
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: CGRectGetMidX(bounds), y: 0))
        path.addLineToPoint(CGPoint(x: realCenter.x, y: realCenter.y - (lineWidth + centerRadius)))
        path.lineWidth = lineWidth
        path.addArcWithCenter(realCenter, radius: centerRadius, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(2*M_PI), clockwise: true)
        path.moveToPoint(CGPoint(x: realCenter.x, y: realCenter.y + (centerRadius)))
        path.addLineToPoint(CGPoint(x: realCenter.x, y: realCenter.y + (lineWidth+centerRadius+secondaryLineLength)))
        //UIColor.orangeColor().setFill()
        UIColor.orangeColor().setStroke()
        //path.fill()
        path.stroke()
    }
    
    
}
