//
//  AmeliaChatViewController.swift
//  JSULife
//
//  Created by Asaad on 10/23/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class AmeliaChatViewController: UITableViewController {
    var chatSceneContainer: UIView!
    var dialogue: [String]!
    let chatCellID = "chatCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ChatBubbleCell.self, forCellReuseIdentifier: chatCellID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        dialogue = AmeliaDialogue
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogue.count
    }
    
    var ameliaSet = [0, 4, 9, 14, 16, 18, 21, 24]
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatBubbleCell! = tableView.dequeueReusableCell(withIdentifier: chatCellID) as? ChatBubbleCell
        cell.messageLabel.text = dialogue[indexPath.row]
        
        if ameliaSet.contains(indexPath.row) {
            cell.ameliaView.isHidden = false
        } else {
            cell.ameliaView.isHidden = true
        }
        
        if dialogue[indexPath.row] == "" {
            cell.isResponse = true
        } else {
            cell.isResponse = false
        }
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
