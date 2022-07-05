//
//  Stock.swift
//  DivDiary
//
//  Created by Villi Arnar on 03/06/2022.
//

import Foundation
import SwiftUI

struct Stock {
    
    var symbol: String
    var price: Double
    var beta: Double
    var volAvg: Double
    var mktCap: Double
    var lastDiv: Double
    var range: String
    var changes: Double
    var companyName: String
    var currency: String
    var cik: String
    var isin: String
    var cusp: String
    var exchange: String
    var exchangeShortName: String
    var industry: String
    var website: URL
    var description: String
    var ceo: String
    var sector: String
    var country: String
    var fullTimeEmployees: Int
    var phone: String
    var address: String
    var city: String
    var state: String
    var zip: String
    var dcfDiff: Double
    var dcf: Double
    var image: URL
    var ipoDate: Date?
    var isEtf: Bool
    var isActivelyTrading: Bool
    var isAdr: Bool
    var isFund: Bool
    
    init(stockData:[String:Any] ) {
        symbol = stockData["symbol"] as! String
        price = stockData["price"] as! Double
        beta = stockData["beta"] as! Double
        volAvg = stockData["volAvg"] as! Double
        mktCap = stockData["mktCap"] as! Double
        lastDiv = stockData["lastDiv"] as! Double
        range = stockData["range"] as! String
        changes = stockData["changes"] as! Double
        companyName = stockData["companyName"] as! String
        currency = stockData["currency"] as! String
        cik = stockData["cik"] as! String
        isin = stockData["isin"] as! String
        cusp = stockData["cusip"] as! String
        exchange = stockData["exchange"] as! String
        exchangeShortName = stockData["exchangeShortName"] as! String
        industry =  stockData["industry"] as! String
        let url = stockData["website"] as! String
        website = URL(string: url)!
        description = stockData["description"] as! String
        ceo = stockData["ceo"] as! String
        sector = stockData["sector"] as! String
        country = stockData["country"] as! String
        fullTimeEmployees = Int(stockData["fullTimeEmployees"] as! String)!
        phone = stockData["phone"] as! String
        address = stockData["address"] as! String
        city = stockData["city"] as! String
        state = stockData["state"] as! String
        zip = stockData["zip"] as! String
        dcfDiff = stockData["dcfDiff"] as! Double
        dcf = stockData["dcf"] as! Double
        image = URL(string: stockData["image"] as! String)!
        // Parse to Date
        let dateString = stockData["ipoDate"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        ipoDate = dateFormatter.date(from: dateString)
        
        isEtf = stockData["isEtf"] as! Bool
        isActivelyTrading = stockData["isActivelyTrading"] as! Bool
        isAdr = stockData["isAdr"] as! Bool
        isFund = stockData["isFund"] as! Bool
        }
    
}


