//
//  ViewController.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 7/9/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stopwatchView: StopwatchView!
    @IBOutlet weak var startStopButton: UIButton!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayColor()
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(stopwatchView.layoutMargins)
    }
    @IBAction func buttonPressed(sender: UIButton) {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 60.0
        //animation.fromValue = 0.0
        animation.byValue = 2.0 * CGFloat(M_PI)
        stopwatchView.needleView?.layer.addAnimation(animation, forKey: "rotation animation")
        
    }
}

