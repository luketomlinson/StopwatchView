//
//  ViewController.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 7/9/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var stopwatchView: StopwatchView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    lazy var animator:UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 6.0, curve: .linear, animations: nil)
    }()
    
    var first:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black()
        startStopButton.tintColor = UIColor.orange()
        slider.tintColor = UIColor.orange()
        resetButton.tintColor = UIColor.orange()
        slider.value = 0.0
    }

    @IBAction func buttonPressed(sender: UIButton) {
        
        
        if(first){
            animator.addAnimations({
                self.stopwatchView.needleView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            })
            
            animator.startAnimation()
            slider.setValue(1.0, animated: true)
            first = false
            startStopButton.setTitle("Pause", for: [])
        }
        else if(!animator.isRunning){
            animator.startAnimation()
            startStopButton.setTitle("Pause", for: [])
        }
        else{
            animator.pauseAnimation()
            startStopButton.setTitle("Start", for: [])
        }
//        let animation = CABasicAnimation(keyPath: "transform.rotation")
//        animation.duration = 60.0
//        animation.byValue = 2.0 * CGFloat(M_PI)
//        stopwatchView.needleView?.layer.add(animation, forKey: "rotation animation")
        
        
        
    }
    
    @IBAction func resetPressed(_ sender: AnyObject) {
        animator.stopAnimation(true)
        startStopButton.setTitle("Start", for: [])
        first = true
    }
    @IBAction func sliderInteractionBegin(_ sender: UISlider) {
        print("SLider begin")
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    @IBAction func sliderInteractionEnd(_ sender: UISlider) {
        print("Slider end")
    }
    
    @IBAction func touchBegan(_ sender: UISlider) {
        print("touch began")
        animator.pauseAnimation()
    }
    @IBAction func touchEnded(_ sender: AnyObject) {
        print("touch ended")
        
        animator.continueAnimation(withTimingParameters: nil, durationFactor: 1.0*(1-animator.fractionComplete))
        
    }
}

