//
//  TimingViewController.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 8/5/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import UIKit

class TimingViewController: UIViewController {

    @IBOutlet weak var button: UIButton! {
        didSet{
            button.setTitle("Start", for: .normal)
        }
    }
    var wasRunning = false
    var firstTime = true
    var offset:CGPoint = .zero
    var circle:UIView?
    
    var circleCenter:CGPoint = .zero
    
    
    lazy var animator:UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 4.0, curve: .linear, animations: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circle = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        guard let circle = circle else { return }
        circle.backgroundColor = .purple
        circle.layer.cornerRadius = circle.bounds.width / 2.0
        view.addSubview(circle)
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(move))
        circle.addGestureRecognizer(recognizer)
        reset()
    }
    
    @IBAction func resetPressed(_ sender: AnyObject) {
        reset()
    }
    func reset() {
        firstTime = true
        circle?.transform = CGAffineTransform.identity
        button.setTitle("Start", for: .normal)
        circle?.center = CGPoint(x: 100, y: 100)
        if(animator.isRunning){
            animator.stopAnimation(true)
        }
        animator.addAnimations {
            self.circle?.center = self.view.center
        }
        animator.addAnimations {
            self.circle?.transform = CGAffineTransform(scaleX: 2.0, y: 1.0)
        }
        animator.addCompletion { _  in
            self.button.setTitle("Start", for: .normal)
        }
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let title = button.titleLabel?.text == "Pause" ? "Start" : "Pause"
        button.setTitle(title, for: .normal)
        if firstTime && animator.state == .inactive {
            animator.startAnimation()
            firstTime = false
            return
        }
        
        if animator.isRunning {
            animator.pauseAnimation()
        } else{
            let springTiming = UISpringTimingParameters(dampingRatio: 0.2, initialVelocity: CGVector(dx: 0.8, dy: 0.8))
            animator.continueAnimation(withTimingParameters: springTiming, durationFactor: 1.0)
        }
    }

    func move(recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            if animator.isRunning {
                wasRunning = true
                animator.pauseAnimation()
                circleCenter =  circle!.center
            }else{
            }
        case .changed:
            let translation = recognizer.translation(in: self.view)
            circle?.center = CGPoint(x: circleCenter.x + translation.x, y: circleCenter.y + translation.y)
        case .ended:
            circleCenter =  circle!.center
            if wasRunning {
                let springTiming = UISpringTimingParameters(dampingRatio: 0.1, initialVelocity: CGVector(dx: 0.8, dy: 0.8))
                animator.continueAnimation(withTimingParameters: springTiming, durationFactor: 1.0)
                wasRunning = false
            } else {
                animator.startAnimation()
            }
        default:
            return
        }
        
    }

}
