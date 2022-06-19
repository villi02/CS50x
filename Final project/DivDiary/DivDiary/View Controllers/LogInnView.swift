
import UIKit
import FirebaseFirestore
import FirebaseAuth

class LogInnView: UIViewController {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInnButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHomescreen() {
        
        let homeViewController =  storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarViewController) as? UITabBarController
        
        view.window?.rootViewController = homeViewController
        view?.window?.makeKeyAndVisible()
        
    }
    
    func setUpElements() {
        // Hides the error label
        errorLabel.alpha = 0
    }
    
    @IBAction func logInnTapped(_ sender: Any) {
        
        // Validate textfields
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            // Unable to sign in
            if error != nil {
                self.showError("Unable to sign in")
            }
            else{
                //testStockAPI()
                self.transitionToHomescreen()
            }
        }
    }
    
}


