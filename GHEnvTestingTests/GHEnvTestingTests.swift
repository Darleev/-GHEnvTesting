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
    
    /// Loading from drive
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
    
    /// Computational power
    func testRedrawsImage() {
        let exp = expectation(description: "Redraws image in time")
        DispatchQueue.main.async {
            if let imageUrl = Bundle(for: GHEnvTestingTests.self).url(forResource: "test", withExtension: "jpg") {
                let data = try! Data(contentsOf: imageUrl)
                if let image = UIImage(data: data) {
                    let drawnImage = self.redraw(image: image, scaledToSize: CGSize(width: 6000, height: 8000))
                    XCTAssertNotNil(drawnImage)
                    exp.fulfill()
                } else {
                    fatalError("Image was not parsable")
                }
            } else {
                fatalError("Image not attached to the tests")
            }
        }
        
        wait(for: [exp], timeout: 5)
    }
    
    func redraw(image:UIImage, scaledToSize newSize:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return newImage
    }
}
