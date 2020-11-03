//
//  AmeliaChatViewController.swift
//  JSULife
//
//  Created by JSU on 10/23/20.
//  Copyright © 2020 JSU.Life. All rights reserved.
//

import Foundation
import UIKit

class AmeliaChatViewController: UIViewController, CAAnimationDelegate, UITableViewDelegate, UITableViewDataSource {
    var chatSceneContainer: UIView!
    var dialogue: [String]!
    
    let chatCellID = "chatCellID"
    
    let typingCellID = "typingCell"
    let messageCellID = "messageCellID"
    let imageCellID = "imageCellID"
    let responseCellID = "responseCellID"
    let footerCellID = "footerID"

    let tableContainer = UIView(frame: UIScreen.main.bounds)
    
    let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
    
    var yesButton: UIButton!
    var noButton: UIButton!
    
    var dialogueCounter = 0
    var typingAnimator: TypingAnimator!
    var Action_Sheet: ActionSheet!
    
    var SheetFunctions: Functions!
    
    var cellHeights = [IndexPath: CGFloat]()
    var ameliaSet = [0, 4, 8, 10, 12, 15, 18]
    var animated = [Int]()
    var typingCell: TypingCell!
    
    var animationLoop = 0
    var didBeginSequence = false
    var didPresentFunctions = false
    
    var shouldResizeFooter = false
    
    let YesNo = YesNoSheet()
    let N = NextFinal()
    
    var nextButton: UIButton!
    
    var functionsDoneButton: UIButton!
    var functionsLabel: UILabel!
    
    var sliderContainer: UIView!
    var painPrompt: UILabel!
    var sliderLabel: UILabel!
    var sliderVal = 0
    let edgeSpace = 14 as CGFloat
    var painSlider: UISlider!
    var sliderAcceptButton: UIButton!
    
    var func_stringComponents = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = UIScreen.main.bounds
        tableView.delegate = self
        tableView.dataSource = self
        self.tableContainer.addSubview(tableView)
        self.view.addSubview(tableContainer)
        
