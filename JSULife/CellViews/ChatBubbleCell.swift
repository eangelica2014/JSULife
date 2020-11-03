//
//  ChatBubbleCell.swift
//  JSULife
//
//  Created by JSU on 10/23/20.
//  Copyright © 2020 JSU.Life. All rights reserved.
//

import Foundation
import UIKit

class ChatBubbleCell: UITableViewCell {
    let messageLabel = UILabel()
    let hugger = UIView()
    let ameliaView = UIImageView()
    let imageContainer = UIImageView()
    var Typing_Animator: TypingAnimator?
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var imageConstraints: [NSLayoutConstraint]!
    var typingWConstraint: NSLayoutConstraint!
    var typingHConstraint: NSLayoutConstraint!

    var c1: CAShapeLayer?
    var c2: CAShapeLayer?
    var c3: CAShapeLayer?
    
    var isAnimating: Bool!
    
    var isResponse: Bool! {
        didSet {
            if isResponse == true {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
                messageLabel.textColor = UIColor.white
                hugger.backgroundColor = UIColor(displayP3Red: 6/255, green: 189/255, blue: 196/255, alpha: 1)
            } else {
                hugger.backgroundColor = UIColor.white
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }
        }
    }
    
    var isProcessing = true {
        didSet {
            if isProcessing == true {
                addTypingIndicator()
                hugger.layer.addSublayer(c1!)
                hugger.layer.addSublayer(c2!)
                hugger.layer.addSublayer(c3!)
                isAnimating = true
                Typing_Animator?.beginSequence()
                typingWConstraint.isActive = true
                typingHConstraint.isActive = true
            } else {
                c1?.removeFromSuperlayer()
                c2?.removeFromSuperlayer()
                c3?.removeFromSuperlayer()
                typingWConstraint.isActive = false
                typingHConstraint.isActive = false
            }
        }
    }
    
    var isImageType = true {
        didSet {
            if isImageType == true {
                NSLayoutConstraint.activate(imageConstraints)
                messageLabel.isHidden = true
                imageContainer.image = UIImage(named: "YouAreBeautiful")!
            } else {
                
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        let rowPadding = RowPadding()
        let hugging = Hugging()
        let imagePadding = ImagePadding()
        
        addSubview(ameliaView)
        addSubview(hugger)
        addSubview(messageLabel)
        addSubview(imageContainer)

        imageContainer.backgroundColor = UIColor.yellow
        imageContainer.layer.cornerRadius = 3
        ameliaView.backgroundColor = UIColor.yellow
        //ameliaView.image = UIImage(named: "Amelia")!
        ameliaView.contentMode = .scaleAspectFill
        ameliaView.isHidden = true

        hugger.layer.cornerRadius = 10.0

        let dimension = 250 / 414 as CGFloat
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "FuturaPT-Book", size: 18)!
        //messageLabel.backgroundColor = UIColor.magenta
        
        ameliaView.translatesAutoresizingMaskIntoConstraints = false
        hugger.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let ameliaConstraints = [
            ameliaView.topAnchor.constraint(equalTo: topAnchor, constant: imagePadding.top),
            ameliaView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: imagePadding.leading),
            ameliaView.widthAnchor.constraint(equalToConstant: imagePadding.width),
            ameliaView.heightAnchor.constraint(equalToConstant: imagePadding.height),
            ]
        
        let imageWidth = (284/414) * UIScreen.main.bounds.width
        imageConstraints = [
            imageContainer.topAnchor.constraint(equalTo: ameliaView.topAnchor, constant: -hugging.top),
            imageContainer.widthAnchor.constraint(equalToConstant: imageWidth),
            imageContainer.heightAnchor.constraint(equalToConstant: imageWidth * 187/284),
            imageContainer.leadingAnchor.constraint(equalTo: ameliaView.trailingAnchor, constant: rowPadding.leading),
            messageLabel.topAnchor.constraint(equalTo: ameliaView.topAnchor, constant: -hugging.top),
            messageLabel.widthAnchor.constraint(equalToConstant: imageWidth),
            messageLabel.heightAnchor.constraint(equalToConstant: imageWidth * 187/284),
        ]
        
        let labelConstraints = [
            messageLabel.topAnchor.constraint(equalTo: ameliaView.topAnchor, constant: -hugging.top),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: rowPadding.bottom),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: dimension * UIScreen.main.bounds.width),
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
        
        let wFrame = 80 as CGFloat
        let hFrame = 47 as CGFloat
        typingWConstraint = messageLabel.widthAnchor.constraint(equalToConstant: wFrame - (2 * hugging.trailing))
        typingHConstraint = messageLabel.heightAnchor.constraint(equalToConstant: hFrame - (2 * hugging.bottom))
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: ameliaView.trailingAnchor, constant: rowPadding.leading)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -rowPadding.leading)
    }
    
    var typingIndicator: UIView!

    
    func addTypingIndicator() {
        print("addTypingIndicator")
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
        //typingIndicator.layer.addSublayer(c1)
        //typingIndicator.layer.addSublayer(c2)
        //typingIndicator.layer.addSublayer(c3)
        
        //addSubview(typingIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
