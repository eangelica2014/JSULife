//
//  Typingswift
//  JSULife
//
//  Created by JSU on 10/23/20.
//  Copyright © 2020 JSU.Life. All rights reserved.
//

import Foundation
import UIKit

class TypingCell: UITableViewCell {
    let ameliaView = UIImageView()
    let hugger = UIView()
    let messageLabel = UILabel()

    var c1: CAShapeLayer!
    var c2: CAShapeLayer!
    var c3: CAShapeLayer!
    
    var animDelegateVC: AmeliaChatViewController!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        let rowPadding = RowPadding()
        let hugging = Hugging()
        let imagePadding = ImagePadding()
        
        addTypingIndicator()
        addSubview(ameliaView)
        addSubview(hugger)
        addSubview(messageLabel)
        hugger.layer.addSublayer(c1!)
        hugger.layer.addSublayer(c2!)
        hugger.layer.addSublayer(c3!)

        hugger.backgroundColor = UIColor.white
        //ameliaView.backgroundColor = UIColor.yellow
        ameliaView.image = UIImage(named: "Amelia")!
        ameliaView.contentMode = .scaleAspectFill
        ameliaView.isHidden = true
        
        hugger.layer.cornerRadius = 10.0
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "FuturaPT-Book", size: 18)!
        
        ameliaView.translatesAutoresizingMaskIntoConstraints = false
        hugger.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let ameliaConstraints = [
            ameliaView.topAnchor.constraint(equalTo: topAnchor, constant: imagePadding.top),
            ameliaView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: imagePadding.leading),
            ameliaView.widthAnchor.constraint(equalToConstant: imagePadding.width),
            ameliaView.heightAnchor.constraint(equalToConstant: imagePadding.height),
            ]
        
        let wFrame = 80 as CGFloat
        let hFrame = 47 as CGFloat
        let labelConstraints = [
            messageLabel.topAnchor.constraint(equalTo: ameliaView.topAnchor, constant: -hugging.top),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: rowPadding.bottom),
            messageLabel.leadingAnchor.constraint(equalTo: ameliaView.trailingAnchor, constant: rowPadding.leading),
            messageLabel.widthAnchor.constraint(equalToConstant: wFrame - (2 * hugging.trailing)),
            messageLabel.heightAnchor.constraint(equalToConstant: hFrame - (2 * hugging.bottom))
            ]
        
        let huggerConstraints = [
            hugger.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: hugging.top),
            hugger.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: hugging.leading),
            hugger.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: hugging.bottom),
            hugger.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: hugging.trailing),
            ]
        
        NSLayoutConstraint.activate(ameliaConstraints)
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(huggerConstraints)
    }
    
    var typingIndicator: UIView!
    func addTypingIndicator() {
        let wFrame = 80 as CGFloat
        typingIndicator = UIView(frame: CGRect(x: 0, y: 0, width: wFrame, height: 47))
        typingIndicator.backgroundColor = UIColor.white
        typingIndicator.layer.cornerRadius = 5
        typingIndicator.layer.position = CGPoint(x: ImagePadding().leading + ImagePadding().width + ImagePadding().leading + (wFrame * 0.5), y: self.frame.size.height * 0.5)
        
        let diameter = 13 as CGFloat
        let cR = 0.5 * diameter
        let circularPath = UIBezierPath(arcCenter: .zero, radius: cR, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        c1 = CAShapeLayer()
        c1!.path = circularPath.cgPath
        c1!.fillColor = UIColor(displayP3Red: 41/255, green: 64/255, blue: 94/255, alpha: 1.0).cgColor
        c1!.opacity = 1.0
        
        let cPath2 = UIBezierPath(arcCenter: .zero, radius: cR, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        c2 = CAShapeLayer()
        c2!.path = cPath2.cgPath
        c2!.fillColor = UIColor(displayP3Red: 41/255, green: 64/255, blue: 94/255, alpha: 1.0).cgColor
        c2!.opacity = 1.0
        
        let cPath3 = UIBezierPath(arcCenter: .zero, radius: cR, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        c3 = CAShapeLayer()
        c3!.path = cPath3.cgPath
        c3!.fillColor = UIColor(displayP3Red: 41/255, green: 64/255, blue: 94/255, alpha: 1.0).cgColor
        c3!.opacity = 1.0
        
        let interSpace = (typingIndicator.frame.size.width - (3 * diameter)) / 4
        let cX = typingIndicator.frame.size.width * 0.5
        c1!.position = CGPoint(x: cX - interSpace - diameter, y: typingIndicator.frame.size.height * 0.5)
        c2!.position = CGPoint(x: cX, y: typingIndicator.frame.size.height * 0.5)
        c3!.position = CGPoint(x: cX + interSpace + diameter, y: typingIndicator.frame.size.height * 0.5)
    }
    
    let dur = 0.05 as Double
    
    func beginSequence() {
        let op1 = CABasicAnimation(keyPath: "opacity")
        op1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        op1.fromValue = 0.40
        op1.toValue = 1.0
        op1.duration = dur
        op1.fillMode = CAMediaTimingFillMode.forwards
        op1.duration = 0.0
        op1.isRemovedOnCompletion = false
        
        c1!.add(op1, forKey: "")
        
        let dim7 = CABasicAnimation(keyPath: "opacity")
        dim7.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dim7.fromValue = 1.0
        dim7.toValue = 0.70
        dim7.fillMode = CAMediaTimingFillMode.forwards
        dim7.duration = 0.0
        dim7.isRemovedOnCompletion = false
        
        c2!.add(dim7, forKey: "")
        
        let dim4 = CABasicAnimation(keyPath: "opacity")
        dim4.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dim4.fromValue = 1.0
        dim4.toValue = 0.40
        dim4.duration = dur
        dim4.fillMode = CAMediaTimingFillMode.forwards
        dim4.duration = 0.0
        dim4.isRemovedOnCompletion = false
        dim4.delegate = animDelegateVC
        
        c3!.add(dim4, forKey: "beginSequence")
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
        
        c1!.add(A7, forKey: "A7")
        
        let B1 = CABasicAnimation(keyPath: "opacity")
        B1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        B1.duration = dur
        B1.fromValue = 0.7
        B1.toValue = 1.0
        B1.fillMode = CAMediaTimingFillMode.forwards
        B1.duration = 0.0
        B1.isRemovedOnCompletion = false
        B1.delegate = animDelegateVC
        
        c2!.add(B1, forKey: "B1")
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
        
        c1!.add(A4, forKey: "A4")
        
        let B7 = CABasicAnimation(keyPath: "opacity")
        B7.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        B7.duration = dur
        B7.fromValue = 1.0
        B7.toValue = 0.7
        B7.fillMode = CAMediaTimingFillMode.forwards
        B7.duration = 0.0
        B7.isRemovedOnCompletion = false
        
        c2!.add(B7, forKey: "B7")
        
        let C1 = CABasicAnimation(keyPath: "opacity")
        C1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        C1.duration = dur
        C1.fromValue = 0.4
        C1.toValue = 1.0
        C1.fillMode = CAMediaTimingFillMode.forwards
        C1.duration = 0.0
        C1.isRemovedOnCompletion = false
        C1.delegate = animDelegateVC
        
        c3!.add(C1, forKey: "C1")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
