//
//  ChatBubbleCell.swift
//  JSULife
//
//  Created by Asaad on 10/23/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class ChatBubbleCell: UITableViewCell {
    let messageLabel = UILabel()
    let hugger = UIView()
    let ameliaView = UIImageView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var isResponse: Bool! {
        didSet {
            if isResponse == true {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            } else {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }
        }
    }

    struct RowPadding {
        let top = 16.0 as CGFloat
        let leading = 32.0 as CGFloat
        let bottom = -16.0 as CGFloat
    }
    
    struct ImagePadding {
        let top = 19.0 as CGFloat
        let leading = 19.0 as CGFloat
        let width = 47.0 as CGFloat
        let height = 47.0 as CGFloat
    }
    
    struct Hugging {
        let top = -16.0 as CGFloat
        let leading = -16.0 as CGFloat
        let bottom = 16.0 as CGFloat
        let trailing = 16.0 as CGFloat
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let rowPadding = RowPadding()
        let hugging = Hugging()
        let imagePadding = ImagePadding()
        
        addSubview(ameliaView)
        addSubview(hugger)
        addSubview(messageLabel)
        
        ameliaView.backgroundColor = UIColor.clear
        ameliaView.image = UIImage(named: "Amelia")!
        ameliaView.contentMode = .scaleAspectFill
        ameliaView.isHidden = true

        hugger.backgroundColor = UIColor.white
        hugger.layer.cornerRadius = 10.0

        let dimension = 250 / 414 as CGFloat
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
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: ameliaView.trailingAnchor, constant: rowPadding.leading)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -rowPadding.leading)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
