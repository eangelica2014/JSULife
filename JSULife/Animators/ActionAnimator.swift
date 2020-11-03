//
//  ActionAnimator.swift
//  JSULife
//
//  Created by Asaad on 11/2/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class ActionAnimator: UIViewController, UIGestureRecognizerDelegate {
    var SheetFunctions: Functions!

    var runningAnimators = [UIViewPropertyAnimator]()
    var animator: UIViewPropertyAnimator?
    var progressWhenInterrupted: CGFloat = 0 //Saves any relative progress made by the animator, prior to it being interrupted.
    let duration = 0.55 as Double

    enum State {
        case Expanded
        case Collapsed
    }
    
    var isVisible: Bool = true
    var state: State {
        return isVisible ? .Expanded : .Collapsed
    }
    
    var panningRightWhenBegan: Bool!
    var panningRightWhenChanged: Bool!
    var panningRightOnRelease: Bool?
    var shouldIgnoreRemainingPans = false
    func setPanDirection(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            if sender.velocity(in: self.view).x > 0 {
                panningRightWhenBegan = true
            } else {
                panningRightWhenBegan = false
            }
        case .changed:
            if sender.velocity(in: self.view).x > 0 {
                panningRightWhenChanged = true
            } else {
                panningRightWhenChanged = false
            }

        case .ended:
            ()
        default:
            ()
        }
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        guard shouldIgnoreRemainingPans == false else { return }
        switch sender.state {
        case .began:
            setPanDirection(sender)
            if (state == .Collapsed && panningRightWhenBegan != true && runningAnimators.isEmpty) || (state == .Expanded && panningRightWhenBegan == true && runningAnimators.isEmpty) {
                return
            }
            startInteractiveTransition(state: state, duration: duration)
        case .changed:
            setPanDirection(sender)
            let translation = sender.translation(in: self.view)
            var fractionComplete = translation.x / (self.view.bounds.width - 60)
            //guard fractionComplete < 0.1 else { return }
            fractionComplete = isVisible ? -fractionComplete : fractionComplete
            updateInteractiveTransition(fractionComplete: fractionComplete)
        case .ended:
            //When the finger lifts, continue the animation
            var shouldReverse = false
            if panningRightWhenChanged != panningRightWhenBegan {
                shouldReverse = true
            }
            if let panningRightOnRelease = panningRightOnRelease {
                if panningRightOnRelease != panningRightWhenChanged {
                    print("C")
                    shouldReverse = true
                    self.panningRightOnRelease = !self.panningRightOnRelease!
                    continueInteractiveTransition(cancel: false, shouldReverse: shouldReverse)
                    shouldIgnoreRemainingPans = true
                } else {
                    print("D")
                    shouldReverse = false
                    continueInteractiveTransition(cancel: false, shouldReverse: shouldReverse)
                    shouldIgnoreRemainingPans = true
                }
            } else {
                print("B")
                continueInteractiveTransition(cancel: false, shouldReverse: shouldReverse)
            }
        default:
            ()
        }
    }
    
    //Initiates transition if it isn't running, pauses all animators uniformly, saves relative progress made by animators. Called when pan .begins
    func startInteractiveTransition(state: State, duration: TimeInterval) {
        if runningAnimators.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimators {
            animator.pauseAnimation()
            progressWhenInterrupted = animator.fractionComplete
        }
    }
    
    //Custom method: Initiates transition, if it isn't already running. Takes a target state to animate to.
    func animateTransitionIfNeeded(state: State, duration: TimeInterval) {
        var frameAnimator_1 = UIViewPropertyAnimator()
        var labelAnimator_1 = UIViewPropertyAnimator()
        switch state {
        case .Expanded:
            frameAnimator_1 = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
                self.SheetFunctions.pages[0].sheetContainer.frame = self.SheetFunctions.pages[0].sheetContainer.frame.offsetBy(dx: -(self.SheetFunctions.pages[0].sheetContainer.frame.size.width + self.SheetFunctions.leftMargin), dy: 0)
            }
            labelAnimator_1 = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
                self.SheetFunctions.sheetOneLabel.frame = self.SheetFunctions.sheetOneLabel.frame.offsetBy(dx: -(self.SheetFunctions.pages[0].sheetContainer.frame.size.width + self.SheetFunctions.leftMargin), dy: 0)
            }
        case .Collapsed:
            frameAnimator_1 = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
                self.SheetFunctions.pages[0].sheetContainer.frame = self.SheetFunctions.pages[0].sheetContainer.frame.offsetBy(dx: (self.SheetFunctions.pages[0].sheetContainer.frame.size.width + self.SheetFunctions.leftMargin), dy: 0)
            }
            labelAnimator_1 = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
                self.SheetFunctions.sheetOneLabel.frame = self.SheetFunctions.sheetOneLabel.frame.offsetBy(dx: (self.SheetFunctions.pages[0].sheetContainer.frame.size.width + self.SheetFunctions.leftMargin), dy: 0)
            }
        }

        frameAnimator_1.startAnimation()
        runningAnimators.append(frameAnimator_1)
        
        labelAnimator_1.startAnimation()
        runningAnimators.append(labelAnimator_1)

        var frameAnimator_2 = UIViewPropertyAnimator()
        var labelAnimator_2 = UIViewPropertyAnimator()

        switch state {
        case .Expanded:
            frameAnimator_2 = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
                self.SheetFunctions.pages[1].sheetContainer.frame = self.SheetFunctions.pages[1].sheetContainer.frame.offsetBy(dx: -(self.SheetFunctions.pages[1].sheetContainer.frame.size.width + self.SheetFunctions.leftMargin), dy: 0)
            }
            labelAnimator_2 = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
                self.SheetFunctions.sheetTwoLabel.frame = self.SheetFunctions.sheetTwoLabel.frame.offsetBy(dx: -(self.SheetFunctions.pages[1].sheetContainer.frame.size.width + self.SheetFunctions.leftMargin), dy: 0)
            }

        case .Collapsed:
            frameAnimator_2 = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
                self.SheetFunctions.pages[1].sheetContainer.frame = self.SheetFunctions.pages[1].sheetContainer.frame.offsetBy(dx: (self.SheetFunctions.pages[1].sheetContainer.frame.size.width + self.SheetFunctions.leftMargin), dy: 0)
            }
            labelAnimator_2 = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
                self.SheetFunctions.sheetTwoLabel.frame = self.SheetFunctions.sheetTwoLabel.frame.offsetBy(dx: (self.SheetFunctions.pages[1].sheetContainer.frame.size.width + self.SheetFunctions.leftMargin), dy: 0)
            }
        }
        
        frameAnimator_2.startAnimation()
        runningAnimators.append(frameAnimator_2)
        
        labelAnimator_2.startAnimation()
        runningAnimators.append(labelAnimator_2)
        
        frameAnimator_1.addCompletion{ _ in
            if !frameAnimator_1.isReversed {
                self.isVisible = !self.isVisible
            }
            self.panningRightOnRelease = nil
            self.shouldIgnoreRemainingPans = false
            self.runningAnimators.removeAll()
        }
    }
    
    //Scrubs transition on pan .changed
    func updateInteractiveTransition(fractionComplete: CGFloat) {
        for animator in runningAnimators {
            animator.fractionComplete = fractionComplete + progressWhenInterrupted
        }
    }
    
    //Continues animators, conditionally reversing them based on direction your finger was traveling on pan .end
    func continueInteractiveTransition(cancel: Bool, shouldReverse: Bool) {
        for animator in runningAnimators {
            if self.panningRightOnRelease == nil {
                self.panningRightOnRelease = self.panningRightWhenChanged
            }
            animator.isReversed = shouldReverse
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    //MARK: FOR TAPS
    //Starts transition if necessary, or reverses it on tap
    func animateOrReverseRunningTransition(state: State, duration: TimeInterval) {
        if runningAnimators.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        } else {
            for animator in runningAnimators {
                animator.isReversed = !animator.isReversed
            }
        }
    }
}
