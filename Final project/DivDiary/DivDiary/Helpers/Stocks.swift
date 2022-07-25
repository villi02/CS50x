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
        
        /*
        if let jsonSecond = String(data: data, encoding: .utf8) {print("Second type", jsonSecond)
            print(jsonSecond)
          
            
        }
         */
        
        
         let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
        /*
        print(json)
        let ceoName = json[0]["ceo"]! as! String
        print("The CEO is:", ceoName)
         */
        
        
        let jsonThird = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as! [[String:Any]]
        let symbol = json[0]["symbol"]! as! String
        print("The symbol is:", symbol)
        print("Employees:", Int(json[0]["fullTimeEmployees"] as! String)!)
        
        writeToFile(stockJson: data)
        
        let apple = Stock(stockData: jsonThird[0])
        
        print("Should be company symbol:", apple.symbol)
        print("Should be company name:", apple.companyName)
        print("Should be company price:", apple.price)
        print("Should be company IPO date:", apple.ipoDate as Any)

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let date = dateFormatter.string(from: apple.ipoDate!)
        print("Should te company IPO date without time:", date)
        //print("Should be company:", apple)
        
        //writeToMemory(stockToBeAdded: apple)
        print("Writing to memory....")
        User.portfolio.append(apple)
        print("Finished writing to memory...")
        //print(User.stocks)

    }
    
    task.resume()
    print("hello there")
}

func writeToFile(stockJson: Data?) -> Void {

    if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask).first {
        let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
        do {
            try stockJson!.write(to: pathWithFilename)
        } catch {
            // Handle error
        }
    }
}

func writeToMemory(stockToBeAdded: Stock) {
    print("Writing to memory....")
    User.portfolio.append(stockToBeAdded)
    print("Finished writing to memory...")
}

func getStockObj (symbol: String) -> Stock {
    let url = URL(string: "https://financialmodelingprep.com/api/v3/profile/\(symbol)?apikey=\(Constants.APIKey)")
    
    var jsonData: [String: Any]?
    var request = URLRequest(url: url!)

    request.addValue("application/json", forHTTPHeaderField: "Accept")
    _ = URLSession.shared.dataTask(with: url!) { data, response, error in
         
        
        guard error == nil else {
            print(error!)
            return
        }
        guard let data = data else {
            print("Data is empty")
            return
        }

        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
        print(json)
        
        let jsonThird = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as! [[String:Any]]
        jsonData = jsonThird[0]
        
    }
    return Stock(stockData: jsonData!)
}

/*
func getData(symbol: String) {
    
    let url = URL(string: "https://financialmodelingprep.com/api/v3/profile/\(symbol)?apikey=\(Constants.APIKey)")

    
    let task = URLSession.shared.dataTask(with: url!, completionHandler: {data, response, error in
        
        guard let data = data, error == nil else {
            print("something went wrong")
            return
        }
        
        // Have data
        var stock: StockNew?
        do {
            stock = try JSONDecoder().decode(StockNew.self, from: data)
        }
        catch {
            print("Failed to convert \(error.localizedDescription)")
        }
        
        guard let json = stock else {
            return
        }
        print(json.companyName)
    })
        task.resume()
}
*/

