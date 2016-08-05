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
    var circle:UIView?
    lazy var animator:UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 2.0, curve: .linear, animations: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circle = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        guard let circle = circle else { return }
        circle.backgroundColor = UIColor.purple()
        circle.layer.cornerRadius = circle.bounds.width / 2.0
        view.addSubview(circle)
        animator.addAnimations {
            circle.center = self.view.center
        }
        animator.addAnimations {
            circle.transform = CGAffineTransform(scaleX: 2.0, y: 1.0)
        }
    
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if animator.isRunning {
            animator.pauseAnimation()
            button.setTitle("Start", for: .normal)
        } else{
            button.setTitle("Pause", for: .normal)
            animator.startAnimation()
        }
    }
}
