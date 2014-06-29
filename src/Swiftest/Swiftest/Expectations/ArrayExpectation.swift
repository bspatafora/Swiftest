class ArrayExpectation<T:Comparable> : BaseExpectation {
  typealias List = T[]
  var subject : List[]

  init(subject: List, cursor: Cursor = Util.nullCursor) {
    self.subject = [subject]
    super.init()
    self.cursor = cursor
  }

  func not() -> ArrayExpectation {
    self._reverse = !_reverse
    return self
  }

  func toEqual(expected: List) {
    _assert(
      _subject() == expected,
      msg: "expected <\(_subject())> to\(_includeNot()) equal <\(expected)>"
    )
  }

  func toContain(expected: T...) {
    _assert(
      !_subject().filter() { (let subjectEl) in
        !expected.filter({ el in el == subjectEl }).isEmpty
      }.isEmpty,
      msg: "expected <\(_subject())>\(_includeNot()) to contain <\(expected)>"
    )
  }

  func _subject() -> List {
    return subject[0]
  }
}