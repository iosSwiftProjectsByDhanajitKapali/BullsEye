

import XCTest
@testable import BullsEye

var sut : BullsEyeGame!   //system under test

class BullsEyeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      try super.setUpWithError()
      sut = BullsEyeGame()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      sut = nil
      try super.tearDownWithError()
    }

  func test_score_is_computed_when_guess_is_higher_than_target(){
    //given
    let guess = sut.targetValue + 5
    
    //when
    sut.check(guess: guess)
    
    //then
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
  
  func test_score_is_computed_when_guess_is_lower_than_target(){
    //given
    let guess = sut.targetValue - 5
    
    //when
    sut.check(guess: guess)
    
    //then
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
    
  
  //to test the performance
  func test_score_is_computed_performance(){
    measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric() ]) {
      sut.check(guess: 100)
    }
  }

}
