//
//  ActionSheet.swift
//  JSULife
//
//  Created by Asaad on 10/25/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class ActionSheet {
    var sheetOneViews: [UIButton]!
    var xVal = [CGFloat]()
    
    var sheetOneContainer = UIView()
    var parentVC: AmeliaChatViewController!
    var buttonState: [Bool] = Array(repeating: false, count: 12)
    
    func initViews() {
        sheetOneViews = [UIButton]()
        let latSpace = 16 as CGFloat
        let lonSpace = 8 as CGFloat
        
        let latInset = 23 as CGFloat
        let lonInset = 17 as CGFloat
        
        var column = 1

        var x = 0 as CGFloat
        var y = 0 as CGFloat
        
        var yMultiple = 0
        var maxRowW = 0 as CGFloat
        for i in 0..<sheetOne.count {
            let font = UIFont(name: "FuturaPT-Book", size: 18)
            let str = sheetOne[i]
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
            
            sheetOneViews.append(button)
        }
        
        let contF = CGRect(x: 0, y: 0, width: maxRowW, height: 6 * (sheetOneViews.first!.frame.size.height) + 5 * lonSpace)
        sheetOneContainer.frame = contF

        sheetOneViews[0].addTarget(parentVC, action: #selector(parentVC.A1(_:)), for: .touchUpInside)
        sheetOneViews[1].addTarget(parentVC, action: #selector(parentVC.A2(_:)), for: .touchUpInside)
        sheetOneViews[2].addTarget(parentVC, action: #selector(parentVC.A3(_:)), for: .touchUpInside)
        sheetOneViews[3].addTarget(parentVC, action: #selector(parentVC.A4(_:)), for: .touchUpInside)
        sheetOneViews[4].addTarget(parentVC, action: #selector(parentVC.A5(_:)), for: .touchUpInside)
        sheetOneViews[5].addTarget(parentVC, action: #selector(parentVC.A6(_:)), for: .touchUpInside)
        sheetOneViews[6].addTarget(parentVC, action: #selector(parentVC.A7(_:)), for: .touchUpInside)
        sheetOneViews[7].addTarget(parentVC, action: #selector(parentVC.A8(_:)), for: .touchUpInside)
        sheetOneViews[8].addTarget(parentVC, action: #selector(parentVC.A9(_:)), for: .touchUpInside)
        sheetOneViews[9].addTarget(parentVC, action: #selector(parentVC.A10(_:)), for: .touchUpInside)
        sheetOneViews[10].addTarget(parentVC, action: #selector(parentVC.A11(_:)), for: .touchUpInside)
        sheetOneViews[11].addTarget(parentVC, action: #selector(parentVC.A12(_:)), for: .touchUpInside)
        
        for b in sheetOneViews {
            sheetOneContainer.addSubview(b)
        }
    }
}
