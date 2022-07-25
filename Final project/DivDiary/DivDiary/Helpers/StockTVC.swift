//
//  StockTVC.swift
//  DivDiaryTests
//
//  Created by Villi Arnar on 12/07/2022.
//

import UIKit

class StockTVC: UITableViewCell {

    @IBOutlet weak var StockView: UIView!
    
    @IBOutlet weak var NameLbl: UILabel!
    
    @IBOutlet weak var SharesLbl: UILabel!
    
    @IBOutlet weak var PriceLbl: UILabel!
    
    @IBOutlet weak var ProfitLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
