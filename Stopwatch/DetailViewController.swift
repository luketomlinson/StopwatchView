//
//  DetailViewController.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 8/16/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import UIKit



class DetailViewController: UIViewController {

    @IBOutlet weak var customView: UIView!
    
    var interactionController:UIPercentDrivenInteractiveTransition?
    lazy var animator:UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: nil)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let animator = TransitionAnimator()

        transitioningDelegate = animator
                //guard let animator = transitioningDelegate as? TransitionAnimator else {return}
        
        
        self.view.addGestureRecognizer(animator.gestureRecognizer)
        animator.gestureRecognizer.addTarget(self, action: #selector(pan))
        
        
    }
    
    func pan(gestureRecognizer:UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            dismiss(animated: true, completion: nil)
        default:
            return
        }
    }
}
