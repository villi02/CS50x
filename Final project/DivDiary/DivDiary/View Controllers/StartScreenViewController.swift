
import UIKit

class StartScreenViewController: UIViewController {

    
    @IBOutlet weak var logInnButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        //super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        view.backgroundColor = .systemRed
        testStockAPI(symbol: "O")
        
    }
  

}
