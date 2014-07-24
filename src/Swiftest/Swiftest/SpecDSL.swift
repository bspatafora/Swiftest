public func before(hook: HookType, fn: VoidBlk) {
  __current().before(hook, fn: fn)
}

public func before(fn: VoidBlk) { before(.each, fn) }

public func describe(
  subject: String,
  fn: VoidBlk,
  file: String = __FILE__,
  line: Int = __LINE__
) -> Specification {
  return Swiftest.describe(
    subject,
    fn: fn,
    cursor: Cursor(file: file, line: line)
  )
}

public func define<T>(fn: @auto_closure () -> T) -> Void -> T {
  return __current().define(fn)
}

public func example(
  subject: String,
  _ fn: VoidBlk = nullFn,
  file: String = __FILE__,
  line: Int = __LINE__
) {
  __current().example(subject, fn: fn, cursor: Cursor(file: file, line: line))
}

public func it(
  desc: String,
  _ fn: VoidBlk = nullFn,
  file: String = __FILE__,
  line: Int = __LINE__
) {
  example(desc, fn, file: file, line: line)
}

public func xit(
  desc: String,
  _ fn: VoidBlk = nullFn,
  file: String = __FILE__,
  line: Int = __LINE__
) {
  example(desc, file: file, line: line)
}

public func __current() -> Specification {
  return Swiftest.context.current()
}
