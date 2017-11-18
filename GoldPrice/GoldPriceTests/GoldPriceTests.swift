//
//  GoldPriceTests.swift
//  GoldPriceTests
//
//  Created by Hassan Bhatti on 16/11/2017.
//  Copyright © 2017 Hassan Bhatti. All rights reserved.
//

import XCTest
import Alamofire
@testable import GoldPrice

class GoldPriceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    

    func testGoldPrice()
    {
        Alamofire.request(Constants.gold_url).responseJSON { response in
           
            print(response.timeline)
            
            self.waitForExpectations(timeout: 30) { (error:Error?) in
                if ((error) != nil)
                {
                    print("Server Timeout Error: \(String(describing: error))")
                }
                print("execute here after delegate called or timeout")
            }
        }
    }
    
    func testSilverPrice()
    {
        Alamofire.request(Constants.silver_url).responseJSON { response in
            
            print(response.timeline)
            
            self.waitForExpectations(timeout: 30) { (error:Error?) in
                if ((error) != nil)
                {
                    print("Server Timeout Error: \(String(describing: error))")
                }
                print("execute here after delegate called or timeout")
            }
        }
    }
    
    func testPlatinumPrice()
    {
        Alamofire.request(Constants.platinum_url).responseJSON { response in
            
            print(response.timeline)
            
            self.waitForExpectations(timeout: 30) { (error:Error?) in
                if ((error) != nil)
                {
                    print("Server Timeout Error: \(String(describing: error))")
                }
                print("execute here after delegate called or timeout")
            }
        }
    }
    
    func testPalladiumPrice()
    {
        Alamofire.request(Constants.palladium_url).responseJSON { response in
            
            print(response.timeline)
            
            self.waitForExpectations(timeout: 30) { (error:Error?) in
                if ((error) != nil)
                {
                    print("Server Timeout Error: \(String(describing: error))")
                }
                print("execute here after delegate called or timeout")
            }
        }
    }



    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
