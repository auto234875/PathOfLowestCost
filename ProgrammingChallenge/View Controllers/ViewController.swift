
//
//  ViewController.swift
//  ProgrammingChallenge
//
//  Created by PC on 10/25/17.
//  Copyright © 2017 John Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
  private lazy var inputAlert:UIAlertController = {
    let inputAlert = UIAlertController(title: "Input the number of rows and columns", message: nil, preferredStyle: .alert)
    inputAlert.addTextField(configurationHandler: {(numberOfRowsTextField) in
      numberOfRowsTextField.keyboardType = .numberPad
      numberOfRowsTextField.placeholder = "Enter the number of rows"
    })
    inputAlert.addTextField(configurationHandler: {(numberOfColumnsTextField) in
      numberOfColumnsTextField.keyboardType = .numberPad
      numberOfColumnsTextField.placeholder = "Enter the number of columns"
    })
    
    return inputAlert
  }()
  private lazy var inputOutputCollectionView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 44, height: 44)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.clear
    collectionView.isScrollEnabled = true
    return collectionView
  }()
  fileprivate var inputArray:[[Int]] = Array(repeating: Array(repeating: 0, count: 6), count: 5)
  fileprivate let sumLabel = UILabel()
  fileprivate let pathCompletedLabel = UILabel()
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showInputAlert()
    view.addSubview(inputOutputCollectionView)
    view.addSubview(sumLabel)
    view.addSubview(pathCompletedLabel)
    view.backgroundColor = UIColor.black
    let priority = UILayoutPriority(1000)
    inputOutputCollectionView.setTopInSuperview(65,priority:priority)
    inputOutputCollectionView.setLeadingInSuperview(0,priority:priority)
    inputOutputCollectionView.setTrailingInSuperview(0,priority:priority)
    inputOutputCollectionView.setBottomInSuperview(0,priority:priority)
    inputOutputCollectionView.register(GridCell.self, forCellWithReuseIdentifier: "GridCell")
    inputOutputCollectionView.dataSource = self
    inputOutputCollectionView.delegate = self
    sumLabel.backgroundColor = UIColor.white
    sumLabel.textAlignment = .center
    sumLabel.setLeadingInSuperview(0, priority: priority)
    sumLabel.setTopInSuperview(20, priority: priority)
    sumLabel.setWidthConstraint(100,priority:priority)
    sumLabel.setHeightConstraint(44,priority:priority)
    pathCompletedLabel.backgroundColor = UIColor.white
    pathCompletedLabel.textAlignment = .center
    pathCompletedLabel.setLeadingInSuperview(105, priority: priority)
    pathCompletedLabel.setTopInSuperview(20, priority: priority)
    pathCompletedLabel.setWidthConstraint(100, priority: priority)
    pathCompletedLabel.setHeightConstraint(44, priority: priority)
  }
  private func showInputAlert(){
    inputAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned inputAlert] Void in
      guard let numberOfRowsText = inputAlert.textFields?[0].text, let numberOfRows = Int(numberOfRowsText),numberOfRows > 0 || numberOfRows <= 10 else{
        self.showWarningAlert("Enter a number of rows that is mininum 1 and maximum 10")
        return
      }
      guard let numberOfColumnsText = inputAlert.textFields?[1].text, let numberOfColumns = Int(numberOfColumnsText), numberOfColumns >= 5 else{
        self.showWarningAlert("Enter a number of columns that is minimum 5")
        return
      }
      self.inputArray = Array(repeating: Array(repeating: 0, count: numberOfColumns), count: numberOfRows)
      self.inputOutputCollectionView.reloadData()
    }))
    self.present(inputAlert, animated: true, completion: nil)
  }
  private func showWarningAlert(_ message:String){
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .cancel, handler: {[unowned self] (_)->Void in
      self.present(self.inputAlert, animated: true, completion: nil)
    })
    alert.addAction(ok)
    self.present(alert, animated: true, completion:nil)
  }
}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate{
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let text = textField.text,let value = Int(text) else{
      textField.text = "0"
      return
    }
    guard let cell = textField.superview?.superview as? GridCell,let indexPath = inputOutputCollectionView.indexPath(for: cell) else{
      return
    }
    inputArray[indexPath.row][indexPath.section] = value
    guard let result = findPathOfLowestCost(inputArray,maximumCost: 50) else{
      return
    }
    pathCompletedLabel.text = result.0 ? "YES" : "NO"
    sumLabel.text = "SUM = " + String(result.1)
    for (rowIndex,row) in inputArray.enumerated(){
      for (columnIndex,_) in row.enumerated(){
        let cell = inputOutputCollectionView.cellForItem(at: IndexPath(row: rowIndex, section: columnIndex))
        cell?.contentView.layer.borderWidth = 0
      }
    }
    for (column,row) in result.2.enumerated(){
      let indexPath = IndexPath(row: row - 1, section: column)
      guard let cell = inputOutputCollectionView.cellForItem(at: indexPath) else{
        return
      }
      cell.contentView.layer.borderWidth = 2
    }
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
    cell.inputTextField.text = String(self.inputArray[indexPath.row][indexPath.section])
    cell.inputTextField.delegate = self
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.inputArray.count
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.inputArray[0].count
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsetsMake(0, 0, 0, 1)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
}
