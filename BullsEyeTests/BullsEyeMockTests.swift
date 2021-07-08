

import XCTest
@testable import BullsEye

class MockUserDefaults: UserDefaults {
  var gameStyleChanged = 0
  override func set(_ value: Int, forKey defaultName: String) {
    if defaultName == "gameStyle" {
      gameStyleChanged += 1
    }
  }
}

class BullsEyeMockTests: XCTestCase {
  
  var sut: ViewController!
  var mockUserDefaults: MockUserDefaults!
  
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try super.setUpWithError()
    sut = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController
    
    mockUserDefaults = MockUserDefaults(suiteName: "testing")
    sut.defaults = mockUserDefaults
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    sut = nil
    mockUserDefaults = nil
    try super.tearDownWithError()
  }
  
  func test_game_style_can_be_changed(){
    //given
    let segmentedControl = UISegmentedControl()
    
    //when
    XCTAssertEqual(mockUserDefaults.gameStyleChanged, 0, "gameStyleChanged should be 0 before sendActions")
    segmentedControl.addTarget(sut, action: #selector(ViewController.chooseGameStyle(_:)), for: .valueChanged)
    segmentedControl.sendActions(for: .valueChanged)
    
    //then
    XCTAssertEqual(mockUserDefaults.gameStyleChanged, 1, "gameStyle user default wasn't changed")
  }
  
  
  
  
}
