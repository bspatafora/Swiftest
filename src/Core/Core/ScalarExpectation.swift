public class ScalarExpectation<T:Equatable> : Expectation {
  var subject: T?
  
  public init(subject: T?, cursor: Cursor = nullCursor) {
    self.subject = subject
    super.init(cursor: cursor)
  }
  
  public func to(matcher: EquatableMatcher<T>) {
    _assert(matcher.assertion(subject))
  }
  
  public func notTo(matcher: EquatableMatcher<T>) {
    _assert(matcher.assertion(subject, reverse: true))
  }
}

//public func expect<T:Equatable>(
//  subject: T?,
//  file: String = __FILE__,
//  line: Int = __LINE__
//) -> ScalarExpectation<T> {
//  return Swiftest.context.currentExample.addExpectation(
//    ScalarExpectation(subject: subject, cursor: Cursor(file: file, line: line))
//  )
//}