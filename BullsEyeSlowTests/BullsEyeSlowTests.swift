

import XCTest
@testable import BullsEye

var  sut: URLSession!
let networkMonitor = NetworkMonitor.shared

class BullsEyeSlowTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      try super.setUpWithError()
      sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      sut = nil
      try super.tearDownWithError()
    }

  func test_api_call_get_https_status_code_200() throws{
    //skip the test in case of no internet
    try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test.")

    //given
    let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
    let url = URL(string: urlString)!
    
    //set the expectation, test case will wait for expecation to get fulfilled
    let promise = expectation(description: "Status code: 200")
    
    //when
    let dataTask = sut.dataTask(with: url) { (_, response, error) in
      //then
      if let error = error{
        XCTFail("Error: \(error.localizedDescription)")
        return
      }
      else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
        if statusCode == 200{
          promise.fulfill()   //fulfill the promise
        }else{
          XCTFail("Status code: \(statusCode)")
        }
      }
    }
    dataTask.resume()
    
    //wait for the expectation
    wait(for: [promise], timeout: 10)
    
  }
  
  func test_api_call_completes() throws{
    //skip the test in case of no internet
    try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test.")

    //given
    let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
      //"http://www.randomnumberapi.com/test"
    let url = URL(string: urlString)!
    
    let promise = expectation(description: "Completion Handler invoked")
    
    var statusCode : Int?
    var responseError : Error?
    
    //when
    let dataTask = sut.dataTask(with: url) { (_, response, error) in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask.resume()
    wait(for: [promise], timeout: 10)
    
    //then
    XCTAssertNil(responseError)
    XCTAssertEqual(statusCode, 200)
  }
   

}
