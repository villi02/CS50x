//
//  TabBars.swift
//  DivDiary
//
//  Created by Villi Arnar on 12/07/2022.
//

import Foundation
import SwiftUI

enum TabBar: CaseIterable {
    case homeView
    case portfolioView
    case dividendVieww
    case accountView
    
    var image: String {
        switch self {
        case .homeView:
            return "house"
        case .portfolioView:
            return "chart.pie.fill"
        case .dividendVieww:
            return "dollarsign.circle"
        case .accountView:
            return "person"
        }
    }
    
    var name: String {
        switch self {
        case .homeView:
            return "Home"
        case .portfolioView:
            return "Portfolio"
        case .dividendVieww:
            return "Dividends"
        case .accountView:
            return "Account"
        }
    }
}
