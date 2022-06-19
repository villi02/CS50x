//
//  Stocks.swift
//  DivDiary
//
//  Created by Villi Arnar on 02/06/2022.
//

import Foundation


func testStockAPI( symbol: String) {
    let url = URL(string: "https://financialmodelingprep.com/api/v3/profile/\(symbol)?apikey=\(Constants.APIKey)")

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
        /*
        let jsonFirst = try! JSONSerialization.jsonObject(with: data)
        print("First type", jsonFirst)
        */
        
        if let jsonSecond = String(data: data, encoding: .utf8) {print("Second type", jsonSecond)
            print(jsonSecond)
            
            
        }

        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
        print(json)
        let ceoName = json[0]["ceo"]! as! String
        print("The CEO is:", ceoName)
        
        let jsonThird = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as! [[String:Any]]
        print(jsonThird)
        let symbol = json[0]["symbol"]! as! String
        print("The symbol is:", symbol)
        print("Employees:", Int(json[0]["fullTimeEmployees"] as! String)!)
        
        let apple = Stock(stockData: jsonThird[0])
        
        print("Should be company symbol:", apple.symbol)
        print("Should be company name:", apple.companyName)
        print("Should be company price:", apple.price)
        print("Should be company IPO date:", apple.ipoDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let date = dateFormatter.string(from: apple.ipoDate!)
        print("Should te company IPO date without time:", date)
        print("Should be company:", apple)
        
        
    }
    task.resume()
}
