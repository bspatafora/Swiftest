import XCTest
import SwiftestCore

class SwiftestDood : Comparable {
  var name : String
  
  init(name : String) {
    self.name = name
  }
}

@infix func ==(dude1 : SwiftestDood, dude2 : SwiftestDood) -> Bool {
  return dude1.name == dude2.name
}

@infix func <(dude1 : SwiftestDood, dude2 : SwiftestDood) -> Bool {
  return dude1.name < dude2.name
}

@infix func >=(dude1 : SwiftestDood, dude2 : SwiftestDood) -> Bool {
  return dude1.name >= dude2.name
}

@infix func <=(dude1 : SwiftestDood, dude2 : SwiftestDood) -> Bool {
  return dude1.name <= dude2.name
}


class ExpectationTest : XCTestCase {
  
  let expectation = ScalarExpectation(actual: "actual")
  
  func test_toEqual_pass() {
    expectation.toEqual("actual")
    XCTAssertEqual(expectation.result.status, ExampleStatus.Pass);
  }
  
  func test_toEqual_fail() {
    expectation.toEqual("not-actual")
    XCTAssertEqual(expectation.result.status, ExampleStatus.Fail);
  }
  
  func test_toEqual_multiple() {
    expectation.toEqual("actual")
    expectation.toEqual("not-actual")
    
    XCTAssertEqual(expectation.result.status, ExampleStatus.Fail);
  }
  
  func test_not_toEqual() {
    expectation.not().toEqual("not-actual")
    XCTAssertEqual(expectation.result.status, ExampleStatus.Pass);
  }
  
  func test_toEqual_int() {
    let ex = ScalarExpectation(actual: 1)
    ex.toEqual(1)
    XCTAssertEqual(ex.result.status, ExampleStatus.Pass);
  }
  
  func test_toEqual_withClass() {
    let dude1 = SwiftestDood(name: "dude1")
    let dude2 = SwiftestDood(name: "dude2")
    let ex = ScalarExpectation(actual: dude1)
    ex.toEqual(dude2)
    
    XCTAssertEqual(ex.result.status, ExampleStatus.Fail)
  }
  
  func test_toBeNil_withNil() {
    var dude1 : SwiftestDood?
    let ex = ScalarExpectation(actual: dude1)

    ex.toBeNil()
    
    XCTAssertEqual(ex.result.status, ExampleStatus.Pass)
  }
  
  func test_toBeNil_withNonNil() {
    var dude1 : SwiftestDood? = SwiftestDood(name: "dude1")
    let ex = ScalarExpectation(actual: dude1)
    
    ex.toBeNil()
    
    XCTAssertEqual(ex.result.status, ExampleStatus.Fail)
  }
  
  func testComparisons() {
    let ex = ScalarExpectation(actual: 1)
    
    ex.toBeGreaterThan(0)
    ex.toBeGreaterThanOrEqualTo(0)
    ex.toBeGreaterThanOrEqualTo(1)
    ex.toBeLessThan(2)
    ex.toBeLessThanOrEqualTo(2)
    ex.toBeLessThanOrEqualTo(1)
    ex.toBeGreaterThanOrEqualTo(nil)
    
    XCTAssertEqual(ex.result.status, ExampleStatus.Pass)
  }
}