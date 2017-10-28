
//
//  ProgrammingChallengeTests.swift
//  ProgrammingChallengeTests
//
//  Created by PC on 10/25/17.
//  Copyright © 2017 John Smith. All rights reserved.
//

import XCTest
@testable import ProgrammingChallenge

class ProgrammingChallengeTests: XCTestCase {
  let grid1 = [[3,4,1,2,8,6],[6,1,8,2,7,4],[5,9,3,9,9,5],[8,4,1,3,2,6],[3,7,2,8,6,4]]
  let grid2 = [[3,4,1,2,8,6],[6,1,8,2,7,4],[5,9,3,9,9,5],[8,4,1,3,2,6],[3,7,2,1,2,3]]
  let grid3 = [[19,10,19,10,19],[21,23,20,19,12],[20,12,20,11,10]]
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testGrid1() {
    let output = findPathOfLowestCost(grid1, maximumCost: 50)
    XCTAssertNotNil(output)
    XCTAssertTrue(output!.0)
    XCTAssertEqual(16,output!.1)
    XCTAssertEqual([1,2,3,4,4,5], output!.2)
  }
  func testGrid2(){
    let output = findPathOfLowestCost(grid2, maximumCost: 50)
    XCTAssertNotNil(output)
    XCTAssertTrue(output!.0)
    XCTAssertEqual(11,output!.1)
    XCTAssertEqual([1,2,1,5,4,5], output!.2)
  }
  func testGrid3(){
    let output = findPathOfLowestCost(grid3, maximumCost: 50)
    XCTAssertNotNil(output)
    XCTAssertFalse(output!.0)
    XCTAssertEqual(48,output!.1)
    XCTAssertEqual([1,1,1], output!.2)
  }
}
