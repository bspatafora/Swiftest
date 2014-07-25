Swiftest
========

Experimental BDD "spec" framework for Apple's
[Swift](https://developer.apple.com/swift/) language.
Total work-in-progress, but it is currently usable, if you check out the Example
project. The goal is for the core components to be written in pure Swift in a
cleanly extensible way.

Swiftest's runner is configurable with a simple closure, so the behavior can be
easily overridden, while still preserving the internal components. You can also
register listeners that will fire as the test suite executes to easily make
new formatters and/or reporters.

Inspired heavily by
[RSpec](https://github.com/rspec/rspec), [Jasmine](http://jasmine.github.io/),
[OCDSpec2](https://github.com/OCDSpec/OCDSpec2) and
[Kiwi](https://github.com/kiwi-bdd/Kiwi)

### What's done:
* specification DSL
* simple expectations and assertions for most types
* console reporter
* "example" project
* nested describe blocks
* auto-loading spec files
* "void" closure matchers (more to come)
* beforeEach / beforeAll hooks
* Mac OSX target template
* File template

### Stuff to Do (before any kind of "version")
* iPhone target (scripts exist for this, just need to implement)
* Time output for test suite stuff

## Down the Road
* XCode error/warn reporter integration
* CocoaPod installation (?)
* command-line interface (?)

### Example

```swift
import Swiftest

// create a class that inherits from SwiftestSuite (it's just NSObject)
// and define the 'spec' member property of that class using `describe`

class SampleSpec : SwiftestSuite {
  let spec = describe("Swiftest") {
    it("adds 1 + 1!") {
      expect(1 + 1).toEqual(2)
    }

    it("knows true from false!") {
      expect(true).toBeTrue()
      expect(true).not().toBeFalse()
    }

    example("comparing letters of the alphabet!") {
      expect("abc").toEqual("abc")
      expect("abc").toContain("b")
      expect("abc").toStartWith("a")
      expect("abc").toEndWith("c")
    }

    it("knows what stuff is NOT other stuff!") {
      expect(2 + 2).not().toEqual(5)
    }

    describe("arrays!") {
      example("special assertions for array types!") {
        expect([1, 2, 3]).toEqual([1, 2, 3])

        expect([1, 2, 3]).toContain(1)
        expect([1, 2, 3]).toContain(1, 3)
      }
    }

    it("does nifty stuff with closures") {
      var a = 0

      expect({ a += 1 }).toChange(a).to(1)
      expect({ a += 1 }).toChange(a).from(1).to(2)
      expect({ a += 2 }).toChange(a).by(2)
    }

    example("dictionaries have special assertions too!") {
      expect([ "key" : "val" ]).toEqual([ "key" : "val"])
      expect([ "key" : "val" ]).toHaveKey("key")
      expect([ "key" : "val" ]).toHaveValue("val")
    }

    example("your own classes!") {
      // Person is a class that implements Comparable
      let person1 = Person(name: "Bob")
      let person2 = Person(name: "Alice")

      expect(person1).not().toEqual(person2)
    }
  }
}
```

### Definitions
Definitions are a simple way to define lazily-evaluated functions to
encapsulate values your specs may need, similar to RSpecs `let`. The values
are memoized in each example, and reset after each example is run.

Compare this to declaring an optional value and then setting that value in a
`beforeEach` block and unwrapping it explicity before use.

```swift
class DefinitionExample : SwiftestSuite {
  let spec = describe("definitions") {
    var subject = define(Counter(number: 5))

    it("creates the object when you call the function") {
      subject().increment()
      expect(subject().number).toEqual(6)
    }

    it("resets the object between each example") {
      expect(subject().number).toEqual(5)
    }
  }
}
```

### Installation
NOTE: We're working on improving the installation process.

Swiftest requires XCode6-Beta4

For now, clone this repository and add the Swiftest `xcodeproj` to your own
project. Create a command-line executable target and place the following in
`main.swift`:

```swift
import Swiftest

Swiftest.reporter.addListener(ConsoleListener())
Swiftest.run()
```

Then, configure the build to link with libSwiftest and
run the scheme (Cmd + R) with the command-line executable.
