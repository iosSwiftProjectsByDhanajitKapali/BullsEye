

import XCTest
@testable import BullsEye


class BullsEyeFakeTests: XCTestCase {

  var sut: BullsEyeGame!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = BullsEyeGame()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }


  func test_start_new_round_uses_random_value_from_api_request(){
    //given
    //create fake data
    let stubbedData = "[1]".data(using: .utf8)
    let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
    let url = URL(string: urlString)!
    //create fake response
    let stubbedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
    //create fake url session
    let urlSessionStub = URLSessionStub(data: stubbedData, response: stubbedResponse, error: nil)
    
    sut.urlSession = urlSessionStub
    let promise = expectation(description: "Value Recieved")
    
    //when
    sut.startNewRound {
      //then
      XCTAssertEqual(self.sut.targetValue, 1)   //checking if parsing is done right or not
      promise.fulfill()
    }
    wait(for: [promise], timeout: 5)
  }
}
