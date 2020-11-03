//
//  FooterView.swift
//  JSULife
//
//  Created by JSU on 10/23/20.
//  Copyright © 2020 JSU.Life. All rights reserved.
//

import Foundation
import UIKit

class FooterView: UITableViewHeaderFooterView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: "addrHeader")
        //resizeFrame()
    }
    
    func resizeFrame() {
        backgroundColor = UIColor.yellow
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 0)
    }
}
