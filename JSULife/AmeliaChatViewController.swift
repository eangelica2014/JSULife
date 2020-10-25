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
    
    let tableContainer = UIView(frame: UIScreen.main.bounds)
    
    let tableView = UITableView()
    
    var yesButton: UIButton!
    var noButton: UIButton!
    
    var dialogueCounter = 0
    var typingAnimator: TypingAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableContainer.backgroundColor = UIColor.yellow
        tableView.frame = UIScreen.main.bounds
        tableView.delegate = self
        tableView.dataSource = self
        self.tableContainer.addSubview(tableView)
        self.view.addSubview(tableContainer)
        
        tableView.register(ChatBubbleCell.self, forCellReuseIdentifier: chatCellID)
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
    
    @objc func yesButton(_ sender: UIButton) {
        //add Yes Cell to Table View
        //then retrigger Amelia
        dialogue.append("Yes")
        yesButton.removeFromSuperview()
        noButton.removeFromSuperview()
        queueAmelia()
    }
    
    func queueAmelia() {
        dialogue.append(" ")
        tableView.reloadData()
    }
    
    @objc func noButton(_ sender: UIButton) {
        
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
    
    var currentCell: ChatBubbleCell!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatBubbleCell! = tableView.dequeueReusableCell(withIdentifier: chatCellID) as? ChatBubbleCell
        print("cellAdress,", Unmanaged.passUnretained(cell).toOpaque())
    
        if cell.Typing_Animator == nil {
            let typingAnimator = TypingAnimator()
            typingAnimator.animDelegateVC = self
            print("initAnim")
            typingAnimator.cell = cell
            cell.Typing_Animator = typingAnimator
        }
        
        if dialogue[indexPath.row] != " " {
            cell.isProcessing = false
        } else {
            cell.isProcessing = true
        }
        
        cell.messageLabel.text = dialogue[indexPath.row]
        
        if ameliaSet.contains(indexPath.row) {
            cell.ameliaView.isHidden = false
        } else {
            cell.ameliaView.isHidden = true
        }
        
        if dialogue[indexPath.row] == "[insert image]" {
            cell.isImageType = true
        } else {
            cell.isImageType = false
        }
                
        if dialogue[indexPath.row] == "" || dialogue[indexPath.row] == "Yes" {
            cell.isResponse = true
        } else {
            cell.isResponse = false
        }
 
        currentCell = cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    var animationLoop = 0
    var didBeginSequence = false
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == currentCell.c3!.animation(forKey: "beginSequence") {
            currentCell.Typing_Animator!.S1()
        }
        
        if anim == currentCell.c2!.animation(forKey: "B1") {
            currentCell.Typing_Animator!.S2()
        }
        
        if anim == currentCell.c3!.animation(forKey: "C1") {
            currentCell.isAnimating = false
            if animationLoop < 1 {
                currentCell.Typing_Animator!.beginSequence()
                animationLoop += 1
            } else {
                animationLoop = 0
                print("dialoguecount,", dialogue.count)
                if dialogue.count == 3 {
                    self.presentYesNo()
                }
                dialogue[dialogue.count - 1] = AmeliaDialogue[dialogue.count - 1]
                self.tableView.reloadData()

                guard AmeliaDialogue[dialogue.count] != "" else {
                    
                    return
                }
                let when = DispatchTime.now()
                DispatchQueue.main.asyncAfter(deadline: when + 0.15) {
                    self.queueAmelia()
                }
            }
        }
    }
    
    func presentYesNo() {
        addYesButton()
        addNoButton()
    }
    

}

