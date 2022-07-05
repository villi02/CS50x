//
//  Stock.swift
//  DivDiary
//
//  Created by Villi Arnar on 03/06/2022.
//

import Foundation
import SwiftUI

struct StockNew: Codable {
    
    let symbol: String
    let price: Double
    let beta: Double
    let volAvg: Double
    let mktCap: Double
    let lastDiv: Double
    let range: String
    let changes: Double
    let companyName: String
    let currency: String
    let cik: String
    let isin: String
    let cusp: String
    let exchange: String
    let exchangeShortName: String
    let industry: String
    let website: URL
    let description: String
    let ceo: String
    let sector: String
    let country: String
    let fullTimeEmployees: Int
    let phone: String
    let address: String
    let city: String
    let state: String
    let zip: String
    let dcfDiff: Double
    let dcf: Double
    let image: URL
    let ipoDate: Date?
    let isEtf: Bool
    let isActivelyTrading: Bool
    let isAdr: Bool
    let isFund: Bool
    
    }
