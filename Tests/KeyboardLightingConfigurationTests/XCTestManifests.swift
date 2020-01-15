import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(KeyboardLightingConfigurationTests.allTests),
    ]
}
#endif
