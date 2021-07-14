//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by DHwty on 14/07/2021.
//

import XCTest
@testable import WeatherApp

class WeatherViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testChangeLocationUpdatesLocationName() {
        // 1
          let expectation = self.expectation(
            description: "Find location using geocoder")
          // 2
          let viewModel = WeatherViewModel()
          // 3
          viewModel.locationName.bind {
            if $0.caseInsensitiveCompare("Richmond, VA") == .orderedSame {
              expectation.fulfill()
            }
          }
          // 4
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            viewModel.changeLocation(to: "Richmond, VA")
          }
          // 5
          waitForExpectations(timeout: 8, handler: nil)
    }
}
