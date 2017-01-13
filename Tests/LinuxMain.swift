import XCTest
@testable import GuakaTests

XCTMain([
	testCase(ArgTokenTypeTests.allTests),
	testCase(CommandExecutionTests.allTests),
	testCase(CommandHelpTests.allTests),
	testCase(CommandParsingTests.allTests),
	testCase(CommandTests.allTests),
	testCase(CommandTypeRunTests.allTests),
	testCase(CommandTypeTests.allTests),
	testCase(CustomFlagTypesTests.allTests),
	testCase(ErrorTests.allTests),
	testCase(FlagHelpTests.allTests),
	testCase(FlagSetTests.allTests),
	testCase(FlagTests.allTests),
	testCase(HelpGeneratorSubclassingTests.allTests),
])
