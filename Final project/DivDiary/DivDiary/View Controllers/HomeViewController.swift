
import FirebaseCore
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var SymbolButton: UIButton!
    
    
    @IBOutlet weak var SymbolTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBlue
    }

    @IBAction func SymbolTapped(_ sender: Any) {
        let symbol = SymbolTextField.text
        testStockAPI(symbol: symbol!)
        
    }

}
 
