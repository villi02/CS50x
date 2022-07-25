//
//  PortfolioManager.swift
//  DivDiary
//
//  Created by Villi Arnar on 08/07/2022.
//

import Foundation
import SwiftUI
import Firebase

class PortfolioManager: ObservableObject {
    @Published var portfolio: [Stock] = []
    
    init() {

        print("Hry")
        fetchPortfolio()
    }
    
    func fetchPortfolio() {
        portfolio.removeAll()
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let ref = db.collection("users").document(userID!)
        Temp.newPortfolio.removeAll()
        
        // Loop to add every stock holding to a temp array
        ref.getDocument { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot?.data() as? Dictionary<String, [String:Any]> { for stockPosition in snapshot {
                
                let symbol = stockPosition.key
                let shareAmount = stockPosition.value["Shares"] as? Int ?? 0
                let price = stockPosition.value["Price"] as? Double ?? 0
                print("hey")
                
                self.addToPortfolio(symbol: symbol, amountShares: shareAmount, sharePrice: price)
                }
            }
        }
        
    }
    
    
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
                self.portfolio.append(Stock(stockData: json[0], amountOfShares: amountShares, sharePrice: sharePrice))
                User.portfolio.append(Stock(stockData: json[0], amountOfShares: amountShares, sharePrice: sharePrice))
            }
            
            print("Done adding to temp portfolio")
            
        }
        task.resume()
    }
     
}


