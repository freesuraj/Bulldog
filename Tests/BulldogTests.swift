//
//  BulldogTests.swift
//  BulldogTests
//
//  Created by Suraj Pathak on Nov 19, 2016.
//  Copyright © 2016 iOSCook. All rights reserved.
//

import XCTest
@testable import Bulldog

class BulldogTests: XCTestCase {
    
    var bulldog: Bulldog!
    
    override func setUp() {
        super.setUp()
        if let url = Bundle(for: BulldogTests.self).url(forResource: "Test", withExtension: "json"), let data = try? Data(contentsOf: url), let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) {
            bulldog = Bulldog(json: json)
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGenericType() {
        let value: String? = bulldog.value("search_metadata", "query")
        XCTAssertEqual(value!, "%23freebandnames")
    }
    
    func testString() {
        let value = bulldog.string("search_metadata", "query")
        XCTAssertEqual(value!, "%23freebandnames")
    }
    
    func testInvalid() {
        let invalidValue = bulldog.string("invalidKey", "invalidKey")
        XCTAssertNil(invalidValue)
    }
    
    func testInvalidType() {
        let value = bulldog.int("search_metadata", "query")
        XCTAssertNil(value)
    }
    
    func testInteger() {
        let value = bulldog.int("search_metadata", "count")
        XCTAssertEqual(value!, 4)
    }
    
    func testDouble() {
        let value = bulldog.double("search_metadata", "completed_in")
        XCTAssertEqual(value!, 0.035)
    }
	
	func testIntegerPromised() {
		let value = bulldog.intPromised("raw_value", "string_integer")
		XCTAssertEqual(value!, 322)
		let value1 = bulldog.intPromised("search_metadata", "type")
		XCTAssertNil(value1)
		let value2 = bulldog.intPromised("search_metadata", "count")
		XCTAssertEqual(value2!, 4)
	}
	
	func testDoublePromised() {
		let value = bulldog.doublePromised("raw_value", "string_double")
		XCTAssertEqual(value!, 3.22)
		let value1 = bulldog.doublePromised("search_metadata", "type")
		XCTAssertNil(value1)
		let value2 = bulldog.doublePromised("search_metadata", "completed_in")
		XCTAssertEqual(value2!, 0.035)
	}
	
	func testBulldogReturn() {
		let value = bulldog.bulldog("raw_value")?.string("type")
		XCTAssertEqual(value, "raw")
		
		let valueNil = bulldog.bulldog("raw_value", "nth")
		XCTAssertNil(valueNil)
	}
    
    func testBool() {
        let value = bulldog.bool("search_metadata", "is_test")
        XCTAssertTrue(value)
    }
    
    func testInvalidBool() {
        let value = bulldog.bool("search_metadata", "is_debug")
        XCTAssertFalse(value)
    }
    
    func testArray() {
        let value = bulldog.array("statuses")
        XCTAssertEqual(value!.count, 4)
    }
    
    func testRawJson() {
        let value = bulldog.rawJson("raw_value") as! [String: Any]
        XCTAssertEqual(value["type"] as! String, "raw")
        XCTAssertEqual(value["timer"] as! Double, 0.2)
    }
    
    func testArrayIndex() {
        let value = bulldog.dictionary("statuses", 0)!
        XCTAssertFalse(value["favorited"] as! Bool)
    }
    
    func testArrayIndexOutofBounds() {
        let value = bulldog.dictionary("statuses", 5)
        XCTAssertNil(value)
    }
    
    func testDictionary() {
        let value = bulldog.dictionary("statuses", 0, "metadata") as! [String: String]
        let expected = ["iso_language_code":"en",
                        "result_type":"recent"]
        XCTAssertEqual(value, expected)
    }
    
    func testArrayIndexMore() {
        let value = bulldog.string("statuses", 0, "text")
        XCTAssertEqual(value!, "Aggressive Ponytail #freebandnames")
    }
    
}
