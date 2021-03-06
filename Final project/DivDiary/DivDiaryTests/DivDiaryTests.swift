//
//  DivDiaryTests.swift
//  DivDiaryTests
//
//  Created by Villi Arnar on 15/06/2022.
//

import XCTest
import DivDiary

class DivDiaryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testsJSONtoStruct() {
        
        let url = URL(string: "https://financialmodelingprep.com/api/v3/profile/AAPL?apikey=474c07c57cc0389e635aa53b7255508a")

        print(url!)
        
        var request = URLRequest(url: url!)

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as! [[String:Any]]
            let symbol = json[0]["symbol"] as! String
            
            
            XCTAssertEqual(symbol, "AAPL", "The stock value is not Apple" )
            
            XCTAssertTrue(symbol == "GOOG")
            
            // Should fail
           
        }
        task.resume()
        
    }

}
