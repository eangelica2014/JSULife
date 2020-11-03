//
//  ActionSheet.swift
//  JSULife
//
//  Created by JSU on 10/23/20.
//  Copyright © 2020 JSU.Life. All rights reserved.
//

import Foundation
import UIKit

class Functions {
    var pages = [ActionSheet]()
    var parentVC: AmeliaChatViewController!
    var pagesContainer: UIView!
    let topSpace = 32 as CGFloat
    let leftMargin = 17 as CGFloat
    let rightInset = 30 as CGFloat
    
    var animator: ActionAnimator!
    
    var panGesture: UIPanGestureRecognizer!
    var sheetOneLabel: UILabel!
    var sheetTwoLabel: UILabel!

    init() {
        animator = ActionAnimator()
        animator.SheetFunctions = self
        
        pages.append(ActionSheet(forSheetValues: sheetOne))
        pages.append(ActionSheet(forSheetValues: sheetTwo))
        sheetOne_ButtonConfig()
        sheetTwo_ButtonConfig()
        pagesContainer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: pages[0].sheetContainer.frame.height + topSpace))
        
        pages[0].sheetContainer.frame = CGRect(x: leftMargin, y: topSpace, width: pages[0].sheetContainer.frame.width, height: pages[0].sheetContainer.frame.height)
        pages[1].sheetContainer.frame = CGRect(x: pagesContainer.frame.size.width - rightInset, y: topSpace, width: pages[0].sheetContainer.frame.width, height: pages[0].sheetContainer.frame.height)

        pagesContainer.addSubview(pages[0].sheetContainer)
        pagesContainer.addSubview(pages[1].sheetContainer)
        
        addPanGesture()
        
        addSheetOneLabel()
        addSheetTwoLabel()
    }
    
    func sheetOne_ButtonConfig() {
        pages[0].sheetViews[0].addTarget(parentVC, action: #selector(parentVC.A1(_:)), for: .touchUpInside)
        pages[0].sheetViews[1].addTarget(parentVC, action: #selector(parentVC.A2(_:)), for: .touchUpInside)
        pages[0].sheetViews[2].addTarget(parentVC, action: #selector(parentVC.A3(_:)), for: .touchUpInside)
        pages[0].sheetViews[3].addTarget(parentVC, action: #selector(parentVC.A4(_:)), for: .touchUpInside)
        pages[0].sheetViews[4].addTarget(parentVC, action: #selector(parentVC.A5(_:)), for: .touchUpInside)
        pages[0].sheetViews[5].addTarget(parentVC, action: #selector(parentVC.A6(_:)), for: .touchUpInside)
        pages[0].sheetViews[6].addTarget(parentVC, action: #selector(parentVC.A7(_:)), for: .touchUpInside)
        pages[0].sheetViews[7].addTarget(parentVC, action: #selector(parentVC.A8(_:)), for: .touchUpInside)
        pages[0].sheetViews[8].addTarget(parentVC, action: #selector(parentVC.A9(_:)), for: .touchUpInside)
        pages[0].sheetViews[9].addTarget(parentVC, action: #selector(parentVC.A10(_:)), for: .touchUpInside)
        pages[0].sheetViews[10].addTarget(parentVC, action: #selector(parentVC.A11(_:)), for: .touchUpInside)
        pages[0].sheetViews[11].addTarget(parentVC, action: #selector(parentVC.A12(_:)), for: .touchUpInside)
    }
    
    func sheetTwo_ButtonConfig() {
        pages[1].sheetViews[0].addTarget(parentVC, action: #selector(parentVC.B1(_:)), for: .touchUpInside)
        pages[1].sheetViews[1].addTarget(parentVC, action: #selector(parentVC.B2(_:)), for: .touchUpInside)
        pages[1].sheetViews[2].addTarget(parentVC, action: #selector(parentVC.B3(_:)), for: .touchUpInside)
        pages[1].sheetViews[3].addTarget(parentVC, action: #selector(parentVC.B4(_:)), for: .touchUpInside)
        pages[1].sheetViews[4].addTarget(parentVC, action: #selector(parentVC.B5(_:)), for: .touchUpInside)
        pages[1].sheetViews[5].addTarget(parentVC, action: #selector(parentVC.B6(_:)), for: .touchUpInside)
        pages[1].sheetViews[6].addTarget(parentVC, action: #selector(parentVC.B7(_:)), for: .touchUpInside)
        pages[1].sheetViews[7].addTarget(parentVC, action: #selector(parentVC.B8(_:)), for: .touchUpInside)
        pages[1].sheetViews[8].addTarget(parentVC, action: #selector(parentVC.B9(_:)), for: .touchUpInside)
        pages[1].sheetViews[9].addTarget(parentVC, action: #selector(parentVC.B10(_:)), for: .touchUpInside)
    }
    
    let sheetOne = [
        "Lying down",
        "Walking",
        "Sitting",
        "Gripping/Pinching",
        "Kneeling",
        "Talking",
        "Turning neck/back",
        "Lifting",
        "Squatting",
        "Standing",
        "Getting up from fall",
        "Eating"
    ]
    
    let sheetTwo = [
        "Driving",
        "Carrying objects",
        "Yardwork",
        "Dressing",
        "Grocery Shopping",
        "Work Tasks",
        "Cleaning",
        "Cooking",
        "Laundry",
        "Rising from bed"
    ]
    
    func addPanGesture() {
        panGesture = UIPanGestureRecognizer(target: animator, action: #selector(animator.panGesture(_:)))
        panGesture.delegate = animator
        panGesture.cancelsTouchesInView = true
        pagesContainer.addGestureRecognizer(panGesture)
    }
    
    func addSheetOneLabel() {
        sheetOneLabel = UILabel()
        let font = UIFont(name: "FuturaPT-Demi", size: 18)!
        let str = "Basic Functions"
        let w = str.size(withAttributes: [.font: font]).width
        let h = font.lineHeight
        let frame = CGRect(x: pages[0].sheetContainer.frame.minX, y: pages[0].sheetContainer.frame.minY - 18 - h, width: w, height: h)
        sheetOneLabel.text = str
        sheetOneLabel.textColor = navy
        sheetOneLabel.frame = frame
        sheetOneLabel.font = font
        pagesContainer.addSubview(sheetOneLabel)
    }
    
    func addSheetTwoLabel() {
        sheetTwoLabel = UILabel()
        let font = UIFont(name: "FuturaPT-Demi", size: 18)!
        let str = "Common Activities"
        let w = str.size(withAttributes: [.font: font]).width
        let h = font.lineHeight
        let frame = CGRect(x: pages[1].sheetContainer.frame.minX, y: pages[0].sheetContainer.frame.minY - 18 - h, width: w, height: h)
        sheetTwoLabel.text = str
        sheetTwoLabel.textColor = navy
        sheetTwoLabel.frame = frame
        sheetTwoLabel.font = font
        pagesContainer.addSubview(sheetTwoLabel)
    }
}

class ActionSheet {
    var sheetViews: [UIButton]!
    
    var xVal = [CGFloat]()
    
    var sheetContainer = UIView()
    
    var parentVC: AmeliaChatViewController!
    var buttonState: [Bool] = Array(repeating: false, count: 12)
    
    var sheetValues: [String]
    init(forSheetValues: [String]) {
        sheetViews = [UIButton]()
        sheetValues = forSheetValues
        buildSheet()
    }
    
    let latSpace = 16 as CGFloat
    let lonSpace = 8 as CGFloat
    
    let latInset = 23 as CGFloat
    let lonInset = 17 as CGFloat
    
    func buildSheet() {
        var column = 1

        var x = 0 as CGFloat
        var y = 0 as CGFloat
        
        var yMultiple = 0
        var maxRowW = 0 as CGFloat
        
        for i in 0..<sheetValues.count {
            let font = UIFont(name: "FuturaPT-Book", size: 18)
            let str = sheetValues[i]
            let w = str.size(withAttributes: [.font: font!]).width
            let h = font!.lineHeight
            
            let finWid = w + (2 * latInset)
            let finH = h + (2 * lonInset)
            xVal.append(finWid)
            
            if column == 1 {
                x = 0
                column = 2
            } else if column == 2 {
                x = xVal[xVal.count - 2] + latSpace
                column = 1
            }
            
            if xVal.count % 2 != 0 {
                if xVal.count > 2 {
                    let sumRow = xVal[xVal.count - 1] + xVal[xVal.count - 2]
                    if sumRow > maxRowW {
                        maxRowW = sumRow
                    }
                }
                y = CGFloat(yMultiple) * (finH + lonSpace)
                yMultiple += 1
            }
            
            let button = UIButton(frame: CGRect(x: x, y: y, width: finWid, height: finH))
            button.setTitle(str, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont(name: "FuturaPT-Book", size: 18.0)!
            button.layer.cornerRadius = 6
            button.backgroundColor = UIColor(displayP3Red: 6/255, green: 189/255, blue: 196/255, alpha: 1)
            
            sheetViews.append(button)
        }
        
        let contF = CGRect(x: 0, y: 0, width: maxRowW, height: 6 * (sheetViews.first!.frame.size.height) + 5 * lonSpace)
        sheetContainer.frame = contF
        for b in sheetViews {
            sheetContainer.addSubview(b)
        }
    }
}
