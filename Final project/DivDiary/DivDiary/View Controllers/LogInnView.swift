
import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseDatabaseSwift

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
        //self.transitionToHomescreen()
        
        // Validate textfields
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            // Unable to sign in
            if error != nil {
                self.showError("Unable to sign in")
            }
            else{
                //testStockAPI(symbol: "AAPL")
                
                let userID: String = (Auth.auth().currentUser?.uid)!
                var ref: DatabaseReference!
                
                print(userID)

                ref = Database.database().reference()
                
                ref?.child("users").child("buUuCUD0gsJgzfthVmXM").observeSingleEvent(of: .value, with: {(snapshot) in
                    print(snapshot.value as! [String: AnyObject])
                })
                
                /*
                User.init(email_user: currentUser.email, password_user: password, uid_user: currentUser.uid, portfolio_User: currentUser.portfo )
                 */
                
                self.transitionToHomescreen()
            }
        }
    }
    
}


