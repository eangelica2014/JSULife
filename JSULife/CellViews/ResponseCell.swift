//
//  ResponseCell.swift
//  JSULife
//
//  Created by JSU on 10/23/20.
//  Copyright © 2020 JSU.Life. All rights reserved.
//

import Foundation
import UIKit

class ResponseCell: UITableViewCell {
    let ameliaView = UIImageView()
    let hugger = UIView()
    let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        let rowPadding = RowPadding()
        let hugging = Hugging()
        let imagePadding = ImagePadding()
        
        addSubview(ameliaView)
        addSubview(hugger)
        addSubview(messageLabel)
        
        messageLabel.textColor = UIColor.white
        hugger.backgroundColor = UIColor(displayP3Red: 6/255, green: 189/255, blue: 196/255, alpha: 1)
        //ameliaView.backgroundColor = UIColor.yellow
        ameliaView.contentMode = .scaleAspectFill
        ameliaView.isHidden = true
        ameliaView.image = UIImage(named: "Amelia")!

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
        
        let dimension = 250 / 414 as CGFloat
        let labelConstraints = [
            messageLabel.topAnchor.constraint(equalTo: ameliaView.topAnchor, constant: -hugging.top),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: rowPadding.bottom),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -rowPadding.leading),
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
