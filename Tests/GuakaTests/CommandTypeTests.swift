import XCTest
@testable import Guaka

class CommandTypeTests: XCTestCase {

	static var allTests: [(String, (CommandTypeTests) -> () throws -> Void)] {
		return [
			("testItCanGenerateFlagSetForRoot", testItCanGenerateFlagSetForRoot),
			("testItCanGenerateFlagSetSubCommand", testItCanGenerateFlagSetSubCommand),
			("testItCanGenerateFlagSetSubCommandAndDoesOverride", testItCanGenerateFlagSetSubCommandAndDoesOverride),
			("testItCanGetTheRoot", testItCanGetTheRoot),
			("testItCanGetThePathOfACommand", testItCanGetThePathOfACommand)
		]
	}

  override func setUp() {
    setupTestSamples()
  }

  func testItCanGenerateFlagSetForRoot() {
    let fs1 = git.flagSet
    XCTAssertEqual(fs1.flags["d"]!.longName, "debug")
    XCTAssertEqual(fs1.flags["r"]!.longName, "root")
    XCTAssertEqual(fs1.flags["v"]!.longName, "verbose")
    XCTAssertEqual(fs1.flags["verbose"]!.longName, "verbose")
    XCTAssertEqual(fs1.flags["root"]!.longName, "root")
    XCTAssertEqual(fs1.flags["debug"]!.longName, "debug")
  }

  func testItCanGenerateFlagSetSubCommand() {
    let fs1 = show.flagSet

    XCTAssertEqual(fs1.flags["d"]!.longName, "debug")
    XCTAssertEqual(fs1.flags["v"]!.longName, "verbose")
    XCTAssertEqual(fs1.flags["foo"]!.longName, "foo")
    XCTAssertEqual(fs1.flags["remote"]!.longName, "remote")
    XCTAssertEqual(fs1.flags["yy"]!.longName, "yy")
    XCTAssertNil(fs1.flags["xx"])
    XCTAssertNil(fs1.flags["root"])
  }

  func testItCanGenerateFlagSetSubCommandAndDoesOverride() {
    let fs1 = rebase.flagSet

    XCTAssertEqual(fs1.flags["d"]!.longName, "debug")
    XCTAssertEqual(fs1.flags["v"]!.longName, "varvar")
    XCTAssertNil(fs1.flags["root"])
  }

  func testItCanGetTheRoot() {
    let r1 = git.root
    XCTAssertEqual(r1.nameOrEmpty, "git")

    let r2 = show.root
    XCTAssertEqual(r2.nameOrEmpty, "git")
  }

  func testItCanGetThePathOfACommand() {
    let p1 = git.path
    XCTAssertEqual(p1, ["git"])

    let p2 = show.path
    XCTAssertEqual(p2, ["git", "remote", "show"])
  }
}
