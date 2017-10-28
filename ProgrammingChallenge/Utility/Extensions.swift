//
//  Extensions.swift
//  ProgrammingChallenge
//
//  Created by PC on 10/25/17.
//  Copyright © 2017 John Smith. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
  func setWidthConstraint(_ width:CGFloat,priority:UILayoutPriority){
    let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
    widthConstraint.priority = priority
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([widthConstraint])
  }
  func setHeightConstraint(_ height:CGFloat,priority:UILayoutPriority){
    let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
    heightConstraint.priority = priority
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([heightConstraint])
  }
  func pinToSuperView(){
    let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.superview, attribute: .trailing, multiplier: 1, constant: 0)
    let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.superview, attribute: .leading, multiplier: 1, constant: 0)
    let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1, constant: 0)
    let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1, constant: 0)
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([trailingConstraint,leadingConstraint,topConstraint,bottomConstraint])
  }
  func setLeadingInSuperview(_ margin:CGFloat,priority:UILayoutPriority){
    let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.superview!, attribute: .leading, multiplier: 1, constant: margin)
    leadingConstraint.priority = priority
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([leadingConstraint])
  }
  func setTrailingInSuperview(_ margin:CGFloat,priority:UILayoutPriority){
    let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.superview!, attribute: .trailing, multiplier: 1, constant: margin)
    trailingConstraint.priority = priority
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([trailingConstraint])
  }
  func setTopInSuperview(_ margin:CGFloat,priority:UILayoutPriority){
    let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview!, attribute: .top, multiplier: 1, constant: margin)
    topConstraint.priority = priority
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([topConstraint])
  }
  func setBottomInSuperview(_ margin:CGFloat,priority:UILayoutPriority){
    let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview!, attribute: .bottom, multiplier: 1, constant: margin)
    bottomConstraint.priority = priority
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([bottomConstraint])
  }
}

