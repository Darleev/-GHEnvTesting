//
//  GHEnvTestingTests.swift
//  GHEnvTestingTests
//
//  Created by Cyril Cermak on 15.03.21.
//

import XCTest
@testable import GHEnvTesting

class GHEnvTestingTests: XCTestCase {

    override func setUp() {
        
    }
    
    func testLoadsImageInTime() {
        let exp = expectation(description: "Loads image in time")
        DispatchQueue.main.async {
            if let imageUrl = Bundle(for: GHEnvTestingTests.self).url(forResource: "test", withExtension: "jpg") {
                let data = try! Data(contentsOf: imageUrl)
                let image = UIImage(data: data)
                XCTAssertNotNil(image)
                
                exp.fulfill()
            } else {
                fatalError("Image not attached to the tests")
            }
        }
        
        wait(for: [exp], timeout: 1)
    }
    
}
