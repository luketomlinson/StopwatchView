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
    var rotationPoint:CGPoint = CGPoint.zero
    let centerRadius:CGFloat = 4.0
    
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
        backgroundColor = UIColor.clear()
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
        path.move(to: CGPoint(x: bounds.midX, y: 0))
        path.addLine(to: CGPoint(x: realCenter.x, y: realCenter.y - (lineWidth + centerRadius)))
        
        path.addArc(withCenter: realCenter, radius: centerRadius, startAngle: CGFloat.pi / 2.0, endAngle: 2.0 * CGFloat.pi, clockwise: true)
        path.move(to: CGPoint(x: realCenter.x, y: realCenter.y + (centerRadius)))
        path.addLine(to: CGPoint(x: realCenter.x, y: realCenter.y + (lineWidth+centerRadius+secondaryLineLength)))
        context.setStrokeColor(UIColor.orange().cgColor)
        path.stroke()
        
        context.restoreGState()
    }
    
    
}
