//
//  ChatBubbleCell.swift
//  JSULife
//
//  Created by Asaad on 10/23/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class ImageCell: UITableViewCell {
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
        
        hugger.backgroundColor = UIColor.white
        //imageContainer.backgroundColor = UIColor.yellow
        imageContainer.layer.cornerRadius = 3
        ameliaView.image = UIImage(named: "Amelia")!
        ameliaView.contentMode = .scaleAspectFill
        ameliaView.isHidden = true
        
        hugger.layer.cornerRadius = 10.0
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "FuturaPT-Book", size: 18)!
        
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
            messageLabel.leadingAnchor.constraint(equalTo: ameliaView.trailingAnchor, constant: rowPadding.leading),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: rowPadding.bottom),
            ]
        
        let huggerConstraints = [
            hugger.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: hugging.top),
            hugger.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: hugging.leading),
            hugger.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: hugging.bottom),
            hugger.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: hugging.trailing),
            ]
        
        NSLayoutConstraint.activate(ameliaConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(huggerConstraints)
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
