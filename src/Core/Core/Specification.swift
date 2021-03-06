public class Specification : HasStatus {
  public let subject: String
  public var timer = Timer()

  public let cursor: Cursor
  public let fn: VoidBlk

  public var children: [Specification] = []
  public var definitions: [Resettable] = []
  public var examples: [Example] = []
  public var hooks = Hooks()
  public var parents: [Specification] = []
  public var status: Status {
    get { return Status.has(.Fail, within: self.examples) ? .Fail : .Pass }
  }
  
  public init(subject: String, _ fn: VoidBlk, cursor: Cursor = nullCursor) {
    self.subject = subject
    self.fn = fn
    self.cursor = cursor
  }
  
  public func add(example: Example) { examples.append(example) }

  public func add(spec: Specification) {
    spec.addParent(self)
    children.append(spec)
  }
  
  public func addParent(parent: Specification) {
    parents.append(parent)
    hooks = parent.hooks
    definitions += parent.definitions
  }
  
  public func add<T>(defn: Definition<T>) {
    definitions.append(defn)
  }
  
  public func addHook(hookType: Hooks.HookType, hook: VoidBlk) {
    hooks.add(hookType, hook)
  }
}
