//
//  PortfolioViewController.swift
//  DivDiary
//
//  Created by Villi Arnar on 10/06/2022.
//

import Foundation
import SwiftUI
import FirebaseCore
import UIKit

class PortfolioViewController: UIViewController {


    @IBOutlet weak var PortfolioTable: UITableView!
    
    let localPortfolio: Array = User.portfolio
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemGreen
        PortfolioTable.delegate = self
        PortfolioTable.dataSource = self
        print(User.portfolio.count)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //PortfolioTable.delegate = self
        //PortfolioTable.dataSource = self
        
    }
    
    
}

extension PortfolioViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.portfolio.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PortfolioTable.dequeueReusableCell(withIdentifier: "StockCell") as! StockTVC
        let stock = localPortfolio[indexPath.row]
        let profit = multiplyDblInt(lhs:stock.shareAmount!, rhs:(stock.price - stock.purchasePrice!))
        
        cell.NameLbl.text = stock.companyName
        cell.PriceLbl.text = stock.price.string
        cell.ProfitLbl.text = "\(profit)"
        cell.SharesLbl.text = stock.symbol
        
        // Need to make cell look good!
        // Todo
        
        return cell
    }
    
}


