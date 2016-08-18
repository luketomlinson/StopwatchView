//
//  NavigationDelegate.swift
//  Stopwatch
//
//  Created by Luke Tomlinson on 8/16/16.
//  Copyright © 2016 Luke Tomlinson. All rights reserved.
//

import Foundation
import UIKit

//class Animator:NSObject,UIViewControllerAnimatedTransitioning {
//    
//    let duration = 1.0
//    var propertyAnimator:UIViewPropertyAnimator = {
//        
//        let springCurve = UISpringTimingParameters(dampingRatio: 0.2, initialVelocity: CGVector(dx:0.8,dy:0.8))
//        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: springCurve)
//        
//        animator.addAnimations {
//            self.myAnimateTransition(using: transitionContext)
//        }
//        
//        return animator
//    }()
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        self.interruptibleAnimator(using: transitionContext).startAnimation()
//    }
//    func myAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//       
//        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
//            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
//                return
//        }
//        
//        transitionContext.containerView.addSubview(toViewController.view)
//        toViewController.view.alpha = 0;
//        
//        
//        UIView.animate(withDuration: 1.0, animations: {
//            fromViewController.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//            toViewController.view.alpha = 1;
//            }, completion: { _ in
//        
//            fromViewController.view.transform = CGAffineTransform.identity
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
//    }
//    
//    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
//        
//        let springCurve = UISpringTimingParameters(dampingRatio: 0.2, initialVelocity: CGVector(dx:0.8,dy:0.8))
//        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: springCurve)
//        
//        animator.addAnimations {
//            self.myAnimateTransition(using: transitionContext)
//        }
//    
//        return animator
//    }
//}
//
//class NavigationDelegate: NSObject {
//    
//    @IBOutlet weak var navigationController:UINavigationController?
//    var interactionController:UIPercentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
//    var animator:UIViewControllerAnimatedTransitioning = Animator()
//    
//    override func awakeFromNib() {
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
//        navigationController?.view.addGestureRecognizer(panGesture)
//        interactionController.timingCurve = UISpringTimingParameters(dampingRatio: 0.2, initialVelocity: CGVector(dx: 0.7, dy: 0.7))
//    }
//    
//    func pan(recognizer:UIPanGestureRecognizer) {
//        
//        guard let navView = navigationController?.view else {return}
//        
//        switch recognizer.state {
//        case .began:
//            let location = recognizer.location(in: navView)
//            if location.x < navView.bounds.midX {
//                let _ = navigationController?.popViewController(animated: true)
//            }
//            self.interactionController.pause()
//        case .changed:
//            let translation = recognizer.translation(in: navView)
//            let offset = fabs(translation.x / navView.bounds.width)
//            self.interactionController.update(offset)
//        case .ended:
//            if recognizer.velocity(in: navView).x > 0.0 {
//                self.interactionController.finish()
//            } else {
//                self.interactionController.cancel()
//            }
//        default:
//            return
//        }    
//    }
//}
//
//extension NavigationDelegate: UINavigationControllerDelegate {
//    
//    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return self.interactionController
//    }
//    
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//        if operation == .pop {
//            return self.animator
//        }
//        return nil
//    }
//}
