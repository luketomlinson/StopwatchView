//
//  ViewController.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 7/9/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var fullButton: UIButton!{
        didSet{
            fullButton.tintColor = .orange
        }
    }
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
        view.backgroundColor = .black
        startStopButton.tintColor = .orange
        slider.tintColor = .orange
        resetButton.tintColor = .orange
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
            
            let parameters = UISpringTimingParameters(dampingRatio: 0.2, initialVelocity: CGVector(dx: 0.8, dy: 0.8))
            animator.continueAnimation(withTimingParameters: parameters, durationFactor: 1-animator.fractionComplete)
            startStopButton.setTitle("Pause", for: [])
        }
        else if(animator.isRunning){
            animator.pauseAnimation()
            startStopButton.setTitle("Start", for: [])
        }
        
    }
    
    @IBAction func resetPressed(_ sender: AnyObject) {
        animator.stopAnimation(true)
        startStopButton.setTitle("Start", for: [])
        stopwatchView.needleView?.transform = CGAffineTransform.identity
        first = true
        stopwatchView.needleView?.layer.removeAllAnimations()
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
    @IBAction func fullButtonPressed(_ sender: AnyObject) {
        
        animator.stopAnimation(true)
        stopwatchView.needleView?.transform = CGAffineTransform.identity
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 60.0
        animation.byValue = 2.0 * CGFloat(M_PI)
        stopwatchView.needleView?.layer.add(animation, forKey: "rotationAnimation")

    }
}

