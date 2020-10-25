//
//  TypingAnimator.swift
//  JSULife
//
//  Created by Asaad on 10/24/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class TypingAnimator {
    
    var animDelegateVC: AmeliaChatViewController!
    var cell: ChatBubbleCell!
    
//    var c1: CAShapeLayer!
//    var c2: CAShapeLayer!
//    var c3: CAShapeLayer!
    let dur = 0.25 as Double
    
    func beginSequence() {
        let op1 = CABasicAnimation(keyPath: "opacity")
        op1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        op1.fromValue = 0.40
        op1.toValue = 1.0
        op1.duration = dur
        op1.fillMode = CAMediaTimingFillMode.forwards
        op1.duration = 0.0
        op1.isRemovedOnCompletion = false
        
        cell.c1!.add(op1, forKey: "")
        
        let dim7 = CABasicAnimation(keyPath: "opacity")
        dim7.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dim7.fromValue = 1.0
        dim7.toValue = 0.70
        dim7.fillMode = CAMediaTimingFillMode.forwards
        dim7.duration = 0.0
        dim7.isRemovedOnCompletion = false
        
        cell.c2!.add(dim7, forKey: "")
        
        let dim4 = CABasicAnimation(keyPath: "opacity")
        dim4.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dim4.fromValue = 1.0
        dim4.toValue = 0.40
        dim4.duration = dur
        dim4.fillMode = CAMediaTimingFillMode.forwards
        dim4.duration = 0.0
        dim4.isRemovedOnCompletion = false
        dim4.delegate = animDelegateVC
        
        cell.c3!.add(dim4, forKey: "beginSequence")
    }
    
    func S1() {
        let A7 = CABasicAnimation(keyPath: "opacity")
        A7.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        A7.duration = dur
        A7.fromValue = 1.0
        A7.toValue = 0.70
        A7.fillMode = CAMediaTimingFillMode.forwards
        A7.duration = 0.0
        A7.isRemovedOnCompletion = false
        
        print("cellAdressX,", Unmanaged.passUnretained(cell).toOpaque())

        print("cell.c1,", cell.c1)
        
        cell.c1!.add(A7, forKey: "A7")
        
        let B1 = CABasicAnimation(keyPath: "opacity")
        B1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        B1.duration = dur
        B1.fromValue = 0.7
        B1.toValue = 1.0
        B1.fillMode = CAMediaTimingFillMode.forwards
        B1.duration = 0.0
        B1.isRemovedOnCompletion = false
        B1.delegate = animDelegateVC

        cell.c2!.add(B1, forKey: "B1")
    }
    
    func S2() {
        let A4 = CABasicAnimation(keyPath: "opacity")
        A4.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        A4.duration = dur
        A4.fromValue = 0.70
        A4.toValue = 0.40
        A4.fillMode = CAMediaTimingFillMode.forwards
        A4.duration = 0.0
        A4.isRemovedOnCompletion = false
        
        cell.c1!.add(A4, forKey: "A4")
        
        let B7 = CABasicAnimation(keyPath: "opacity")
        B7.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        B7.duration = dur
        B7.fromValue = 1.0
        B7.toValue = 0.7
        B7.fillMode = CAMediaTimingFillMode.forwards
        B7.duration = 0.0
        B7.isRemovedOnCompletion = false
        
        cell.c2!.add(B7, forKey: "B7")
        
        let C1 = CABasicAnimation(keyPath: "opacity")
        C1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        C1.duration = dur
        C1.fromValue = 0.4
        C1.toValue = 1.0
        C1.fillMode = CAMediaTimingFillMode.forwards
        C1.duration = 0.0
        C1.isRemovedOnCompletion = false
        C1.delegate = animDelegateVC

        cell.c3!.add(C1, forKey: "C1")
    }
}
