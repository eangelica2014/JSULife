//
//  AmeliaChatViewController.swift
//  JSULife
//
//  Created by Asaad on 10/23/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
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
    }
    
    func addYesButton() {
        let bottomPadding = self.view.safeAreaInsets.bottom
        let edgeSpace = (24 / 414) * UIScreen.main.bounds.width
        let interSpace = (13 / 414) * UIScreen.main.bounds.width
        let buttonWidth = (UIScreen.main.bounds.width - interSpace - (2 * edgeSpace)) / 2
        let buttonHeight = (52 / 176) * buttonWidth
        yesButton = UIButton(type: .system)
        yesButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        yesButton.setTitle("Yes", for: .normal)
        yesButton.setTitleColor(UIColor.white, for: .normal)
        yesButton.titleLabel?.font = UIFont(name: "FuturaPT-Book", size: 18.0)!
        yesButton.layer.cornerRadius = 6
        yesButton.backgroundColor = UIColor(displayP3Red: 6/255, green: 189/255, blue: 196/255, alpha: 1)
        yesButton.layer.position = CGPoint(x: edgeSpace + 0.5 * buttonWidth, y: UIScreen.main.bounds.height - bottomPadding - (2 * buttonHeight))
        self.view.addSubview(yesButton)
        yesButton.addTarget(self, action: #selector(yesButton(_:)), for: .touchUpInside)
    }
    
    func addNoButton() {
        let bottomPadding = self.view.safeAreaInsets.bottom
        let edgeSpace = (24 / 414) * UIScreen.main.bounds.width
        let interSpace = (13 / 414) * UIScreen.main.bounds.width
        let buttonWidth = (UIScreen.main.bounds.width - interSpace - (2 * edgeSpace)) / 2
        let buttonHeight = (52 / 176) * buttonWidth
        noButton = UIButton(type: .system)
        noButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        noButton.setTitle("No", for: .normal)
        noButton.setTitleColor(UIColor.white, for: .normal)
        noButton.layer.cornerRadius = 6
        noButton.titleLabel?.font = UIFont(name: "FuturaPT-Book", size: 18.0)!
        noButton.backgroundColor = UIColor(displayP3Red: 6/255, green: 189/255, blue: 196/255, alpha: 1)
        noButton.layer.position = CGPoint(x: UIScreen.main.bounds.width - edgeSpace - 0.5 * buttonWidth, y: UIScreen.main.bounds.height - bottomPadding - (2 * buttonHeight))
        self.view.addSubview(noButton)
        noButton.addTarget(self, action: #selector(noButton(_:)), for: .touchUpInside)
    }
    

    
    func queueAmelia() {
        dialogue.append(" ")
        tableView.reloadData()
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
    
    var ameliaSet = [0, 4, 8, 10, 12, 15, 18]
    var animated = [Int]()
    
    var typingCell: TypingCell!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("dialogue,", dialogue)
        
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
            if ameliaSet.contains(indexPath.row) {
                cell.ameliaView.isHidden = false
            } else {
                cell.ameliaView.isHidden = true
            }
            return cell
        }
        
        //Case 3: User Response
        if dialogue[indexPath.row] == "" || dialogue[indexPath.row] == "Yes" || dialogue[indexPath.row] == "[3] Discomforting" || dialogue[indexPath.row] == "Can’t move apart of my face and have trouble speaking correctly since my stroke." {
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
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerCellID) as! FooterView
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.40
    }
    
    var animationLoop = 0
    var didBeginSequence = false
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
                self.tableView.reloadData()
                scrollToBottom()
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
                    self.presentFunctions()
                }
                guard AmeliaDialogue[dialogue.count] != "" else {
                    return
                }
                let when = DispatchTime.now()
                DispatchQueue.main.asyncAfter(deadline: when + 0.15) {
                    self.queueAmelia()
                }
            }
        }
        //let bottomMessageIndex = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        //tableView.scrollToRow(at: bottomMessageIndex, at: .bottom, animated: true)
        //tableView.scrollRectToVisible(tableView.convert(tableView.tableFooterView?.bounds ?? CGRect.zero, from: tableView.tableFooterView), animated: true)
        //scrollToBottom()
    }
    
    func presentFunctions() {
        
    }
    
    func presentKeyboard() {
        dialogue.append("Can’t move apart of my face and have trouble speaking correctly since my stroke.")
        queueAmelia()
    }

    func scrollToBottom() {
        //tableView.reloadData()
        DispatchQueue.main.async(execute: { [self] in
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
        })
    }
    
    var sliderContainer: UIView!
    var painPrompt: UILabel!
    var sliderLabel: UILabel!
    var sliderVal = 0
    let edgeSpace = 14 as CGFloat
    var painSlider: UISlider!
    var sliderAcceptButton: UIButton!
    
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
    
    func addSliderLabel() {
        sliderLabel = UILabel()
        let font = UIFont(name: "FuturaPT-Book", size: 18)
        let str = "[10]" + " " + "No pain"
        let w = str.size(withAttributes: [.font: font!]).width
        let h = font!.lineHeight
        let frame = CGRect(x: 0, y: 0, width: w, height: h)
        sliderLabel.text = "[\(sliderVal)]" + " " + "No pain"
        sliderLabel.textColor = UIColor(displayP3Red: 247/255, green: 54/255, blue: 32/255, alpha: 1)
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
    
    @objc func sliderDidChange(_ sender: UISlider) {
        sliderVal = Int(painSlider.value)
        sliderLabel.text = "[\(sliderVal)]" + " " + "No pain"
    }
    
    @objc func sliderAcceptButton(_ sender: UIButton) {
        dialogue.append("[3] Discomforting")
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
        //
    }
    
    func presentYesNo() {
        addYesButton()
        addNoButton()
    }
    
    override func viewDidLayoutSubviews() {
        <#code#>
    }
}

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.size.height = 4
        return rect
    }
}
