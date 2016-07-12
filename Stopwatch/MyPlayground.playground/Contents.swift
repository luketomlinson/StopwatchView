//: Playground - noun: a place where people can play

import UIKit
import XCPlayground





let containerFrame = CGRect(x: 0, y: 0, width: 400, height: 400)
let container = UIView(frame: containerFrame)
container.backgroundColor = UIColor.whiteColor()

XCPlaygroundPage.currentPage.liveView = container



class StopwatchView:UIView{
    
    let numLabels = 12
    var numTicks:CGFloat{
        get{
            return CGFloat(numLabels) * CGFloat(increment) * CGFloat(granularity)
        }
    }
    let lineWidth:CGFloat = 2.0
    let lineLength:CGFloat = 4
    let granularity:Int = 4
    
    let labelInset:CGFloat = 35.0
    
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
    
    let increment = 5.0
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        
//        let label = UILabel(frame: frame)
//        addSubview(label)
//        
//        
//    }

    override init(frame: CGRect) {
        super.init(frame:frame)
//        let label = UILabel(frame: frame)
//        label.text = "hello there"
//        label.textColor = UIColor.whiteColor()
//        //addSubview(label)
//
        addLabels()
        addNeedle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addNeedle(){
        let needle = NeedleView(frame:frame)
        needle.backgroundColor = UIColor.clearColor()
        addSubview(needle)
    }
    private func addLabels(){
        
        print("Bounds\(bounds)")
        print("Frame\(frame)")
        let angle:CGFloat = CGFloat(-M_PI / 3.0)
        let totalRotationAngle = CGFloat(2.0 * M_PI)
        let rotationPerTick = totalRotationAngle/CGFloat(numLabels)
        
        for i in 0..<numLabels{
            let label = UILabel(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
            label.textColor = UIColor.whiteColor()
            label.text = "\(Int(increment)*(i+1))"
            label.font = UIFont(name: "Helvetica-Bold", size: 28.0)
            
            //print(labelDistance)
            let x = cos(angle + rotationPerTick * CGFloat(i)) * labelDistance
            let y = sin(angle + rotationPerTick * CGFloat(i)) * labelDistance
            print("x:\(x)")
            print("y:\(y)")
            //print("Center:\(center)")
            print("Text: " + label.text!)
            let point = CGPoint(x: center.x + x, y: center.y + y)
            print("Point:\(point)")
            print(label.frame)
            
            label.center = point
            //label.backgroundColor = UIColor.yellowColor()
            label.textAlignment = .Center
            addSubview(label)

            print("----------")
            
        }
        
    }   
    
    override func drawRect(rect: CGRect) {
       // drawNeedle()
        drawLine(0.0, endAngle: CGFloat(2.0*M_PI))
    }
    
    
    private func drawLine(startAngle:CGFloat,endAngle:CGFloat){
    
        let r0 = bounds.width/2.0
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context,r0,r0)
        
        for i in 1...Int(numTicks){

            CGContextSaveGState(context)

            var r1:CGFloat
            
            if(i % granularity == 0){
                r1 = r0 - (2 * lineLength)
                
            }else{
                r1 = r0 - lineLength
            }
            
            if(i % (Int(increment)*granularity) == 0){
                UIColor.whiteColor().setStroke()
                r1 = r0 - (4 * lineLength)
            }else{
                UIColor.grayColor().setStroke()
            }
            
            
            
            let startPoint = CGPoint(x:r0,y:0)
            let endPoint = CGPoint(x:r1, y: 0)
            
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            path.moveToPoint(startPoint)
            path.addLineToPoint(endPoint)
            
            
            
            let totalRotationAngle = endAngle - startAngle
            let rotationPerTick = totalRotationAngle/numTicks
            
            
            let angleDelta = rotationPerTick * CGFloat(i) + startAngle
            //print("Angle delta:\(angleDelta)")
            
            CGContextRotateCTM(context, angleDelta)
            
            path.stroke()
            path.fill()
            CGContextRestoreGState(context)
        }
        
    }
    
}
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


let insets = UIEdgeInsetsMake(0, 0, 0, 0)
let sFrame = UIEdgeInsetsInsetRect(containerFrame, insets)
let s = StopwatchView(frame: sFrame)
s.backgroundColor = UIColor.blackColor()

container.addSubview(s)

