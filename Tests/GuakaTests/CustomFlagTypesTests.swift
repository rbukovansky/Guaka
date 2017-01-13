//
//  CustomFlagTypes.swift
//  Guaka
//
//  Created by Omar Abdelhafith on 06/11/2016.
//
//

import XCTest
@testable import Guaka

class CustomFlagTypesTests: XCTestCase {

	static var allTests: [(String, (CustomFlagTypesTests) -> () throws -> Void)] {
		return [
			("testItCanSetAFlagWithACustomType", testItCanSetAFlagWithACustomType),
			("testItCanSetAFlagWithACustomTypeThatGeneratesAnError", testItCanSetAFlagWithACustomTypeThatGeneratesAnError),
			("testItCanSetAFlagWithAnEnumWithSuccess", testItCanSetAFlagWithAnEnumWithSuccess),
			("testItCanSetAFlagWithAnEnumWithError", testItCanSetAFlagWithAnEnumWithError)
		]
	}

  func testItCanSetAFlagWithACustomType() {

    struct CustomType: FlagValue {
      let val: String

      static func fromString(flagValue value: String) throws -> CustomType {
        return CustomType(val: value)
      }

      static var typeDescription: String { return "list" }
    }

    let fs = FlagSet(
      flags: [
        Flag(longName: "list", type: CustomType.self, description: ""),
        ]
    )

    let (flags, _) = try! fs.parse(args: expand("--list cat"))

    let flag = flags.keys.first!
    let val = flags.values.first!
    XCTAssertEqual(flag.longName, "list")
    XCTAssertEqual((val as! CustomType).val, "cat")
  }

  func testItCanSetAFlagWithACustomTypeThatGeneratesAnError() {

    struct CustomType: FlagValue {
      let val: String

      static func fromString(flagValue value: String) throws -> CustomType {
        throw FlagValueError.conversionError("cannot convert \(value) to \(typeDescription)")
      }

      static var typeDescription: String { return "list" }
    }

    let fs = FlagSet(
      flags: [
        Flag(longName: "list", type: CustomType.self, description: ""),
        ]
    )

    do {
      _ = try fs.parse(args: expand("--list cat"))
      XCTFail()
    } catch CommandError.incorrectFlagValue(let x, let y) {
      XCTAssertEqual(x, "list")
      XCTAssertEqual(y, "cannot convert cat to list")
    } catch {
      XCTFail()
    }
  }

  func testItCanSetAFlagWithAnEnumWithSuccess() {

    enum Animals: String, FlagValue {
      case dog = "dog"
      case cat = "cat"
      case donkey = "donkey"

      static func fromString(flagValue value: String) throws -> Animals {
        guard let animal = Animals(rawValue: value) else {
          throw FlagValueError.conversionError("Cannot create animal from \(value)")
        }
        return animal
      }

      static var typeDescription: String { return "animal can be (dog, cat, donkey)" }
    }


    let fs = FlagSet(
      flags: [
        Flag(longName: "love", type: Animals.self, description: "", required: true),
        ]
    )

    let (flags, _) = try! fs.parse(args: expand("--love cat"))

    let flag = flags.keys.first!
    let val = flags.values.first!
    XCTAssertEqual(flag.longName, "love")
    XCTAssertEqual((val as! Animals), Animals.cat)
  }

  func testItCanSetAFlagWithAnEnumWithError() {

    enum Animals: String, FlagValue {
      case dog = "dog"
      case cat = "cat"
      case donkey = "donkey"

      static func fromString(flagValue value: String) throws -> Animals {
        guard let animal = Animals(rawValue: value) else {
          throw FlagValueError.conversionError("Cannot create animal from \(value)")
        }
        return animal
      }

      static var typeDescription: String { return "animal can be (dog, cat, donkey)" }
    }


    let fs = FlagSet(
      flags: [
        Flag(longName: "love", type: Animals.self, description: "", required: true),
        ]
    )

    do {
      _ = try fs.parse(args: expand("--love blah"))
      XCTFail()
    } catch CommandError.incorrectFlagValue(let x, let y) {
      XCTAssertEqual(x, "love")
      XCTAssertEqual(y, "Cannot create animal from blah")
    } catch {
      XCTFail()
    }
  }
}
