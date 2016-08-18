//
//  StopwatchView.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 7/9/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import UIKit

class StopwatchView:UIView{
    
    //MARK: - Properties
    let numLabels = 12
    
    let lineWidth:CGFloat = 2.0
    let lineLength:CGFloat = 4
    let granularity:Int = 4
    let increment = 5.0
    let labelInset:CGFloat = 35.0
    var needleView:NeedleView?
    
    private var labels:[UILabel] = []
    
   
    var labelDistance:CGFloat{
        get{
            return radius - (labelInset + lineLength)
        }
    }
    
    var radius:CGFloat{
        get{
            return bounds.width / 2.0
        }
    }
    var numTicks:CGFloat{
        get{
            return CGFloat(numLabels) * CGFloat(increment) * CGFloat(granularity)
        }
    }
    
    //MARK: - Initializers
    func commonInit(){
        addLabels()
        addNeedle()
        backgroundColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    //MARK: - Needle
    private func addNeedle(){
        let needle = NeedleView(frame:bounds)
        needleView = needle
        addSubview(needle)
    }
    
    private func layoutNeedle(){
        needleView?.frame = bounds
    }
    
    //MARK: - Labels
    private func addLabels(){
        
        for i in 0..<numLabels{
            let label = UILabel(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
            label.textColor = .white
            label.text = "\(Int(increment)*(i+1))"
            label.font = UIFont(name: "Helvetica-Bold", size: 28.0)
            label.textAlignment = .center
            labels.append(label)
            addSubview(label)
        }
        
    }
    private func layoutLabels(){
        
        let angle:CGFloat = CGFloat.pi / -3.0
        let totalRotationAngle = 2.0 * CGFloat.pi
        let rotationPerTick = totalRotationAngle/CGFloat(numLabels)
        
        for i in 0..<numLabels{
            let label = labels[i]
            let x = cos(angle + rotationPerTick * CGFloat(i)) * labelDistance
            let y = sin(angle + rotationPerTick * CGFloat(i)) * labelDistance
            
            let centerX = bounds.width / 2.0
            let centerY = bounds.width / 2.0
            
            let point = CGPoint(x: centerX + x, y: centerY + y)
            
            label.center = point
            label.textAlignment = .center
        }
    }

    
    //MARK: - Drawing
    override func draw(_ rect: CGRect) {
        drawLine(startAngle: 0.0, endAngle: 2.0 * CGFloat.pi)
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return
//        }
//        context.restoreGState()
    }
    
    
    private func drawLine(startAngle:CGFloat,endAngle:CGFloat){
        
        let r0 = bounds.width/2.0
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.saveGState()
        context.translateBy(x: r0,y: r0)
        
        for i in 1...Int(numTicks){
            
            context.saveGState()
            
            var r1:CGFloat
            
            if(i % granularity == 0){
                r1 = r0 - (2 * lineLength)
                
            }else{
                r1 = r0 - lineLength
            }
            
            if(i % (Int(increment)*granularity) == 0){
                context.setStrokeColor(UIColor.white.cgColor)
                r1 = r0 - (4 * lineLength)
            }else{
                context.setStrokeColor(UIColor.gray.cgColor)
            }
                        
            let startPoint = CGPoint(x:r0,y:0)
            let endPoint = CGPoint(x:r1, y: 0)
            
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            
            
            
            let totalRotationAngle = endAngle - startAngle
            let rotationPerTick = totalRotationAngle/numTicks
            
            
            let angleDelta = rotationPerTick * CGFloat(i) + startAngle
            
            context.rotate(by: angleDelta)
            
            path.stroke()
            path.fill()
            context.restoreGState()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLabels()
        layoutNeedle()
    }
    
}
