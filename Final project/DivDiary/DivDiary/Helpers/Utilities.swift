//
//  Utilities.swift
//  DivDiary
//
//  Created by Villi Arnar on 25/05/2022.
//

import Foundation

class Utilities {
    
    static func isPasswordValid ( password : String) -> Bool{
        
        // Password length 8+, One alphabet character, one special character
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}

struct Temp {
    static var newPortfolio: [Stock] = []
}

func loadUser(){
        // Todo
}

func multiplyDblInt(lhs: Int, rhs: Double) -> Double {
    return Double(lhs) * rhs
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}


/*
 
 
func addToPortfolio(symbol:String, amountShares: Int, sharePrice: Double ) {
    
    let url = URL(string: "https://financialmodelingprep.com/api/v3/profile/\(symbol)?apikey=\(Constants.APIKey)")
    
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
        print("Adding to temp portfolio")
        DispatchQueue.main.async {
            Temp.newPortfolio.append(Stock(stockData: json[0], amountOfShares: amountShares, sharePrice: sharePrice))
        }
        
        print("Done adding to temp portfolio")
        
    }
    task.resume()
}
 */
