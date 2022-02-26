import Firebase

import UIKit

class LogInnView: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var logInnButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        // Hides the error label
        errorLabel.alpha = 0
    }
    
    @IBAction func logInnTapped(_ sender: Any) {
    }
    
}


