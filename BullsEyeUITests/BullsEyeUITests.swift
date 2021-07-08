

import XCTest

class BullsEyeUITests: XCTestCase {

  var app : XCUIApplication!
  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

      try super.setUpWithError()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
      app = XCUIApplication()
      app.launch()
    }

  func test_game_style_switch(){
    
    
    //let app = XCUIApplication()
//    app/*@START_MENU_TOKEN@*/.segmentedControls.buttons["Slide"]/*[[".segmentedControls.buttons[\"Slide\"]",".buttons[\"Slide\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
//    app.staticTexts["Get as close as you can to: "]
    
    // given
    let slideButton = app.segmentedControls.buttons["Slide"]
    let typeButton = app.segmentedControls.buttons["Type"]
    let slideLabel = app.staticTexts["Get as close as you can to: "]
    let typeLabel = app.staticTexts["Guess where the slider is: "]
    
    // then
    if slideButton.isSelected {
      XCTAssertTrue(slideLabel.exists)
      XCTAssertFalse(typeLabel.exists)

      typeButton.tap()
      XCTAssertTrue(typeLabel.exists)
      XCTAssertFalse(slideLabel.exists)
    } else if typeButton.isSelected {
      XCTAssertTrue(typeLabel.exists) 
      XCTAssertFalse(slideLabel.exists)

      slideButton.tap()
      XCTAssertTrue(slideLabel.exists)
      XCTAssertFalse(typeLabel.exists)
    }
  }
  
  
}
