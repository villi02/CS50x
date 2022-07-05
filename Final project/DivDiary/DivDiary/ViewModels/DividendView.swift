//
//  DividendView.swift
//  DivDiary
//
//  Created by Villi Arnar on 20/06/2022.
//

import SwiftUI

struct DividendView: View {
    var body: some View {
        VStack( alignment: .leading) {
            //Text(stock.companyName)
            Text("Company name")
                .accessibilityAddTraits(.isHeader)
                .font(.headline)
            HStack() {
                //Label("\(stock.symbol)", systemImage: "person.3")
                Text("Value")
                Spacer()
                Text("Total recieved")
                Text("Next dividend")
                
                //Label("\(stock.price)", systemImage: "clock")
                Text("Yield (On cost)")
            }
            .font(.caption)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct DividendView_Previews: PreviewProvider {
    static var previews: some View {
        DividendView()
    }
}