        tableView.register(ChatBubbleCell.self, forCellReuseIdentifier: chatCellID)
        tableView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableView.register(TypingCell.self, forCellReuseIdentifier: typingCellID)
        tableView.register(MessageCell.self, forCellReuseIdentifier: messageCellID)
        tableView.register(ImageCell.self, forCellReuseIdentifier: imageCellID)
        tableView.register(ResponseCell.self, forCellReuseIdentifier: responseCellID)
        tableView.register(FooterView.self, forHeaderFooterViewReuseIdentifier: footerCellID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        dialogue = [String]()
        
        SheetFunctions = Functions()
        SheetFunctions.parentVC = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dialogue.isEmpty {
            dialogue.append(" ")
        }
        return dialogue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Case 1: Amelia Typing
        if dialogue[indexPath.row] == " " {
            let cell: TypingCell! = tableView.dequeueReusableCell(withIdentifier: typingCellID) as? TypingCell
            cell.animDelegateVC = self
            cell.beginSequence()
            
            if ameliaSet.contains(indexPath.row) {
                cell.ameliaView.isHidden = false
            } else {
                cell.ameliaView.isHidden = true
            }
            typingCell = cell
            return cell
        }
        
        //Case 2: Amelia Image
        if dialogue[indexPath.row] == "[insert image]" {
            let cell: ImageCell! = tableView.dequeueReusableCell(withIdentifier: imageCellID) as? ImageCell
            cell.imageContainer.image = UIImage(named: "YouAreBeautiful")!
            if indexPath.row == 19 {
                cell.imageContainer.image = UIImage(named: "YouGotThis")!
            }
            if ameliaSet.contains(indexPath.row) {
                cell.ameliaView.isHidden = false
            } else {
                cell.ameliaView.isHidden = true
            }
            return cell
        }
        
        //Case 3: User Response
        if dialogue[indexPath.row] == "" || dialogue[indexPath.row] == "Yes" || indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 17 ||  dialogue[indexPath.row] == "Can’t move a part of my face and have trouble speaking correctly since my stroke." {
            let cell: ResponseCell! = tableView.dequeueReusableCell(withIdentifier: responseCellID) as? ResponseCell
            cell.messageLabel.text = dialogue[indexPath.row]
            if ameliaSet.contains(indexPath.row) {
                cell.ameliaView.isHidden = false
            } else {
                cell.ameliaView.isHidden = true
            }
            return cell
        }
        
        //Fall-back Case 4: Amelia Response
        let cell: MessageCell! = tableView.dequeueReusableCell(withIdentifier: messageCellID) as? MessageCell
        cell.messageLabel.text = dialogue[indexPath.row]
        print("lastMessage,", dialogue[indexPath.row])
        if ameliaSet.contains(indexPath.row) {
            cell.ameliaView.isHidden = false
        } else {
            cell.ameliaView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerCellID) as! FooterView
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if dialogue.count == 11 && shouldResizeFooter == true {
            return UIScreen.main.bounds.height * 0.85
        }
        return UIScreen.main.bounds.height * 0.45
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func scrollToBottom() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            if self.tableView.tableFooterView != nil && (self.tableView.tableFooterView?.frame.size.height ?? 0.0) > 0 {
                self.tableView.scrollRectToVisible(self.tableView.tableFooterView?.frame ?? CGRect.zero, animated: true)
            } else {
                if self.tableView.numberOfSections > 0 {
                    let numRows = self.tableView.numberOfRows(inSection: 0)
                    if numRows > 0 {
                        let ipath = IndexPath(row: numRows - 1, section: 0)
                        self.tableView.scrollToRow(at: ipath, at: .bottom, animated: true)
                    }
                }
            }
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == typingCell.c3.animation(forKey: "beginSequence") {
            typingCell.S1()
        }
        
        if anim == typingCell.c2.animation(forKey: "B1") {
            typingCell.S2()
        }
        
        if anim == typingCell.c3.animation(forKey: "C1") {
            if animationLoop < 1 {
                typingCell.beginSequence()
                animationLoop += 1
            } else {
                animationLoop = 0
                print("dialoguecount,", dialogue.count)
                dialogue[dialogue.count - 1] = AmeliaDialogue[dialogue.count - 1]
                scrollToBottom()

                self.tableView.reloadData()
                if dialogue.count == 3 {
                    self.presentYesNo()
                }
                if dialogue.count == 7 {
                    self.presentSlider()
                }
                if dialogue.count == 9 {
                    self.presentKeyboard()
                }
                if dialogue.count == 11 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                        self.shouldResizeFooter = true
                        self.tableView.reloadData()
                        self.scrollToBottom()
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.50, execute: {
                            if self.didPresentFunctions == false {
                                self.didPresentFunctions = true
                                self.presentFunctions()
                            }
                        })
                    }
                }
                if dialogue.count == 14 {
                    self.presentYesNo()
                }
                if dialogue.count == 17 {
                    self.presentGoalKeyboard()
                    return
                }
                if dialogue.count == 22 {
                    self.presentNextButton()
                    return
                }
                if dialogue.count < AmeliaDialogue.count {
                    if AmeliaDialogue[dialogue.count] == "" {
                        return
                    }
                }
                self.queueAmelia()
            }
        }
    }
    
    func queueAmelia() {
        dialogue.append(" ")
        tableView.reloadData()
    }
    
    func presentNextButton() {
        print("presentNextButton")
        N.parentVC = self
        N.addNextButton()
        if nextButton != nil {
            self.view.addSubview(nextButton)
            nextButton.addTarget(self, action: #selector(nextButton(_:)), for: .touchUpInside)
        }
    }
    
    func presentYesNo() {
        YesNo.parentVC = self
        YesNo.addYesButton()
        YesNo.addNoButton()
        self.view.addSubview(yesButton)
        self.view.addSubview(noButton)
        yesButton.addTarget(self, action: #selector(yesButton(_:)), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(noButton(_:)), for: .touchUpInside)
    }
    
    func presentKeyboard() {
        dialogue.append("Can’t move a part of my face and have trouble speaking correctly since my stroke.")
        queueAmelia()
    }
    
    func presentGoalKeyboard() {
        dialogue.append("To be able to do my own things on my own")
        queueAmelia()
    }
    
    func presentFunctions() {
        SheetFunctions.pagesContainer.frame = CGRect(x: 0, y: 0.25 * UIScreen.main.bounds.height, width: SheetFunctions.pagesContainer.frame.width, height: SheetFunctions.pagesContainer.frame.height)
        view.addSubview(SheetFunctions.pagesContainer)
        addFunctionsDoneButton()
        addFunctionsTitleLabel()
    }
    
    func presentSlider() {
        sliderContainer = UIView(frame: CGRect(x: 0, y: (486/736) * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 145/414 * UIScreen.main.bounds.width))
        view.addSubview(sliderContainer)
        
        painPrompt = UILabel()
        let font = UIFont(name: "FuturaPT-Book", size: 18)
        let str = "Use pain scale below"
        let w = str.size(withAttributes: [.font: font!]).width
        let h = font!.lineHeight
        let frame = CGRect(x: 0, y: 0, width: w, height: h)
        painPrompt.text = str
        painPrompt.textColor = UIColor(displayP3Red: 41/255, green: 64/255, blue: 94/255, alpha: 1)
        painPrompt.frame = frame
        painPrompt.font = font
        painPrompt.layer.position = CGPoint(x: sliderContainer.center.x, y: 0.5 * h)
        sliderContainer.addSubview(painPrompt)
        addSliderLabel()
        addSlider()
        //addLines()
        addSliderAcceptButton()
    }
    
    func addFunctionsDoneButton() {
        let buttonWidth = (222 / 375) * UIScreen.main.bounds.width
        let buttonHeight = (43 / 222) * buttonWidth
        let b = UIButton(type: .system)
        b.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        b.setTitle("Done", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.titleLabel?.font = UIFont(name: "FuturaPT-Book", size: 18.0)!
        b.layer.cornerRadius = buttonHeight / 2
        b.backgroundColor = UIColor(displayP3Red: 247/255, green: 54/255, blue: 32/255, alpha: 1)
        b.layer.position = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: SheetFunctions.pagesContainer.frame.maxY + 27 + buttonHeight * 0.5)
        if functionsDoneButton == nil {
            functionsDoneButton = b
            self.view.addSubview(functionsDoneButton)
            functionsDoneButton.addTarget(self, action: #selector(doneFunctions(_:)), for: .touchUpInside)
        }
    }
    
    func addFunctionsTitleLabel() {
        let font = UIFont(name: "FuturaPT-Book", size: 18)
        let str = "Select as many that apply:"
        let w = str.size(withAttributes: [.font: font!]).width
        let h = font!.lineHeight
        let frame = CGRect(x: 0, y: 0, width: w, height: h)
        let label = UILabel()
        label.text = str
        label.textColor = navy
        label.frame = frame
        label.font = font
        label.layer.position = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: SheetFunctions.pagesContainer.frame.minY - 19 - 0.5 * h)
        if functionsLabel == nil {
            functionsLabel = label
            self.view.addSubview(functionsLabel)
        }
    }
    
    func addSliderLabel() {
        sliderLabel = UILabel()
        let font = UIFont(name: "FuturaPT-Book", size: 18)
        let str = "[10]" + " " + "Very Intolerable"
        let w = str.size(withAttributes: [.font: font!]).width
        let h = font!.lineHeight
        let frame = CGRect(x: 0, y: 0, width: w, height: h)
        sliderLabel.text = "[\(sliderVal)]" + " " + "No pain"
        sliderLabel.textColor = dieter_Orange
        sliderLabel.frame = frame
        sliderLabel.font = font
        sliderLabel.layer.position = CGPoint(x: 1.5 * edgeSpace + 0.5 * w, y: 43/145 * sliderContainer.frame.size.height)
        sliderContainer.addSubview(sliderLabel)
    }
    
    func addSlider() {
        painSlider = CustomSlider()
        painSlider.frame = CGRect(x: edgeSpace, y: sliderContainer.frame.size.height - painSlider.frame.size.height, width: UIScreen.main.bounds.width - 2 * edgeSpace, height: painSlider.frame.size.height)
        painSlider.minimumValue = 0
        painSlider.maximumValue = 10
        painSlider.isContinuous = true
        painSlider.thumbTintColor = UIColor(displayP3Red: 6/255, green: 189/255, blue: 196/255, alpha: 1)
        painSlider.minimumTrackTintColor = UIColor(displayP3Red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        painSlider.maximumTrackTintColor = UIColor(displayP3Red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        //painSlider.setThumbImage(UIImage(named: "SliderThumb"), for: .normal)
        painSlider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
        sliderContainer.addSubview(painSlider)
    }
    
    func addLines() {
        var x = painSlider.currentThumbImage!.size.width
        let y = sliderContainer.frame.size.height - (painSlider.frame.size.height)
        for i in 0..<10 {
            if i == 0 {
                x = edgeSpace
            }
            let line = UIView(frame: CGRect(x: x, y: y, width: 2, height: 20))
            line.backgroundColor = UIColor(white: 0.50, alpha: 1.0)
            x += (painSlider.frame.size.width/10)
            sliderContainer.addSubview(line)
        }
    }
    
    func addSliderAcceptButton() {
        let w = (128/375) * UIScreen.main.bounds.width as CGFloat
        let h = (47/128) * w as CGFloat
        sliderAcceptButton = UIButton(type: .system)
        sliderAcceptButton.frame = CGRect(x: (UIScreen.main.bounds.width - w) * 0.5, y: sliderContainer.frame.maxY + 14, width: w, height: h)
        sliderAcceptButton.setTitle("Select Level", for: .normal)
        sliderAcceptButton.setTitleColor(UIColor.white, for: .normal)
        sliderAcceptButton.titleLabel?.font = UIFont(name: "FuturaPT-Book", size: 18.0)!
        sliderAcceptButton.layer.cornerRadius = 6
        sliderAcceptButton.backgroundColor = UIColor(displayP3Red: 6/255, green: 189/255, blue: 196/255, alpha: 1)
        self.view.addSubview(sliderAcceptButton)
        sliderAcceptButton.addTarget(self, action: #selector(sliderAcceptButton(_:)), for: .touchUpInside)
    }
    
    @objc func nextButton(_ sender: UIButton) {
        //TODO: Configure Next to Go to HomeScreen
    }
    
    @objc func doneFunctions(_ sender: UIButton) {
        var str = ""
        for i in 0..<func_stringComponents.count {
            str.append(func_stringComponents[i])
            if i != func_stringComponents.count - 1 {
                str.append(", ")
            }
        }
        functionsLabel.removeFromSuperview()
        functionsDoneButton.removeFromSuperview()
        SheetFunctions.pagesContainer.removeFromSuperview()
        dialogue.append(str)
        queueAmelia()
    }
    
    @objc func sliderDidChange(_ sender: UISlider) {
        sliderVal = Int(painSlider.value)
        sliderLabel.text = "[\(sliderVal)]" + " " + painToVal(sliderVal)
    }
    
    @objc func sliderAcceptButton(_ sender: UIButton) {
        dialogue.append("[\(sliderVal)]" + " " + painToVal(sliderVal))
        sliderContainer.removeFromSuperview()
        sliderAcceptButton.removeFromSuperview()
        queueAmelia()
    }
    
    @objc func yesButton(_ sender: UIButton) {
        dialogue.append("Yes")
        yesButton.removeFromSuperview()
        noButton.removeFromSuperview()
        queueAmelia()
    }
    
    @objc func noButton(_ sender: UIButton) {
        //TODO:
    }
    
    @objc func A1(_ sender: UIButton) {
        switchActionButtonState(0, 0)
    }
    
    @objc func A2(_ sender: UIButton) {
        switchActionButtonState(0, 1)
    }
    
    @objc func A3(_ sender: UIButton) {
        switchActionButtonState(0, 2)
    }
    
    @objc func A4(_ sender: UIButton) {
        switchActionButtonState(0, 3)
    }
    
    @objc func A5(_ sender: UIButton) {
        switchActionButtonState(0, 4)
    }
    
    @objc func A6(_ sender: UIButton) {
        switchActionButtonState(0, 5)
    }
    
    @objc func A7(_ sender: UIButton) {
        switchActionButtonState(0, 6)
    }
    
    @objc func A8(_ sender: UIButton) {
        switchActionButtonState(0, 7)
    }
    
    @objc func A9(_ sender: UIButton) {
        switchActionButtonState(0, 8)
    }
    
    @objc func A10(_ sender: UIButton) {
        switchActionButtonState(0, 9)
    }
    
    @objc func A11(_ sender: UIButton) {
        switchActionButtonState(0, 10)
    }
    
    @objc func A12(_ sender: UIButton) {
        switchActionButtonState(0, 11)
    }
    
    @objc func B1(_ sender: UIButton) {
        switchActionButtonState(1, 0)
    }
    
    @objc func B2(_ sender: UIButton) {
        switchActionButtonState(1, 1)
    }
    
    @objc func B3(_ sender: UIButton) {
        switchActionButtonState(1, 2)
    }
    
    @objc func B4(_ sender: UIButton) {
        switchActionButtonState(1, 3)
    }
    
    @objc func B5(_ sender: UIButton) {
        switchActionButtonState(1, 4)
    }
    
    @objc func B6(_ sender: UIButton) {
        switchActionButtonState(1, 5)
    }
    
    @objc func B7(_ sender: UIButton) {
        switchActionButtonState(1, 6)
    }
    
    @objc func B8(_ sender: UIButton) {
        switchActionButtonState(1, 7)
    }
    
    @objc func B9(_ sender: UIButton) {
        switchActionButtonState(1, 8)
    }
    
    @objc func B10(_ sender: UIButton) {
        switchActionButtonState(1, 9)
    }
    
    func switchActionButtonState(_ p: Int, _ b: Int) {
        var forSheet = [String]()
        if p == 0 {
            forSheet = SheetFunctions.sheetOne
        } else {
            forSheet = SheetFunctions.sheetTwo
        }
        if SheetFunctions.pages[p].buttonState[b] == false {
            SheetFunctions.pages[p].buttonState[b] = true
            SheetFunctions.pages[p].sheetViews[b].backgroundColor = navy
            func_stringComponents.append(forSheet[b])
        } else {
            if let i = func_stringComponents.firstIndex(of: forSheet[b]) {
                func_stringComponents.remove(at: i)
            }
            SheetFunctions.pages[p].buttonState[b] = false
            SheetFunctions.pages[p].sheetViews[b].backgroundColor = teal
        }
    }
    
    func painToVal(_ val: Int) -> String {
        switch val {
        case 0:
            return "No pain"
        case 1:
            return "Mild pain"
        case 2:
            return "Discomforting"
        case 3:
            return "Tolerable"
        case 4:
            return "Distressing"
        case 5:
            return "Very distressing"
        case 6:
            return "Intense"
        case 7:
            return "Very intense"
        case 8:
            return "Intolerable"
        case 9:
            return "Extreme"
        case 10:
            return "Excruciating"
        default:
            return "No pain"
        }
    }
}


