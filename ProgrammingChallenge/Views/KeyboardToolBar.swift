//
//  KeyboardToolBar.swift
//  ProgrammingChallenge
//
//  Created by PC on 10/25/17.
//  Copyright © 2017 John Smith. All rights reserved.
//

import Foundation
import UIKit

class KeyboardToolbar:UIToolbar{
  let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
  let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: nil)
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  func setupView(){
    sizeToFit()
    barTintColor = UIColor.groupTableViewBackground
    setItems([flexible,doneButton], animated: true)
    
  }
}

