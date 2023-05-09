//
//  PlanetViewModelTests.swift
//  Week6CombineApiTests
//
//  Created by Payam Karbassi on 08/05/2023.
//

import XCTest
@testable import Week6CombineApi

// Test ideas
// Check if everything is supposed to work
// test different types of NetworkErrorEnum, wrong Url, right url but no data, right url and some data but wrong variable names
// check all variable names
final class PlanetViewModelTests: XCTestCase {
    var planetViewModel: PlanetViewModel!
    override func setUpWithError() throws {
        planetViewModel = PlanetViewModel(combineNetworkManager: FakeNetworkManager())
    }

    override func tearDownWithError() throws {
        planetViewModel = nil
    }

    func testGetList_WhenEveryThingIsExpectedToBeCorrect() throws {
        planetViewModel.getList(apiUrl: "PlanetList")
        let expectation = XCTestExpectation(description: "When we call getList and we are expecting everything to go well.")
        let waitDuration = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration){
            XCTAssertNotNil(self.planetViewModel)
            XCTAssertEqual(self.planetViewModel.fileteredResults.count, 6)
            XCTAssertNil(self.planetViewModel.customError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testGetList_WithWrongUrl() throws {
        planetViewModel.getList(apiUrl: "")
        let expectation = XCTestExpectation(description: "When we call getList with wrong url and expect to get a .invalidUrlError.")
        let waitDuration = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration){
            XCTAssertEqual(self.planetViewModel.fileteredResults.count, 0)
            XCTAssertNotNil(self.planetViewModel.customError)
            XCTAssertEqual(self.planetViewModel.customError, NetworkErrorEnum.invalidUrlError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testGetList_WithEmptyJsonFile() throws {
        planetViewModel.getList(apiUrl: "EmptyPlanetList")
        let expectation = XCTestExpectation(description: "When we call getList and are expecting to get .dataNotFound")
        let waitDuration = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration){
            XCTAssertEqual(self.planetViewModel.fileteredResults.count, 0)
            XCTAssertNotNil(self.planetViewModel.customError)
            XCTAssertEqual(self.planetViewModel.customError,  NetworkErrorEnum.dataNotFoundError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    
    func testGetList_WithInvalidPropertyNameInJsonData() throws {
        planetViewModel.getList(apiUrl: "PlanetListWithWrongPropertyName")
        let expectation = XCTestExpectation(description: "When we call getList and are expecting to get parsingData")
        let waitDuration = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration){
            XCTAssertEqual(self.planetViewModel.fileteredResults.count, 0)
            XCTAssertNotNil(self.planetViewModel.customError)
            //XCTAssertEqual(self.planetViewModel.customError,  NetworkErrorEnum.responseError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testGetList_ForCorrectPropertyDetails() throws {
        planetViewModel.getList(apiUrl: "PlanetList")
        let expectation = XCTestExpectation(description: "When we call getList ")
        let waitDuration = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration){
            let name = self.planetViewModel.results[0].name
            XCTAssertEqual(name, "Tatooine")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


extension PlanetViewModelTests {
    
    func testSearch()throws{
        planetViewModel.getList(apiUrl: "PlanetList")
        let expectation = XCTestExpectation(description: "When we call getList ")
        let waitDuration = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration){
            self.planetViewModel.searchList(with: "")
            let count = self.planetViewModel.fileteredResults.count
            XCTAssertEqual(count, 6)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
}
