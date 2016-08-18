//
//  TransitionAnimator.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 8/17/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import Foundation
import  UIKit

class TransitionAnimator: NSObject {
    
    
    let duration = 1.0
    let gestureRecognizer = UIPanGestureRecognizer()
    var operation:UINavigationControllerOperation = .none
    var initiallyInteractive = false
    var transitionDriver:TransitionDriver!
}

extension TransitionAnimator:UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.operation = operation
        return self
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }
    
}

extension TransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return transitionDriver.transitionAnimator
    }
}

extension TransitionAnimator: UIViewControllerInteractiveTransitioning {
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        transitionDriver =  TransitionDriver(operation: self.operation, transitionContext: transitionContext, gestureRecognizer: gestureRecognizer,animator:self)
    }
    
    var wantsInteractiveStart: Bool {
        
        return true
    }
}

extension TransitionAnimator: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }
}
