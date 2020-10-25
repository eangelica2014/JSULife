//
//  MessageCell.swift
//  JSULife
//
//  Created by Asaad on 10/25/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class MessageCell: UITableViewCell {
     let ameliaView = UIImageView()
     let messageLabel = UILabel()
     let hugger = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        let rowPadding = RowPadding()
        let hugging = Hugging()
        let imagePadding = ImagePadding()
        
        addSubview(ameliaView)
        addSubview(hugger)
        addSubview(messageLabel)
      
        hugger.backgroundColor = UIColor.white
        //ameliaView.backgroundColor = UIColor.yellow
        ameliaView.contentMode = .scaleAspectFill
        ameliaView.isHidden = true
        ameliaView.image = UIImage(named: "Amelia")!
        
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
            messageLabel.leadingAnchor.constraint(equalTo: ameliaView.trailingAnchor, constant: rowPadding.leading),
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
        
        print("hugger,", hugger.intrinsicContentSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
