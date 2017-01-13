//
//  ArgTokenTypeTests.swift
//  CommandLine
//
//  Created by Omar Abdelhafith on 30/10/2016.
//
//

import XCTest
@testable import Guaka

class CommandParsingTests: XCTestCase {

	static var allTests: [(String, (CommandParsingTests) -> () throws -> Void)] {
		return [
			("testItCanGetACommandWithMultipleArguments", testItCanGetACommandWithMultipleArguments),
			("testItCanGetACommand1", testItCanGetACommand1),
			("testItCanGetACommand2", testItCanGetACommand2),
			("testItCanGetACommand3", testItCanGetACommand3),
			("testItCanGetACommand4", testItCanGetACommand4),
			("testItCanGetACommand5", testItCanGetACommand5),
			("testItCanGetACommand6", testItCanGetACommand6),
			("testItCanGetACommand7", testItCanGetACommand7),
			("testItCanGetACommand8", testItCanGetACommand8),
			("testItCanGetACommand9", testItCanGetACommand9),
			("testItCanGetACommand10", testItCanGetACommand10),
			("testItCanGetACommand11", testItCanGetACommand11),
			("testItCanGetACommand12", testItCanGetACommand12),
			("testItCanGetACommand13", testItCanGetACommand13),
			("testItCanGetACommandEvenIfUsageIsLong", testItCanGetACommandEvenIfUsageIsLong)
		]
	}


  override func setUp() {
    setupTestSamples()
  }

  func testItCanGetACommandWithMultipleArguments() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["-vd1", "-v", "--bar", "1", "remote", "--foo", "222", "show"])

    XCTAssertEqual(command.nameOrEmpty, "show")
    XCTAssertEqual(args, ["-vd1", "-v", "--bar", "1", "--foo", "222"])
  }

  func testItCanGetACommand1() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["-vd1", "-v", "--bar", "1", "remote", "--foo", "show"])

    XCTAssertEqual(command.nameOrEmpty, "remote")
    XCTAssertEqual(args, ["-vd1", "-v", "--bar", "1", "--foo", "show"])
  }

  func testItCanGetACommand2() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["-vd1", "-v", "--bar", "remote"])

    XCTAssertEqual(command.nameOrEmpty, "git")
    XCTAssertEqual(args, ["-vd1", "-v", "--bar", "remote"])
  }

  func testItCanGetACommand3() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["-v", "-w", "remote"])

    XCTAssertEqual(command.nameOrEmpty, "git")
    XCTAssertEqual(args, ["-v", "-w", "remote"])
  }

  func testItCanGetACommand4() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["-v", "-w", "1", "remote"])

    XCTAssertEqual(command.nameOrEmpty, "remote")
    XCTAssertEqual(args, ["-v", "-w", "1"])
  }

  func testItCanGetACommand5() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["-v", "-t", "remote"])

    XCTAssertEqual(command.nameOrEmpty, "remote")
    XCTAssertEqual(args, ["-v", "-t"])
  }

  func testItCanGetACommand6() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["remote", "--xx"])

    XCTAssertEqual(command.nameOrEmpty, "remote")
    XCTAssertEqual(args, ["--xx"])
  }

  func testItCanGetACommand7() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["--xx", "remote"])

    XCTAssertEqual(command.nameOrEmpty, "git")
    XCTAssertEqual(args, ["--xx", "remote"])
  }

  func testItCanGetACommand8() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["--xx=1", "remote"])

    XCTAssertEqual(command.nameOrEmpty, "remote")
    XCTAssertEqual(args, ["--xx=1"])
  }

  func testItCanGetACommand9() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["--bar", "1", "remote"])

    XCTAssertEqual(command.nameOrEmpty, "remote")
    XCTAssertEqual(args, ["--bar", "1"])
  }

  func testItCanGetACommand10() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["remote", "--bar", "1"])

    XCTAssertEqual(command.nameOrEmpty, "remote")
    XCTAssertEqual(args, ["--bar", "1"])
  }

  func testItCanGetACommand11() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["--xx", "first", "remote", "second"])

    XCTAssertEqual(command.nameOrEmpty, "remote")
    XCTAssertEqual(args, ["--xx", "first", "second"])
  }

  func testItCanGetACommand12() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["remote", "--yy", "show"])

    XCTAssertEqual(command.nameOrEmpty, "remote")
    XCTAssertEqual(args, ["--yy", "show"])
  }

  func testItCanGetACommand13() {
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["remote", "show", "--yy"])

    XCTAssertEqual(command.nameOrEmpty, "show")
    XCTAssertEqual(args, ["--yy"])
  }

  func testItCanGetACommandEvenIfUsageIsLong() {
    show.usage = "show bla bla"
    let (command, args) = actualCommand(forCommand: git,
                                        arguments: ["remote", "show", "--yy"])
    
    XCTAssertEqual(command.nameOrEmpty, "show")
    XCTAssertEqual(args, ["--yy"])
  }
  
}
