
//
//  GridCell.swift
//  ProgrammingChallenge
//
//  Created by PC on 10/25/17.
//  Copyright © 2017 John Smith. All rights reserved.
//

import Foundation
import UIKit
class GridCell:UICollectionViewCell{
  let inputTextField = UITextField()
  private let keyboardToolbar = KeyboardToolbar()
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  private func setupView(){
    self.contentView.layer.borderColor = UIColor.red.cgColor
    self.contentView.backgroundColor = UIColor.white
    self.contentView.addSubview(inputTextField)
    let priority = UILayoutPriority(1000)
    inputTextField.setTopInSuperview(5, priority: priority)
    inputTextField.setLeadingInSuperview(5, priority: priority)
    inputTextField.setTrailingInSuperview(-5, priority: priority)
    inputTextField.setBottomInSuperview(-5, priority: priority)
    inputTextField.inputAccessoryView = keyboardToolbar
    inputTextField.textAlignment = .center
    inputTextField.font = UIFont.systemFont(ofSize: 10)
    keyboardToolbar.doneButton.target = self
    keyboardToolbar.doneButton.action = #selector(handleReturn)
  }
  @objc private func handleReturn(){
    inputTextField.resignFirstResponder()
  }
}
