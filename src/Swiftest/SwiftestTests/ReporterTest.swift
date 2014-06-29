import Swiftest
import XCTest

class ReporterTest : XCTestCase {
  var reporter = Reporter()
  var listener = SwiftestTests.MockListener(name : "my-listener")
  let spec = Specification(subject : "test-spec")
  let example = Example(subject : "test-example", fn:{})

  override func setUp() {
    reporter.addListener(listener)
  }

  func test_zeroListenersOnInit() {
    var reporter = Reporter()
    XCTAssertEqual(reporter.listeners.count, 1)
  }

  func test_addListener() {
    XCTAssertEqual(reporter.listeners.count, 2)

    let addedListener = reporter.listeners[0]

    XCTAssertEqual(addedListener.name, listener.name)
  }

  func test_notifySuiteStarted() {
    XCTAssertEqual(listener.suiteStartedCalls.count, 0)
    reporter.suiteStarted()
    XCTAssertEqual(listener.suiteStartedCalls.count, 1)
  }

  func test_notifySuiteFinished() {
    Swiftest.systemListener.onFinish = {}
    XCTAssertEqual(listener.suiteFinishedCalls.count, 0)
    reporter.suiteFinished()
    XCTAssertEqual(listener.suiteFinishedCalls.count, 1)
  }

  func test_notifySpecificationStarted() {
    XCTAssertEqual(listener.specificationStartedCalls.count, 0)
    reporter.specificationStarted(spec)

    XCTAssertEqual(listener.specificationStartedCalls[0], spec.subject)
  }

  func test_notifySpecificationFinished() {
    XCTAssertEqual(listener.specificationFinishedCalls.count, 0)
    reporter.specificationFinished(spec)

    XCTAssertEqual(listener.specificationFinishedCalls.count, 1)
    XCTAssertEqual(listener.specificationFinishedCalls[0], spec.subject)
  }

  func test_notifyExampleStarted() {
    XCTAssertEqual(listener.exampleStartedCalls.count, 0)
    reporter.exampleStarted(example)

    XCTAssertEqual(listener.exampleStartedCalls.count, 1)
    XCTAssertEqual(listener.exampleStartedCalls[0], example.subject)
  }

  func test_notifyExampleFinished() {
    XCTAssertEqual(listener.exampleFinishedCalls.count, 0)

    reporter.exampleFinished(example)
    XCTAssertEqual(listener.exampleFinishedCalls.count, 1)
    XCTAssertEqual(listener.exampleFinishedCalls[0], example.subject)
  }

  func test_notifyExpectationPassed() {
    let expectation = ScalarExpectation(subject: 1)
    expectation.toEqual(1)
    XCTAssertEqual(listener.expectationPassedCalls.count, 0)

    reporter.expectationPassed(expectation)
    XCTAssertEqual(listener.expectationPassedCalls.count, 1)
    XCTAssertEqual(listener.expectationPassedCalls[0], .Pass)
  }

  func test_notifyExpectationFailed() {
    let expectation = ScalarExpectation(subject: 1)
    expectation.toEqual(2)
    XCTAssertEqual(listener.expectationFailedCalls.count, 0)

    reporter.expectationFailed(expectation)
    XCTAssertEqual(listener.expectationFailedCalls.count, 1)
    XCTAssertEqual(listener.expectationFailedCalls[0], .Fail)
  }
}