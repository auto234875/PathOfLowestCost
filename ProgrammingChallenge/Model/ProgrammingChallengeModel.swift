//
//  ProgrammingChallengeModel.swift
//  ProgrammingChallenge
//
//  Created by PC on 10/25/17.
//  Copyright © 2017 John Smith. All rights reserved.
//

import Foundation
//Given an 2D grid of integers and a maximum cost, this function returns whether it's possible to find a path through this grid while keeping under the cost limit, the path traveled and the cost 
func findPathOfLowestCost(_ input:[[Int]],maximumCost:Int)->(Bool,Int,[Int])?{
  //Input must have at least one row
  guard !input.isEmpty else{
    return nil
  }
  for row in input {
    //Check for empty rows
    if row.isEmpty{
      return nil
    }
    //Check if there is at least 5 columns in each row
    if row.count < 5{
      return nil
    }
  }
  let pathCost = buildPathCost(input)
  let path = extractPathOfLowestCost(input, pathCost: pathCost)
  let output = extractOutput(input, path: path,maximumCost: maximumCost)
  return output
}
//This function finds the actual cost, path traveled before aborting and whether the path will abort, given a grid of integers as input, the path of lowest cost through this grid and the maximum cost limit before aborting the path
private func extractOutput(_ input:[[Int]],path:[Int],maximumCost:Int)->(Bool,Int,[Int]){
  let rowCount = input.count
  let columnCount = input[0].count
  var sum = 0
  var outputPath:[Int] = []
  for column in 0...columnCount - 1{
    for row in 0...rowCount - 1{
      if row == path[column] - 1{
        let newSum = sum + input[row][column]
        if newSum > maximumCost{
          return (false,sum,outputPath)
        }else{
          sum = newSum
          outputPath.append(path[column])
        }
      }
    }
    
  }
  return (true,sum,outputPath)
}

//This function finds the path of lowest cost given an array of sum of lowest cost for each row
private func extractPathOfLowestCost(_ input:[[Int]],pathCost:[[Int]])->[Int]{
  let numberOfColumns = input[0].count
  var path:[Int] = Array(repeating: 0, count: numberOfColumns)
  var row = 0
  //Set the top right cell as the starting point. Walk through each row and check if the cell in the last column is less than the cell in the starting point, then set that as the new starting point
  for (index,_) in input.enumerated(){
    if index == 0{
      continue
    }
    if pathCost[index][numberOfColumns - 1] < pathCost[row][numberOfColumns - 1]{
      row = index
    }
  }
  var column = numberOfColumns - 1
  //Walk through each column from right to left and find the cell with lowest cost
  while column > 0 {
    //The cell index in the path array correspond to the column of the path of lowest cost. Each cell value correspond to the row index. We add one to the row here to match the output format for row index
    path[column] = row + 1
    let currentCost = pathCost[row][column]
    //if the current point is not on the first row
    if row > 0{
      //check if the upper left diagonal cell is where the path of lowest cost should travel
      let upperLeftCellSum = pathCost[row - 1][column - 1] + input[row][column]
      if upperLeftCellSum == currentCost{
        row -= 1
        column -= 1
        continue
      }
    }
    //if the current point is on the 1st row
    if row == 0{
      //check if the upper left diagonal cell in the last row is where the path of lowest cost should travel
      let upperLeftCellSum = pathCost[input.count - 1][column - 1] + input[row][column]
      if upperLeftCellSum == currentCost{
        row = input.count - 1
        column -= 1
        continue
      }
    }
    //if the current point is not on the last row
    if row < input.count - 1{
      //check if the lower left diagonal cell is where the path of lowest cost should travel
      let lowerLeftDiagonalSum = pathCost[row + 1][column - 1] + input[row][column]
      if lowerLeftDiagonalSum == currentCost{
        row += 1
        column -= 1
        continue
      }
    }
    //if the current point is on the last row
    if row == input.count - 1{
      //check if the lower left diagonal cell in the first row is where the path of lowest cost should travel
      let lowerLeftDiagonalSum = pathCost[0][column - 1] + input[row][column]
      if lowerLeftDiagonalSum == currentCost{
        row = 0
        column -= 1
        continue
      }
    }
    column -= 1
  }
  path[0] = row + 1
  return path
}

//This function walks through a 2D array of integers by column and finds the lowest possible cost for each path for each row
private func buildPathCost(_ input:[[Int]])->[[Int]]{
  let numberOfRows = input.count
  let numberOfColumn = input[0].count
  var pathCost = Array(repeating: Array(repeating: 0, count: numberOfColumn), count: numberOfRows)
  //Fill in the first column
  for i in 0...numberOfRows - 1{
    pathCost[i][0] = input[i][0]
  }
  for column in 1...numberOfColumn - 1{
    //Find the next cell to traverse through
    for row in 0...numberOfRows - 1{
      var candidateRow = row
      //If the cell is not in the first row, check if the left upper diagonal cell has a value greater
      //than the cell in the left adjacent cell
      if row > 0 && pathCost[row - 1][column - 1] < pathCost[candidateRow][column - 1]{
        candidateRow = row - 1
      }
      //If the cell is in the first row, check if the left diagonal cell in the last row has a value greater than the left adjacent cell
      if row == 0 && pathCost[numberOfRows - 1][column - 1] < pathCost[candidateRow][column - 1]{
        candidateRow = numberOfRows - 1
      }
      //If the cell is not in the last row, check if the left lower diagonal cell has a value greater than the current lowest cost cell
      if row < numberOfRows - 1 && pathCost[row + 1][column - 1] < pathCost[candidateRow][column - 1]{
        candidateRow = row + 1
      }
      //If the cell is in the last row, check if the left diagonal cell in the first row has a value greater than the current lowest cost cell
      if row == numberOfRows - 1 && pathCost[0][column - 1] < pathCost[candidateRow][column - 1]{
        candidateRow = 0
      }
      //set the next value of the current pathCost cell to be equal to the sum of the lowest cost cell and the current cell
      pathCost[row][column] = pathCost[candidateRow][column - 1] + input[row][column]
    }
  }
  return pathCost
}

