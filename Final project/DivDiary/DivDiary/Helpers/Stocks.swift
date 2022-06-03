//
//  Stocks.swift
//  DivDiary
//
//  Created by Villi Arnar on 02/06/2022.
//

import Foundation


func testStockAPI() {
    let url = URL(string: "https://financialmodelingprep.com/api/v3/profile/AAPL?apikey=\(Constants.APIKey)")

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

        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        print(json)
    }
    task.resume()
}
