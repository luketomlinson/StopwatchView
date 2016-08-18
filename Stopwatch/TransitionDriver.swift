//
//  TransitionDriver.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 8/17/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import Foundation
import UIKit

class TransitionDriver:NSObject {
    
    static var transitionDuration = 2.0
    
    var operation:UINavigationControllerOperation
    var transitionContext:UIViewControllerContextTransitioning
    var gestureRecognizer:UIPanGestureRecognizer
    
    var transitionAnimator:UIViewPropertyAnimator!
    var masterAnimator:TransitionAnimator
    
    init(operation:UINavigationControllerOperation, transitionContext:UIViewControllerContextTransitioning,gestureRecognizer:UIPanGestureRecognizer, animator:TransitionAnimator){
    
        self.operation = operation
        self.transitionContext = transitionContext
        self.gestureRecognizer = gestureRecognizer
        masterAnimator = animator
        super.init()
        
       
        
        gestureRecognizer.addTarget(self, action: #selector(pan))
        self.transitionContext.containerView.addGestureRecognizer(gestureRecognizer)
        setup()
    }
    func setup() {
        let toView = self.transitionContext.view(forKey: UITransitionContextViewKey.to)
        transitionContext.containerView.addSubview(toView!)
        toView?.alpha = 0.0
        setupAnimator({
            //            if(self.operation == .pop){
            //                let fromView = self.transitionContext.view(forKey: UITransitionContextViewKey.from)
            //                //fromView?.alpha = 0.0
            //                fromView?.backgroundColor = .orange
            //            }else if self.operation == .push {
            //                let toView = self.transitionContext.view(forKey: UITransitionContextViewKey.to)
            //                toView?.backgroundColor = .yellow
            //            }
            
            let fromView = self.transitionContext.view(forKey: UITransitionContextViewKey.from)
            
            fromView?.alpha = 0.0
            toView?.alpha = 1.0
            
            }, transitionComplete: nil)
        transitionAnimator.startAnimation()

    }
 
    
    func setupAnimator(_ animations:@escaping ()->(),transitionComplete:((UIViewAnimatingPosition)->())?){
        
        let springTiming = UISpringTimingParameters(dampingRatio: 0.4, initialVelocity: CGVector(dx:0.7,dy:0.7))
        transitionAnimator = UIViewPropertyAnimator(duration: TransitionDriver.transitionDuration, timingParameters: springTiming)
        
        transitionAnimator.addAnimations(animations)
        
        transitionAnimator.addCompletion { [unowned self] (position) in
            
            transitionComplete?(position)
            
            let completed = (position == .end)
            self.transitionContext.completeTransition(completed)
            
        }
        
    }
    
    func pan(_ gesture:UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            //masterAnimator.startInteractiveTransition(transitionContext)
//            masterAnimator.initiallyInteractive = true
            let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
//            let _ = fromView?.navigationController?.popViewController(animated: true)
            fromView?.dismiss(animated: true, completion: nil)
            return
        case .changed:
            
            let translation = gesture.translation(in: transitionContext.containerView)
            
            let percentComplete = transitionAnimator.fractionComplete + fabs(translation.x / transitionContext.containerView.bounds.width)
            print("Percent complete:\(percentComplete)")
            transitionAnimator.fractionComplete = percentComplete
            
            transitionContext.updateInteractiveTransition(percentComplete)
            
            //gesture.setTranslation(CGPoint.zero, in: transitionContext.containerView)
        case .ended,.cancelled:
            endInteraction()
        default:
            return
        }
    }
    
    func endInteraction() {
        guard transitionContext.isInteractive else {return}
        
        let position = completionPosition()
        
        if(position == .end){
            transitionContext.finishInteractiveTransition()
        }else {
            transitionContext.cancelInteractiveTransition()
        }
        
        //animate(position)
    }
    
    func animate(_ position:UIViewAnimatingPosition) {
        
        transitionAnimator.isReversed = (position == .start)
        
        if transitionAnimator.state == .inactive {
            transitionAnimator.startAnimation()
        }else {
            transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 1.0)
        }
    }
    func completionPosition() -> UIViewAnimatingPosition {
        return transitionAnimator.fractionComplete >= 0.5 ? .end : .start
    }
    
    
    
}
