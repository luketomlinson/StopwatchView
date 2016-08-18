//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport




let containerFrame = CGRect(x: 0, y: 0, width: 400, height: 400)
let container = UIView(frame: containerFrame)
container.backgroundColor = .white

PlaygroundPage.current.liveView = container



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
        layoutNeedle()
        layoutLabels()
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
            print("added label \(i)")
            labels.append(label)
            print("added label \(i)")
            print(label)
            addSubview(label)
        }
        
    }
    private func layoutLabels(){
        
        let angle:CGFloat = CGFloat.pi / -3.0
        let totalRotationAngle = 2.0 * CGFloat.pi
        let rotationPerTick = totalRotationAngle/CGFloat(numLabels)
        
        print (labels.count)
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
    

    override func draw(_ rect: CGRect) {
        drawLines(startAngle: 0.0, endAngle: 2.0 * CGFloat.pi)
    }
    
    private func drawLines(startAngle:CGFloat,endAngle:CGFloat){
        
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
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layoutLabels()
//        layoutNeedle()
//    }
    
}

class NeedleView:UIView{
    
    let lineWidth:CGFloat = 2.0
    var rotationPoint:CGPoint = CGPoint.zero
    let centerRadius:CGFloat = 5.0
    
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
        print("drawing")

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



let insets = UIEdgeInsetsMake(0, 0, 0, 0)
let sFrame = UIEdgeInsetsInsetRect(containerFrame, insets)

let sw = StopwatchView(frame:containerFrame)
container.addSubview(sw)

