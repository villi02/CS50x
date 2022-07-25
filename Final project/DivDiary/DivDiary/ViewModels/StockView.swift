//
//  StockView.swift
//  DivDiary
//
//  Created by Villi Arnar on 19/06/2022.
//

import Foundation
import SwiftUI



struct StockView: View {
    //PortfolioManager
    
    var body: some View {
        VStack( alignment: .leading) {
            //Text(stock.companyName)
            Text("Company name")
                .accessibilityAddTraits(.isHeader)
                .font(.headline)
            HStack {
                //Label("\(stock.symbol)", systemImage: "person.3")
                Text("Value")
                Text("Return")
                Text("Today")
                
                //Label("\(stock.price)", systemImage: "clock")
                Text("Current price")
            }
            .font(.caption)
            .frame(maxWidth: .infinity)
        }
        .padding()
        
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StockView()
        }
    }
}

