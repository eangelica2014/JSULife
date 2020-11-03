//
//  YesNoSheet.swift
//  JSULife
//
//  Created by Asaad on 11/3/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class YesNoSheet {
    var parentVC: AmeliaChatViewController!
    
    func addYesButton() {
        let bottomPadding = parentVC.view.safeAreaInsets.bottom
        let edgeSpace = (24 / 414) * UIScreen.main.bounds.width
        let interSpace = (13 / 414) * UIScreen.main.bounds.width
        let buttonWidth = (UIScreen.main.bounds.width - interSpace - (2 * edgeSpace)) / 2
        let buttonHeight = (52 / 176) * buttonWidth
        parentVC.yesButton = UIButton(type: .system)
        parentVC.yesButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        parentVC.yesButton.setTitle("Yes", for: .normal)
        parentVC.yesButton.setTitleColor(UIColor.white, for: .normal)
        parentVC.yesButton.titleLabel?.font = UIFont(name: "FuturaPT-Book", size: 18.0)!
        parentVC.yesButton.layer.cornerRadius = 6
        parentVC.yesButton.backgroundColor = UIColor(displayP3Red: 6/255, green: 189/255, blue: 196/255, alpha: 1)
        parentVC.yesButton.layer.position = CGPoint(x: edgeSpace + 0.5 * buttonWidth, y: UIScreen.main.bounds.height - bottomPadding - (2 * buttonHeight))
    }
    
    func addNoButton() {
        let bottomPadding = parentVC.view.safeAreaInsets.bottom
        let edgeSpace = (24 / 414) * UIScreen.main.bounds.width
        let interSpace = (13 / 414) * UIScreen.main.bounds.width
        let buttonWidth = (UIScreen.main.bounds.width - interSpace - (2 * edgeSpace)) / 2
        let buttonHeight = (52 / 176) * buttonWidth
        parentVC.noButton = UIButton(type: .system)
        parentVC.noButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        parentVC.noButton.setTitle("No", for: .normal)
        parentVC.noButton.setTitleColor(UIColor.white, for: .normal)
        parentVC.noButton.layer.cornerRadius = 6
        parentVC.noButton.titleLabel?.font = UIFont(name: "FuturaPT-Book", size: 18.0)!
        parentVC.noButton.backgroundColor = UIColor(displayP3Red: 6/255, green: 189/255, blue: 196/255, alpha: 1)
        parentVC.noButton.layer.position = CGPoint(x: UIScreen.main.bounds.width - edgeSpace - 0.5 * buttonWidth, y: UIScreen.main.bounds.height - bottomPadding - (2 * buttonHeight))
    }
}
