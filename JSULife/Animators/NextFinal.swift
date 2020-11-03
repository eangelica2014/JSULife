//
//  NextFinal.swift
//  JSULife
//
//  Created by Asaad on 11/3/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class NextFinal {
    var parentVC: AmeliaChatViewController!
    
    func addNextButton() {
        let buttonWidth = (222 / 375) * UIScreen.main.bounds.width
        let buttonHeight = (43 / 222) * buttonWidth
        let b = UIButton(type: .system)
        b.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        b.setTitle("Next", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.titleLabel?.font = UIFont(name: "FuturaPT-Book", size: 18.0)!
        b.layer.cornerRadius = buttonHeight / 2
        b.backgroundColor = UIColor(displayP3Red: 247/255, green: 54/255, blue: 32/255, alpha: 1)
        b.layer.position = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: parentVC.SheetFunctions.pagesContainer.frame.maxY + 27 + buttonHeight * 0.5)
        if parentVC.nextButton == nil {
            parentVC.nextButton = b
        }
    }
}
