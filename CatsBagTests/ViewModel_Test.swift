//
//  ViewModel_Test.swift
//  CatsBagTests
//
//  Created by Artem Vinogradov on 31.01.2023.
//

import XCTest
@testable import CatsBag

final class ViewModel_Test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ViewModel_folderName_shouldBeEmpty() {
        let vm = ViewModel()
        
        XCTAssertEqual(vm.folderName, "")
        XCTAssertTrue(vm.folderName.isEmpty)
    }
    
    func test_ViewModel_itemName_shouldBeEmpty() {
        let vm = ViewModel()
        
        XCTAssertEqual(vm.itemName, "")
        XCTAssertTrue(vm.itemName.isEmpty)
    }
    
    func test_ViewModel_itemNumber_shouldBeEmpty() {
        let vm = ViewModel()
        
        XCTAssertEqual(vm.itemNumber, "")
        XCTAssertTrue(vm.itemNumber.isEmpty)
    }
    
    func test_ViewModel_itemMeasurement_shouldBeWithItValue() {
        let vm = ViewModel()
        
        XCTAssertEqual(vm.itemMeasurement, "it")
        XCTAssertFalse(vm.itemMeasurement.isEmpty)
    }
    
    func test_ViewModel_itemCategory_shouldBeUncategorized() {
        let vm = ViewModel()
        
        XCTAssertEqual(vm.itemCategory, "Uncategorized")
        XCTAssertFalse(vm.itemCategory.isEmpty)
    }
}
